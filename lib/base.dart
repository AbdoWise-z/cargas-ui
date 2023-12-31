//static constant variables will be added here

import 'package:cargas/Cart.dart';
import 'package:cargas/Request.dart';
import 'package:cargas/ShopItem.dart';
import 'package:flutter/material.dart';

String ServerAddress = "http://192.168.1.3:8080";
//Google Maps
String googleMapsKey = "NULL";
//End - Google Maps

//Account info
String? accountToken;
int _accountType = -1; //not logged in
String name = "Abdulrahman Mohammed Abdelfattah";
String phoneNumber = "+201144503386";
String address = "Address goes here";
double balance = 1498; //get rich bruh

const int ACCOUNT_TYPE_USER    = 0;
const int ACCOUNT_TYPE_TRADER  = 1;
const int ACCOUNT_TYPE_ADMIN   = 2;

//END - Account info

//Shop related stuff
Cart currentCart = Cart();
TextEditingController controller = TextEditingController();
List<ShopItem> shopItems = [];
//End - Shop

//Request info
List<Request> requests = [];
//End - Request info


//some helper functions
bool isAdmin(){
  return _accountType == ACCOUNT_TYPE_ADMIN;
}

bool isLoggedIn(){
  return _accountType >= 0;
}


