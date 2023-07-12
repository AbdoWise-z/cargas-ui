import 'dart:convert';
import 'Login/LoginPage.dart';
import 'Login/RegisterPage.dart';
import 'package:cargas/base.dart';
import 'package:cargas/widget/LoadingCard.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const int LOGIN_PAGE = 0;
  static const int REGISTER_PAGE = 1;

  int page = LOGIN_PAGE;
  bool loading = false;

  String msg = "";

  bool loghasUserNameError = false;
  String logUserNameError = "";

  bool loghasPassError = false;
  String logPassError = "";

  bool reghasUserNameError = false;
  String regUserNameError = "";

  bool reghasPassError = false;
  String regPassError = "";

  bool reghasEmailError = false;
  String regEmailError = "";

  bool reghasNameError = false;
  String regNameError = "";

  bool reghasPhoneNumberError = false;
  String regPhoneNumberError = "";

  bool reghasAddressError = false;
  String regAddressError = "";

  void doLogin(String user , String pass , bool rem) async{
    loghasUserNameError = false;
    loghasPassError = false;
    user = user.trim();
    pass = pass.trim();

    if (user.isEmpty){
      setState(() {
        page = LOGIN_PAGE;
        loghasUserNameError = true;
        logUserNameError = "Username cannot be empty";
      });
      return;
    }

    if (user.contains(" ")){
      setState(() {
        page = LOGIN_PAGE;
        loghasUserNameError = true;
        logUserNameError = "username cannot have white spaces";
      });
      return;
    }

    if (pass.isEmpty){
      setState(() {
        page = LOGIN_PAGE;
        loghasPassError = true;
        logPassError = "password cannot be empty";
      });
      return;
    }

    if (pass.contains(" ")){
      setState(() {
        page = LOGIN_PAGE;
        loghasPassError = true;
        logPassError = "password cannot have white spaces";
      });
      return;
    }

    loading = true;
    msg = "Logging in , please wait ..";
    // setState(() {
    // });
    // await Future.delayed(Duration(seconds: 2));
    // setState(() {
    //   loading = false;
    //   Navigator.pushReplacementNamed(context, '/home');
    // });


    //TODO: Request to back-end for login authorization
    String url = "$ServerAddress/login?user=$user&password=$pass";
    print("Running: $url");

    try {

      var res = await http.get(Uri.parse(url));

      print(res.body);

      Map data = jsonDecode(res.body);

      if (data["result"] == 0){
        accountToken = data["token"];

        // CurrentUser.Attr = data["user"]["admin"];
        // CurrentUser.ID = data["user"]["id"];
        // CurrentUser.name = user;

        // if (rem) {
        //   final pref = await SharedPreferences.getInstance();
        //   await pref.setString("SessionID", SessionID); //save the current "SessionID"
        // }

        setState(() {
          Navigator.pushReplacementNamed(context, "/home");
        });

        return;
      }
      else{
        loading = false;
        logPassError = "Wrong username or password.";
        loghasPassError = true;
        setState(() {});
        return;
      }
    }catch (e){
      print(e);
      loading = false;
      logPassError = "Failed to connect to server.";
      loghasPassError = true;
      setState(() {});
      return;
    }
  }

  void Register(String username , String pass , String email, String name, String phoneNumber,String address) async {
    reghasPassError = false;
    reghasEmailError = false;
    reghasUserNameError = false;
    reghasNameError = false;
    reghasPhoneNumberError = false;

    username = username.trim();
    pass = pass.trim();
    email = email.trim();
    name = name.trim();
    phoneNumber = phoneNumber.trim();
    address = address.trim();
    print("user: $username  pass: $pass  email: $email  name: $name  phone: $phoneNumber  address: $address");

    //TODO: validation for number,name
    if (username.isEmpty){
      setState(() {
        page = REGISTER_PAGE;
        reghasUserNameError = true;
        regUserNameError = "Username cannot be empty";
      });
      return;
    }

    if (username.contains(" ")){
      setState(() {
        page = REGISTER_PAGE;
        reghasUserNameError = true;
        regUserNameError = "username cannot have white spaces";
      });
      return;
    }

    if (pass.isEmpty){
      setState(() {
        page = REGISTER_PAGE;
        reghasPassError = true;
        regPassError = "password cannot be empty";
      });
      return;
    }

    if (pass.contains(" ")){
      setState(() {
        page = REGISTER_PAGE;
        reghasPassError = true;
        regPassError = "password cannot have white spaces";
      });
      return;
    }

    if (email.isEmpty){
      setState(() {
        page = REGISTER_PAGE;
        reghasEmailError = true;
        regEmailError = "Email cannot be empty";
      });
      return;
    }

    if (email.contains(" ")){
      setState(() {
        page = REGISTER_PAGE;
        reghasEmailError = true;
        regEmailError = "Email cannot have white spaces";
      });
      return;
    }

    if (!email.contains("@") || email.split("@").length > 2){
      setState(() {
        page = REGISTER_PAGE;
        reghasEmailError = true;
        regEmailError = "Invalid email address";
      });
      return;
    }

    if (name.isEmpty){
      setState(() {
        page = REGISTER_PAGE;
        reghasNameError = true;
        regNameError = "Name cannot be empty";
      });
      return;
    }

    if (name.length > 32){
      setState(() {
        page = REGISTER_PAGE;
        reghasNameError = true;
        regNameError = "Name cannot be larger than 32 characters";
      });
      return;
    }

    if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)){
      setState(() {
        page = REGISTER_PAGE;
        reghasNameError = true;
        regNameError = "Invalid Name";
      });
      return;
    }

    if (phoneNumber.isEmpty){
      setState(() {
        page = REGISTER_PAGE;
        reghasPhoneNumberError = true;
        regPhoneNumberError = "Phone Number cannot be empty";
      });
      return;
    }

    if(phoneNumber.length > 11 || !RegExp(r'^[0-9]+$').hasMatch(phoneNumber) || !phoneNumber.startsWith('0')){
      setState(() {
        page = REGISTER_PAGE;
        reghasPhoneNumberError = true;
        regPhoneNumberError = "invalid Phone Number";
      });
      return;
    }

    if (address.isEmpty){
      setState(() {
        page = REGISTER_PAGE;
        reghasAddressError = true;
        regAddressError = "Address cannot be empty";
      });
      return;
    }


    loading = true;
    msg = "Creating account , please wait ..";
    // setState(() {
    // });
    // await Future.delayed(Duration(seconds: 2));
    // setState(() {
    //   loading = false;
    //   page = LOGIN_PAGE;
    // });


    //TODO: Request to back-end for register authorization
    String url = "$ServerAddress/register";
    print("Running: $url");

    try {

      var res = await http.post(Uri.parse(url) ,
        body : jsonEncode({
          "username" : username,
          "password" : pass,
          "email"    : email,
          "name" : name,
          "phone_number" : phoneNumber,
          "address" : address
        }),
      );

      print(res.body);

      Map data = jsonDecode(res.body);


      if (data["result"] == 0){
        doLogin(username, pass, false);
      }else if(data["result"] == 3){
        setState(() {
          page = REGISTER_PAGE;
          loading = false;
          reghasUserNameError = true;
          regUserNameError = "Username is used";
        });
      }else if(data["result"] == 2){
        setState(() {
          page = REGISTER_PAGE;
          loading = false;
          reghasPassError = true;
          regPassError = "Password cannot be less than 8 characters";
        });
      }else if(data["result"] == 1){
        setState(() {
          page = REGISTER_PAGE;
          loading = false;
          reghasUserNameError = true;
          regUserNameError = "Username cannot be less than 8 characters";
        });
      }else{
        setState(() {
          page = REGISTER_PAGE;
          loading = false;
          reghasAddressError = true;
          regAddressError = "Couldn't create account, Please try again...";
        });
      }
      //else{
        // if (data["detail"].toString().contains("email")){
        //   regEmailError = "this email is already used";
        //   reghasEmailError = true;
        //   loading = false;
        //   setState(() {});
        // } else {
        //   regNameError = "this username is already used";
        //   reghasNameError = true;
        //   loading = false;
        //   setState(() {});
        // }
        //}
    }catch (e){
      print(e);
      loading = false;
      regEmailError = "Failed to connect to server.";
      reghasEmailError = true;
      setState(() {});
      return;
    }
  }


  //TODO: shared preferences things
  // void tryAutoLogin() async {
  //   final pref = await SharedPreferences.getInstance();
  //   SessionID = pref.getString("SessionID") ?? "";
  //   //await pref.setString("SessionID", "");
  //   print("Saved sid: $SessionID");
  //   //SessionID = "";
  //   //SessionID = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7IlNUQVRVUyI6MSwidXNlciI6eyJpZCI6NTIsInVzZXJuYW1lIjoiQWRtaW4wMDEiLCJwYXNzd29yZCI6IkFkbWluMDAxIiwiZW1haWwiOiJBZG1pbjAwMUBlbWFpbC5jb20iLCJhZG1pbiI6MSwiZGF0ZV9jcmVhdGVkIjoiMjAyMi0xMS0yN1QyMDozMDoxMS4wMDBaIn0sImJhbm5lZCI6MH0sImlhdCI6MTY3MjIzNTYzNSwiZXhwIjoxNjcyMjM2NjM1fQ.FHuYf3j6z-JqwNvBHt9fnnIdgga6rEYYHh5Wx54XzOE";
  //   if (SessionID.isNotEmpty){
  //     loading = true;
  //     msg = "Logging in , please wait ..";
  //     setState(() {
  //     });
  //     String url = "$ServerAddress/login";
  //     print("Running: $url");
  //
  //     try {
  //       var res = await http.post(Uri.parse(url) ,
  //         body : jsonEncode({
  //           "Token" : SessionID,
  //         }),
  //         headers: {
  //           "content-type" : "application/json",
  //         },
  //       );
  //
  //       Map data = jsonDecode(res.body);
  //
  //       if (data["status"] == 1){
  //         SessionID = data["session_id"];
  //         CurrentUser.Attr = data["account_type"];
  //         CurrentUser.ID = data["user_id"];
  //         CurrentUser.name = data["username"];
  //         await pref.setString("SessionID", SessionID); //save the new "SessionID"
  //         setState(() {
  //           Navigator.pushReplacementNamed(context, "/plswrk");
  //         });
  //         return;
  //       }else{
  //         await pref.setString("SessionID", "");
  //         loading = false;
  //         logPassError = "Session Expired";
  //         loghasPassError = true;
  //         setState(() {});
  //         return;
  //       }
  //
  //     }catch (e){
  //       print(e);
  //       loading = false;
  //       logPassError = "Failed to connect to server.";
  //       loghasPassError = true;
  //       setState(() {});
  //       return;
  //     }
  //   }
  // }
  @override
  void initState() {
    super.initState();
    //tryAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child:
          Stack(
            children: [
              Visibility(
                visible: page == LOGIN_PAGE,
                child: AbsorbPointer(
                  absorbing: loading,
                  child: LoginPage(
                    UserError: logUserNameError,
                    PasswordError: logPassError,
                    hasUserError: loghasUserNameError,
                    hasPasswordError: loghasPassError,
                        (String name , String pass , bool rem) { //login
                      doLogin(name, pass , rem);
                    },
                        () { //register
                      setState(() {
                        page = REGISTER_PAGE;
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                visible: page == REGISTER_PAGE,
                child: AbsorbPointer(
                  absorbing: loading,
                  child: RegisterPage(
                      UserError: regUserNameError,
                      PasswordError: regPassError,
                      hasUserError: reghasUserNameError,
                      hasPasswordError: reghasPassError,
                      EmailError: regEmailError,
                      hasEmailError: reghasEmailError,
                      NameError: regNameError,
                      hasNameError: reghasNameError,
                      PhoneNumberError: regPhoneNumberError,
                      hasPhoneNumberError: reghasPhoneNumberError,
                      AddressError: regAddressError,
                      hasAddressError: reghasAddressError,
                          (String username , String pass , String email, String name, String phoneNumber, String address) { //login
                        Register(username, pass , email , name , phoneNumber , address);
                      },
                          () {
                        setState(() {
                          page = LOGIN_PAGE;
                        });
                      }
                  ) ,
                ),
              ),

              Visibility(
                visible: loading,
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LoadingCard(msg: msg),
                )),
              ),
            ],
          )
      ),
    );
  }
}