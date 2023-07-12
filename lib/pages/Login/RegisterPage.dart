import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function(String , String , String,String,String,String) registerCallback;
  final Function() returnCallback;
  final String PasswordError , UserError , EmailError, NameError, PhoneNumberError,AddressError;
  final bool hasUserError , hasPasswordError , hasEmailError,hasNameError,hasPhoneNumberError,hasAddressError;

  const RegisterPage(
      this.registerCallback ,
      this.returnCallback ,
      { Key? key,
        this.PasswordError = "Wrong password",
        this.hasPasswordError = false,
        this.UserError = "Wrong username",
        this.hasUserError = false,
        this.EmailError = "Emain invalid",
        this.hasEmailError = false,
        this.NameError = "Invalid Name",
        this.hasNameError = false,
        this.PhoneNumberError = "Invalid Phone Number",
        this.hasPhoneNumberError = false,
        this.AddressError = "Invalid Address",
        this.hasAddressError = false,
      }
      ) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String user = "";
  String pass = "";
  String email = "";
  String name = "";
  String phoneNumber = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: widget.returnCallback,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),

          const SizedBox(
            height: 60,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 12),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800]
                  ),
                ),
              ),
            ],
          ),

          Theme(
            data: ThemeData(splashColor: Color(0x6170FFE6)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Material(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                color: const Color(0x08000000),
                child: InkWell(
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        hintText: "Username",
                        border: InputBorder.none
                    ),
                    onChanged: (text) => user = text,
                  ),
                  onTap: () {

                  },
                ),
              ),
            ),
          ),

          Visibility(
            visible: widget.hasUserError,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 24, 0),
              child: Text(
                widget.UserError,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red
                ),
              ),
            ),
          ),

          Theme(
            data: ThemeData(splashColor: Color(0x6170FFE6)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Material(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                color: const Color(0x08000000),
                child: InkWell(
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        hintText: "Password",
                        border: InputBorder.none
                    ),
                    onChanged: (text) => pass = text,
                  ),
                  onTap: () { //useless because fk flutter
                  },
                ),
              ),
            ),
          ),

          Visibility(
            visible: widget.hasPasswordError,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 24, 0),
              child: Text(
                widget.PasswordError,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red
                ),
              ),
            ),
          ),

          Theme(
            data: ThemeData(splashColor: Color(0x6170FFE6)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Material(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                color: const Color(0x08000000),
                child: InkWell(
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        hintText: "E-mail",
                        border: InputBorder.none
                    ),
                    onChanged: (text) => email = text,
                  ),
                  onTap: () { //useless because fk flutter
                  },
                ),
              ),
            ),
          ),

          Visibility(
            visible: widget.hasEmailError,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 24, 0),
              child: Text(
                widget.EmailError,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red
                ),
              ),
            ),
          ),

          Theme(
            data: ThemeData(splashColor: Color(0x6170FFE6)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Material(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                color: const Color(0x08000000),
                child: InkWell(
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        hintText: "Name",
                        border: InputBorder.none
                    ),
                    onChanged: (text) => name = text,
                  ),
                  onTap: () { //useless because fk flutter
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.hasNameError,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 24, 0),
              child: Text(
                widget.NameError,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red
                ),
              ),
            ),
          ),
          Theme(
            data: ThemeData(splashColor: Color(0x6170FFE6)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Material(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                color: const Color(0x08000000),
                child: InkWell(
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        hintText: "Phone Number",
                        border: InputBorder.none
                    ),
                    onChanged: (text) => phoneNumber = text,
                  ),
                  onTap: () { //useless because fk flutter
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.hasPhoneNumberError,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 24, 0),
              child: Text(
                widget.PhoneNumberError,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red
                ),
              ),
            ),
          ),
          Theme(
            data: ThemeData(splashColor: Color(0x6170FFE6)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Material(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                color: const Color(0x08000000),
                child: InkWell(
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        hintText: "Address",
                        border: InputBorder.none
                    ),
                    onChanged: (text) => address = text,
                  ),
                  onTap: () { //useless because fk flutter
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.hasAddressError,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 24, 0),
              child: Text(
                widget.AddressError,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red
                ),
              ),
            ),
          ),
          const SizedBox(height: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                data: ThemeData(splashColor: Colors.red[200]),
                child: Material(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.hardEdge,
                  color: const Color(0x12000000),
                  child: InkWell(
                    child: SizedBox(width: 200 , height: 40,
                      child: const Center(
                        child: Text(
                          "Register",
                        ),
                      ),
                    ),
                    onTap: () {
                      //print('$user  $pass  $email');
                      widget.registerCallback(user , pass , email,name,phoneNumber,address);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}