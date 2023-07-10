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
  bool _checkout = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var element in currentCart.items) {
      totalPrice += element.quantity * element.item.price;
    }

    return Stack(
      children:[
        IgnorePointer(
          ignoring: _checkout,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: !_checkout ? 1 : 0.0,
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

                    SizedBox(width: 24,),

                    Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                SizedBox(height: 12,),

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

                Container(
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
                          style: TextStyle(
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
                    //TODO: backend stuff here
                    //should send the request to the backend server to process it
                    setState(() {
                      currentCart.items.clear();
                      _checkout = false;
                    }); //for now , I just reset the shop ...
                  },
                  child: const Text("Confirm Order"),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}