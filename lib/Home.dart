
import 'dart:convert';

import 'package:cargas/ShopItem.dart';

import 'package:cargas/pages/Account.dart';
import 'package:cargas/pages/Requests.dart';
import 'package:cargas/pages/Shop.dart';
import 'package:cargas/pages/Map.dart';

import 'package:cargas/widget/LoadingCard.dart';
import 'base.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ContainerHomePage extends StatefulWidget {

  ContainerHomePage({super.key, required this.title});
  String title;
  double appBarCurve = 30;
  double appBarElevation = 6;
  Color appBarColor = Colors.green;

  @override
  State<ContainerHomePage> createState() => _ContainerHomePageState();
}

class _ContainerHomePageState extends State<ContainerHomePage> {
  int _selectedPage = 0;
  void setSelected(int s){
    //maybe change the title / apply theme based on the selected page here
    widget.title = "No title";
    widget.appBarCurve = 30;
    widget.appBarElevation = 6;
    widget.appBarColor = Colors.green;

    if (s == 3){
      widget.title = "Shop";
      widget.appBarCurve = 0;
    }
    if (s == 2){
      widget.title = "Account";
      widget.appBarColor = Colors.transparent;
      widget.appBarElevation = 0;
    }

    if (s == 8){
      widget.title = "Requests";
      widget.appBarCurve = 0;
    }

    setState(() {
      _selectedPage = s;
    });
  }

  bool _loading = false;
  String _loadingMessage = "";

  void doLogout() async {
    setState(() {
      _loadingMessage = "Logging out ..";
      _loading = true;
    });

    Navigator.pushReplacementNamed(context, "/login");

  }

  void loadData() async {
    setState(() {
      _loadingMessage = "Loading...";
      _loading = true;
    });

    //TODO: load everything here

    String shopUrl = "$ServerAddress/shop?token=$accountToken";
    String profileUrl = '$ServerAddress/profile';

    try {
      shopItems.clear();
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

      print("Running: $profileUrl");
      res = await http.post(Uri.parse(profileUrl) ,
        body : jsonEncode({
          "token" : accountToken,
        }),
      );
      print(res.body);

      Map info = jsonDecode(res.body);
      if (info["result"] == 0) {
        Map profile = jsonDecode(info["info"]);
        name = profile["name"];
        phoneNumber = profile["phone"];
        address = profile["address"];
        balance = double.parse(profile["balance"].toString());
      }else{
        print("PROFILE ERROR !!!");
      }

    }catch (e){
      print(e);
    }

    setState(() {
      _loadingMessage = "Loading...";
      _loading = false;
    });

  }

  @override
  void initState() {
    super.initState();
    loadData();
    setSelected(0);
  }

  static final List<Widget> _pages = [
    Text("map"), //map
    Text("Hmmmmmmmmmm"),
    AccountPage(),
    ShopPage(),
    Text("Hmmmmmmmmmm"),
    Text("Hmmmmmmmmmm"),
    Text("Hmmmmmmmmmm"),
    Text("Hmmmmmmmmmm"),
    RequestsPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Scaffold(
          appBar: AppBar(
            backgroundColor: widget.appBarColor,
            elevation: widget.appBarElevation,
            title: Text(widget.title),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(widget.appBarCurve),
                  bottomRight: Radius.circular(widget.appBarCurve),
                )
            ),
          ),
          body: _pages.length <= _selectedPage ? Center(child: Text("TODO (tab_index = $_selectedPage)"),) : _pages[_selectedPage],
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                  ),
                  child: Image(image: AssetImage("assets/images/cargas_logo_large.png")),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Basic",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Map'),
                  selected: _selectedPage == 0,
                  onTap: () {
                    // Update the state of the app
                    setSelected(0);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.announcement_outlined),
                  title: const Text('News'),
                  selected: _selectedPage == 1,
                  onTap: () {
                    // Update the state of the app
                    setSelected(1);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.account_circle_outlined),
                  title: const Text('Account'),
                  selected: _selectedPage == 2,
                  onTap: () {
                    // Update the state of the app
                    setSelected(2);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),

                Visibility(
                  visible: true,
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    selected: _selectedPage == 7,
                    onTap: () {
                      Navigator.pop(context);
                      doLogout();
                    },
                  ),
                ),
                const Divider() ,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Marketplace",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: Row(
                    children: [
                      const Text("Shop"),
                      const Expanded(child: SizedBox()) ,
                      Visibility(
                        visible: currentCart.items.length > 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color.fromARGB(50, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                            child: Text(
                                "${currentCart.items.length}"
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  selected: _selectedPage == 3,
                  onTap: () {
                    // Update the state of the app
                    setSelected(3);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.mobile_friendly),
                  title: const Text('Requests'),
                  selected: _selectedPage == 8,
                  onTap: () {
                    // Update the state of the app
                    setSelected(8);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                const Divider() ,

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Support",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.chat_outlined),
                  title: const Text('Contact us'),
                  selected: _selectedPage == 4,
                  onTap: () {
                    // Update the state of the app
                    setSelected(4);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_support_outlined),
                  title: const Text('Q&A'),
                  selected: _selectedPage == 5,
                  onTap: () {
                    // Update the state of the app
                    setSelected(5);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About company'),
                  selected: _selectedPage == 6,
                  onTap: () {
                    // Update the state of the app
                    setSelected(6);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
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
