import 'package:cargas/Home.dart';
import 'package:cargas/ShopItem.dart';
import 'package:cargas/pages/Map.dart';
import 'package:flutter/material.dart';
import 'base.dart';

void main() {
  // adding dummy values for testing ..
  shopItems.add(ShopItem(
    name: 'AOZ',
    itemDisc: "Ayaka AyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyaka",
    price: 15.0,
    image: -1,
    imageUrl: "https://i.imgur.com/foIacFa.png",
    itemCode: "54894848784",
    itemType: -1,
  ));

  shopItems.add(ShopItem(
    name: 'AOZ',
    itemDisc: "Ayaka AyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyaka",
    price: 15.0,
    image: -1,
    imageUrl: "https://i.imgur.com/foIacFa.png",
    itemCode: "54894848784",
    itemType: -1,
  ));

  shopItems.add(ShopItem(
    name: 'AOZ',
    itemDisc: "Ayaka AyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyaka",
    price: 15.0,
    image: -1,
    imageUrl: "https://i.imgur.com/foIacFa.png",
    itemCode: "54894848784",
    itemType: -1,
  ));

  shopItems.add(ShopItem(
    name: 'AOZ',
    itemDisc: "Ayaka AyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyakaAyaka",
    price: 15.0,
    image: -1,
    imageUrl: "https://i.imgur.com/foIacFa.png",
    itemCode: "54894848784",
    itemType: -1,
  ));

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
      home: ContainerHomePage(title: 'Cargas'),
    );
  }
}


