//static constant variables will be added here

import 'package:cargas/Request.dart';

String _googleMapsKey = "NULL";

//Account info
String? _accountToken;
int _accountType = -1; //not logged in
String _name = "Da we";
String _address = "22 jump st";
double _balance = 0; //get rich bruh

const int ACCOUNT_TYPE_USER    = 0;
const int ACCOUNT_TYPE_TRADER  = 1;
const int ACCOUNT_TYPE_ADMIN   = 2;

//END - Account info

//Request info
List<Request> _requests = [];
//End - Request info

bool isAdmin(){
  return _accountType == ACCOUNT_TYPE_ADMIN;
}

bool isLoggedIn(){
  return _accountType >= 0;
}


