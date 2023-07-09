class ShopItem{
  double price = 0;           // price of item in L.E.
  String name = "No name";    // the name of the item in the shop
  String itemDisc = "blah blah blah ...";
  int image = 0;              // the index of the image in the listed assets images
  String imageUrl = "";       // in case of an offer or something
  String itemCode = "";          // item code , in sever (or maybe serial)
  int itemType = 0;           // 0 car oil , 1 truck oil ?

  ShopItem({required this.name , required this.itemDisc , required this.image , required this.imageUrl , required this.itemCode , required this.price ,  required this.itemType});
}