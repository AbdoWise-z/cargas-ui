import 'package:cargas/CartItem.dart';
import 'package:cargas/Request.dart';
import 'package:cargas/base.dart';
import 'package:cargas/pages/Reuqest/RequestItem.dart';
import 'package:cargas/widget/ThemedSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {

  List<Request> requests = [];
  List<Request> finishedRequests = [];

  void _delete(Request request) async {
    String requestUrl = "$ServerAddress/delete_order";

    try {
      print("Running: $requestUrl");

      var res = await http.post(Uri.parse(requestUrl),
        body: jsonEncode({
          "token": accountToken,
          "code": request.requestCode
        }),
      );
      print(res.body);
      Map result = jsonDecode(res.body);
      if (result["result"] == 0) {
        requests.remove(request);
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refreshRequests() async {
    requests.clear();
    finishedRequests.clear();

    String requestUrl = "$ServerAddress/orders";

    try {
      print("Running: $requestUrl");

      var res = await http.post(Uri.parse(requestUrl) ,
        body : jsonEncode({
          "token" : accountToken,
        }),
      );
      print(res.body);
      Map result = jsonDecode(res.body);
      if (result["result"] == 0) {
        List items = result["orders"];
        for (var a in items){
          a = jsonDecode(a);
          List<RequestedShopItem> aa = [];
          List orderItems = a["items"];
          for (var k in orderItems){
            //k = jsonDecode(k);
            aa.add(
              RequestedShopItem(
                code: k["itemCode"],
                quantity: k["Quantity"],
              )
            );
          }

          String dateStr = a["time"];
          if (a["statues"] >= 4) {
            finishedRequests.add(
              Request(state: a["statues"],
                requestCode: a["code"],
                items: aa,
                date: DateTime.parse(dateStr)),
            );
          } else {
            requests.add(
              Request(state: a["statues"],
                  requestCode: a["code"],
                  items: aa,
                  date: DateTime.parse(dateStr)),
            );
          }
        }

        print("Requests = ${requests.length}");
      }else{
        print("REQUESTS ERROR !!!");
      }
    }catch (e){
      print(e);
    }

    setState(() {
      });
  }

  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _refreshRequests();
  }

  @override
  Widget build(BuildContext context) {

    List<Request> view = [];
    view.addAll(requests);
    view.retainWhere((element) => element.requestCode.contains(_searchText));

    return LiquidPullToRefresh(
      animSpeedFactor: 3,
      springAnimationDurationInMilliseconds: 500,
      onRefresh: _refreshRequests,
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ThemedSearchBar(
                    onEdit: (str) {
                      _searchText = str;
                      setState(() {});
                    },
                    onSuggestionSelected: (str) {
                      _searchText = str;
                    },
                    onEnterPressed: () {
                      //do nothing
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                const Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),

                const SizedBox(height: 8,),

                Column(
                  children: requests.isNotEmpty ? requests.map((e) => Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,8,0,0),
                    child: RequestItem(request: e , onDelete: () => _delete(e),),
                  )).toList(growable: false) : [
                    const Text(
                      "No requests yet",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8,),

                const Text(
                  "Finished",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(height: 8,),

                Column(
                  children: finishedRequests.isNotEmpty ? finishedRequests.map((e) => Padding(
                    padding: const EdgeInsets.fromLTRB(0.0 , 8, 0 ,0),
                    child: RequestItem(request: e , onDelete: () => _delete(e),),
                  )).toList(growable: false) : [
                    const Text(
                      "No finished requests yet",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
