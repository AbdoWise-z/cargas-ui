import 'package:flutter/cupertino.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Still needs a key to activated Google-Map"),
    );
  }
}
