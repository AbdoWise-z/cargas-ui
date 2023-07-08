import 'package:cargas/pages/Map.dart';
import 'package:flutter/material.dart';
import 'base.dart';

void main() {
  runApp(const CargasApp());
}

class CargasApp extends StatelessWidget {
  const CargasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ContainerHomePage(title: 'Cargas'),
    );
  }
}


class ContainerHomePage extends StatefulWidget {
  const ContainerHomePage({super.key, required this.title});
  final String title;

  @override
  State<ContainerHomePage> createState() => _ContainerHomePageState();
}

class _ContainerHomePageState extends State<ContainerHomePage> {
  int _s = 0;
  void setSelected(int s){
    //maybe change the title / apply theme based on the selected page here
    setState(() {
      _s = s;
    });
  }

  @override
  void initState() {
    super.initState();
    setSelected(0);
  }

  static const List<Widget> _pages = [
    MapPage(),
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
      body: _pages.length <= _s ? Center(child: Text("TODO (tab_index = $_s)"),) : _pages[_s],
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
              selected: _s == 0,
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
              selected: _s == 1,
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
              selected: _s == 2,
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
                selected: _s == 7,
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
              title: const Text('Shop'),
              selected: _s == 3,
              onTap: () {
                // Update the state of the app
                setSelected(3);
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
              selected: _s == 4,
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
              selected: _s == 5,
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
              selected: _s == 6,
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
