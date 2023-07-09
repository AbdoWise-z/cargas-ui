import 'package:cargas/base.dart';
import 'package:cargas/pages/Shop/ShopItemsWidget.dart';
import 'package:flutter/material.dart';
import 'package:cargas/widget/ThemedSearchBar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        ListView(
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
                  duration: const Duration(milliseconds: 100,),
                  child: SizedBox(
                    width: currentCart.items.isEmpty ? 0.0 : null,
                    child: Row(
                      children: [
                        Stack(
                          alignment: const Alignment(1, 1),
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.shopping_cart_outlined),
                            ),
                            Padding(
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
      ],
    );
  }
}

