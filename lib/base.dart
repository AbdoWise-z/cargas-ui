//static constant variables will be added here

String _googleMapsKey = "NULL";

String? _accountToken;
int _accountType = -1; //not logged in

const int ACCOUNT_TYPE_USER    = 0;
const int ACCOUNT_TYPE_TRADER  = 1;
const int ACCOUNT_TYPE_ADMIN   = 2;

bool isAdmin(){
  return _accountType == ACCOUNT_TYPE_ADMIN;
}

bool isLoggedIn(){
  return _accountType >= 0;
}


