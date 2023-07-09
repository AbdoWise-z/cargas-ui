
import 'package:cargas/CartItem.dart';
import 'package:cargas/ShopItem.dart';
import 'package:cargas/base.dart';
import 'package:cargas/pages/Shop/ShopItemWidget.dart';
import 'package:flutter/material.dart';

class ShopItemsWidget extends StatefulWidget {
  final String filter;
  void Function() onCartChanged;
  ShopItemsWidget({Key? key , required this.filter , required this.onCartChanged}) : super(key: key);

  @override
  State<ShopItemsWidget> createState() => _ShopItemsWidgetState();
}

class _ShopItemsWidgetState extends State<ShopItemsWidget> {
  int _id = 0;
  @override
  Widget build(BuildContext context) {

    List<ShopItem> items = [];
    items.addAll(shopItems);

    items.retainWhere((element) => element.name.toLowerCase().contains(widget.filter.toLowerCase()) || element.itemDisc.toLowerCase().contains(widget.filter.toLowerCase()));

    return Column(
      children: items.map((e) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: ShopItemWidget(
            item: e ,
            onAddedToCart: (ShopItem it , int count) {
              int id = _id++;
              currentCart.items.add(CartItem(
                item: it,
                quantity: count,
                ID: id,
              ));
              widget.onCartChanged();

              final snackBar = SnackBar(
                content: const Text('Added to cart'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    currentCart.items.removeWhere((element) => element.ID == id);
                    widget.onCartChanged();
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
        ),
      )).toList(),
    );
  }
}
