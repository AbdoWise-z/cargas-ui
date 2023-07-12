class RequestedShopItem{
  String code;
  int quantity;

  RequestedShopItem({required this.code , required this.quantity});
}

class Request{
  List<RequestedShopItem> items = [];
  String requestCode = "0";
  int state = -1;
  DateTime date;

  Request({required this.state , required this.requestCode , required this.items , required this.date});

}