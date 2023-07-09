
import 'package:cargas/CartItem.dart';
import 'package:cargas/pages/Account.dart';
import 'package:cargas/pages/Login.dart';

import 'package:cargas/pages/Shop.dart';
import 'package:cargas/pages/Map.dart';
import 'base.dart';

import 'package:flutter/material.dart';

class ContainerHomePage extends StatefulWidget {
  ContainerHomePage({super.key, required this.title});
  String title;

  @override
  State<ContainerHomePage> createState() => _ContainerHomePageState();
}

class _ContainerHomePageState extends State<ContainerHomePage> {
  int _selectedPage = 0;
  void setSelected(int s){
    //maybe change the title / apply theme based on the selected page here
    widget.title = "No title";
    if (s == 3){
      widget.title = "Shop";
    }
    if (s == 2){
      widget.title = "Account";
    }
    
    setState(() {
      _selectedPage = s;
    });
  }

  @override
  void initState() {
    super.initState();
    setSelected(0);
  }

  static List<Widget> _pages = [
    Login(),
    Text("Hmmmmmmmmmm"),
    AccountPage(),
    ShopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
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
              child: Image(image: AssetImage("assests/images/cargas_logo_large.png")),
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
              visible: isLoggedIn(),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                selected: _selectedPage == 7,
                onTap: () {
                  // Update the state of the app
                  setSelected(7);
                  // Then close the drawer
                  Navigator.pop(context);
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
    );
  }
}
