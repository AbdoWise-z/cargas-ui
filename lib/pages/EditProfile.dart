import 'dart:convert';

import 'package:cargas/base.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/LoadingCard.dart';

class EditProfile extends StatefulWidget {
  String  NameError, PhoneNumberError,AddressError;
  bool hasNameError,hasPhoneNumberError,hasAddressError;

  EditProfile(
      { Key? key,
        this.NameError = "Invalid Name",
        this.hasNameError = false,
        this.PhoneNumberError = "Invalid Phone Number",
        this.hasPhoneNumberError = false,
        this.AddressError = "Invalid Address",
        this.hasAddressError = false,
      }
      ) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _name = name;
  String _phoneNumber = phoneNumber;
  String _address = address;
  bool loading = false;
  List<FocusNode> selectedIndex = [FocusNode(),FocusNode(),FocusNode()];

  //TODO: back-end request
  updateProfile() async{

    widget.hasNameError = false;
    widget.hasPhoneNumberError = false;
    widget.hasAddressError = false;

    if (_name.isEmpty){
      setState(() {
        widget.hasNameError = true;
        widget.NameError = "Name cannot be empty";
      });
      return;
    }

    if (_name.length > 32){
      setState(() {
        widget.hasNameError = true;
        widget.NameError = "Name cannot be larger than 32 characters";
      });
      return;
    }

    if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(_name)){
      setState(() {
        widget.hasNameError = true;
        widget.NameError = "Invalid Name";
      });
      return;
    }

    if (_phoneNumber.isEmpty){
      setState(() {
        widget.hasPhoneNumberError = true;
        widget.PhoneNumberError = "Phone Number cannot be empty";
      });
      return;
    }

    if(_phoneNumber.length > 11 || !RegExp(r'^[0-9]+$').hasMatch(_phoneNumber) || !_phoneNumber.startsWith('0')){
      setState(() {
        widget.hasPhoneNumberError = true;
        widget.PhoneNumberError = "invalid Phone Number";
      });
      return;
    }

    if (_address.isEmpty){
      setState(() {
        widget.hasAddressError = true;
        widget.AddressError = "Address cannot be empty";
      });
      return;
    }
    setState(() {
      loading = true;
    });
    // await Future.delayed(Duration(seconds: 2));
    // setState(() {
    //   loading = false;
    // });
    String url = "$ServerAddress/profile_update";
    print("Running: $url");

    try {

      print('$accountToken   $_name  $_phoneNumber   $_address');
      var res = await http.post(Uri.parse(url) ,
        body : jsonEncode({
          //"email" : email,
          "token": accountToken,
          "name" : _name,
          "phone_number" : _phoneNumber,
          "address" : _address
        }),
      );

      print(res.body);

      Map data = jsonDecode(res.body);

      if (data["result"] == 0){
        setState(() {
          name = _name;
          address = _address;
          phoneNumber = _phoneNumber;
          Navigator.pop(context);
        });
      }else {
        setState(() {
          loading = false;
          widget.AddressError = "Failed to connect to server.";
          widget.hasAddressError = true;
        });
      }
    }catch (e){
      print(e);
      loading = false;
      widget.AddressError = "Failed to connect to server.";
      widget.hasAddressError = true;
      setState(() {});
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){},  //TODO: change images
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/default_profile_green.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 19, 24, 0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontWeight: selectedIndex[0].hasFocus? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                        color: selectedIndex[0].hasFocus? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(splashColor: const Color(0x6170FFE6)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 3, 24, 0),
                      child: Material(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        clipBehavior: Clip.hardEdge,
                        color: const Color(0x08000000),
                        child: InkWell(
                          focusNode: selectedIndex[0],
                          onFocusChange: (isFocused){setState(() {});},
                          child: TextFormField(
                            initialValue: name,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                border: InputBorder.none
                            ),
                            onChanged: (text) => _name = text,
                          ),
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
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 19, 24, 0),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontWeight: selectedIndex[1].hasFocus? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                        color: selectedIndex[1].hasFocus? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(splashColor: const Color(0x6170FFE6)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 3, 24, 0),
                      child: Material(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        clipBehavior: Clip.hardEdge,
                        color: const Color(0x08000000),
                        child: InkWell(
                          focusNode: selectedIndex[1],
                          onFocusChange: (isFocused){setState(() {});},
                          child: TextFormField(
                            initialValue: phoneNumber,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                border: InputBorder.none
                            ),
                            onChanged: (text) => _phoneNumber = text,
                          ),

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
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 19, 24, 0),
                    child: Text(
                      "Address",
                      style: TextStyle(
                        fontWeight: selectedIndex[2].hasFocus? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                        color: selectedIndex[2].hasFocus? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(splashColor: const Color(0x6170FFE6)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 3, 24, 0),
                      child: Material(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        clipBehavior: Clip.hardEdge,
                        color: const Color(0x08000000),
                        child: InkWell(
                          focusNode: selectedIndex[2],
                          onFocusChange: (isFocused){setState(() {});},
                          child: TextFormField(
                            initialValue: address,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                border: InputBorder.none
                            ),
                            onChanged: (text) => _address = text,
                          ),

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
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Center(
                    child: Theme(
                      data: ThemeData(splashColor: Colors.yellow[200]),
                      child: Material(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.green,
                        child: InkWell(
                          child: const SizedBox(width: 200 , height: 40,
                            child: Center(
                              child: Text(
                                "UPDATE PROFILE",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            //print('$user  $pass  $email');
                            updateProfile();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: loading,
                child: const Center(child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: LoadingCard(msg: "Updating profile, Please wait..."),
                )),
              ),
            ]
        ),
      ),
    );
  }
}