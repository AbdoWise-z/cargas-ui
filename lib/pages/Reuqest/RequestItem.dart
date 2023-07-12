import 'package:cargas/Request.dart';
import 'package:cargas/base.dart';
import 'package:flutter/material.dart';

class RequestItem extends StatefulWidget {
  final Request request;
  final void Function() onDelete;

  const RequestItem({super.key , required this.request , required this.onDelete});

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {

    Color statuesColor = Colors.transparent;
    String statuesStr  = "";

    switch (widget.request.state){
      case 0: //waiting
        statuesColor = Colors.grey;
        statuesStr = "Waiting";
        break;
      case 1: //processing
        statuesColor = Colors.blueAccent;
        statuesStr = "Processing";
        break;
      case 2: //delivering
        statuesColor = Colors.orangeAccent;
        statuesStr = "Delivering";
        break;
      case 4: //finished
        statuesColor = Colors.greenAccent;
        statuesStr = "Finished";
        break;
      case 5: //rejected
        statuesColor = Colors.redAccent;
        statuesStr = "Rejected";
        break;
      case 6: //rejected out of stock
        statuesColor = Colors.redAccent;
        statuesStr = "Rejected : Stock";
        break;
      case 7: //rejected due balance
        statuesColor = Colors.redAccent;
        statuesStr = "Rejected : balance";
        break;
    }

    return Material(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: InkWell(
        onTap: () {
          _opened = !_opened;
          setState(() {});
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 6,),

                      Text(
                        widget.request.requestCode,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Expanded(child: SizedBox()),

                      Text(
                        "${widget.request.date.year}-${widget.request.date.month}-${widget.request.date.day} ${widget.request.date.hour}:${widget.request.date.minute}:${widget.request.date.second}",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: statuesColor,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        child: Text(
                          statuesStr,
                        ),
                      ),

                      const Expanded(child: SizedBox()),


                      Visibility(
                        visible: widget.request.state < 4,
                        child: IconButton(
                          onPressed: widget.onDelete,
                          icon: const Icon(Icons.delete_outline_outlined),
                          color: Colors.red,
                        ),
                      ),

                    ],
                  ),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  "Item code",
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Divider(
                          color: Colors.black38,
                        ),

                        Column(
                          children: widget.request.items.map((e) => Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    e.code,
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
                                    ],
                                  ) ,),
                              ],
                            ),
                          )).toList(),
                        ),

                        const SizedBox(height: 8,),
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
