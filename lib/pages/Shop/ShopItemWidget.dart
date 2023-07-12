import 'package:cargas/ShopItem.dart';
import 'package:flutter/material.dart';

class ShopItemWidget extends StatefulWidget {

  final ShopItem item;
  void Function(ShopItem , int) onAddedToCart;

  ShopItemWidget({Key? key , required this.item , required this.onAddedToCart}) : super(key: key);

  @override
  State<ShopItemWidget> createState() => _ShopItemWidgetState();
}

class _ShopItemWidgetState extends State<ShopItemWidget> {
  bool _opened = false;
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: InkWell(
        onTap: () {
          _opened = !_opened;
          setState(() {
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      widget.item.imageUrl,
                      fit: BoxFit.fill,
                      width: 80,
                    ), //TODO : add asset images!!!
                  ),
                  const SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8,),

                      Text(
                        widget.item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87
                        ),
                      ),

                      const SizedBox(height: 4,),

                      Text(
                        widget.item.itemType < 0 ? "الغالي ملهوش سعر" : "${widget.item.price} L.E",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black54
                        ),
                      ),
                      Text(
                        widget.item.itemType == 0 ? "Car Oil" : widget.item.itemType == 1 ? "Truck Oil" : "Engineer",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  )
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 100),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: _opened ? 1 : 0.0,
                  child: SizedBox(
                    height: _opened ? null : 0.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                            const Text(
                              "Discription",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Expanded(child: SizedBox()),

                            Text(
                              widget.item.itemCode,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8,),

                        RichText(
                          text: TextSpan(
                            text: widget.item.itemDisc,
                            style: DefaultTextStyle.of(context).style,
                          )
                        ),

                        const SizedBox(height: 14,),

                        const Text(
                          "Order",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            const Text(
                              "Count",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            IconButton(
                              onPressed: (){
                                if (_count > 1){
                                  _count--;
                                }
                                setState(() {});
                              },
                              icon: const Icon(Icons.chevron_left),
                            ),
                            Text(
                              "$_count",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                if (_count < 999){
                                  _count++;
                                }
                                setState(() {});
                              },
                              icon: const Icon(Icons.chevron_right),
                            ),

                            const Expanded(child: SizedBox(),),

                            Text(
                              "${widget.item.price * _count} L.E.",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Expanded(child: SizedBox(),),

                            TextButton(
                              onPressed: (){
                                widget.onAddedToCart(widget.item , _count);
                                setState(() {
                                  _opened = false;
                                });
                              },
                              child: const Text(
                                "Add to cart",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
