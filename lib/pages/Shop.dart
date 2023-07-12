import 'package:cargas/CartItem.dart';
import 'package:cargas/ShopItem.dart';
import 'package:cargas/base.dart';
import 'package:cargas/pages/Shop/ShopItemsWidget.dart';
import 'package:cargas/widget/LoadingCard.dart';
import 'package:flutter/material.dart';
import 'package:cargas/widget/ThemedSearchBar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool _loading = false;
  String _loadingMessage = "looooooooooooooooooooooooooooooooooooooooooooo";

  void _sendRequest() async {
    setState(() {
      _loading = true;
      _loadingMessage = "Completing you purchase , please wait ..";
    });

    String requestUrl = "$ServerAddress/order";

    try {
      print("Running: $requestUrl");

      List<Map> items = [];
      for (CartItem item in currentCart.items){
        items.add({
          "itemCode": item.item.itemCode,
          "Quantity": item.quantity,
        });
      }

      var res = await http.post(Uri.parse(requestUrl) ,
        body : jsonEncode({
          "token" : accountToken,
          "items" : items,
        }),
      );

      print(res.body);

      Map result = jsonDecode(res.body);
      if (result["result"] == 0) {
        setState(() {
          _loading = false;
          _loadingMessage = "Completing you purchase , please wait ..";
          _checkout = false;
          currentCart.items.clear();

          const snackBar = SnackBar(
            content: Text('Purchase Complete'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });


      }else{
        print("REQUESTS ERROR !!!");
      }
    }catch (e){
      print(e);
    }

    setState(() {
      _loading = false;
      _loadingMessage = "Completing you purchase , please wait ..";
      currentCart.items.clear();

      const snackBar = SnackBar(
        content: Text('Failed to purchase'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });


  }

  String _searchText = "";
  bool _checkout = false;

  Future<void> _refreshShop() async {
    String shopUrl = "$ServerAddress/shop?token=$accountToken";
    shopItems.clear();
    try {
      print("Running: $shopUrl");
      var res = await http.get(Uri.parse(shopUrl));
      print(res.body);

      Map data = jsonDecode(res.body);
      if (data["result"] == 0){
        List l = data["shop"];
        for (var a in l){
          a = jsonDecode(a);
          print(a);
          shopItems.add(
            ShopItem(
              name: a["name"],
              itemDisc: a["itemDisc"],
              image: a["image"],
              imageUrl: a["imageUrl"],
              itemCode: a["itemCode"],
              price: double.parse(a["price"].toString()),
              itemType: a["itemType"],
            ),
          );
        }

        print("ShopSize = ${shopItems.length}");
      } else {
        print("SHOR ERROR !!!");
      }

    }catch (e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var element in currentCart.items) {
      totalPrice += element.quantity * element.item.price;
    }

    if (_checkout){
      if (currentCart.items.isEmpty) _checkout = false;
    }

    return Stack(
      children:[
        IgnorePointer(
          ignoring: _checkout,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: !_checkout ? 1 : 0.0,
            child: LiquidPullToRefresh(
              animSpeedFactor: 3,
              springAnimationDurationInMilliseconds: 500,
              onRefresh: _refreshShop,
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
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300,),
                        child: SizedBox(
                          width: currentCart.items.isEmpty ? 0.0 : null,
                          child: Row(
                            children: [
                              Stack(
                                alignment: const Alignment(1, 1),
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      //to check out
                                      setState(() {
                                        _checkout = true;
                                      });
                                    },
                                    icon: const Icon(Icons.shopping_cart_outlined),
                                  ),
                                  IgnorePointer(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.0),
                                          color: const Color.fromARGB(216, 131, 215, 100),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                          child: Text(
                                            "${currentCart.items.length}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShopItemsWidget(
                      filter: _searchText,
                      onCartChanged: () {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: !_checkout,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: _checkout ? 1 : 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        setState(() {
                          _checkout = false;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),

                    const SizedBox(width: 24,),

                    const Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 12,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "Item",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Row(
                          children: const [
                            Text(
                              "Qte",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(child: SizedBox(),),
                            Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  color: Colors.black38,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView(
                    children: currentCart.items.map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Row(
                        children: [
                          IconButton(
                            tooltip: "Remove from cart",
                            padding: EdgeInsets.zero,
                            iconSize: 18,
                            splashRadius: 20,
                            color: Colors.red,
                            onPressed: (){
                              currentCart.items.remove(e);
                              setState(() {
                                _checkout = currentCart.items.isNotEmpty;
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              e.item.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),

                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  "${e.quantity}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const Expanded(child: SizedBox(),),

                                Text(
                                  "${e.quantity * e.item.price}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ) ,),
                        ],
                      ),
                    )).toList(),
                  ),
                ),

                const Divider(
                  color: Colors.black38,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child:  Text(
                          "$totalPrice L.E.",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: (){
                    if (currentCart.items.isNotEmpty && !_loading) {
                      _loading = true;
                      _sendRequest();
                    }
                  },
                  child: const Text("Confirm Order"),
                ),

              ],
            ),
          ),
        ),
        Visibility(
          visible: _loading,
          child: AbsorbPointer(
            child: Center(child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LoadingCard(msg: _loadingMessage),
            )),
          ),
        ),
      ],
    );
  }
}