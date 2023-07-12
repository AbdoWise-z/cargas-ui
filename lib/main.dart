import 'package:cargas/Home.dart';
import 'package:cargas/pages/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:cargas/pages/Login.dart';

void main() {
  // adding dummy values for testing ..

  runApp(const CargasApp());
}

class CargasApp extends StatelessWidget {
  const CargasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login' : (context) => const Login(),
        '/home' : (context) => ContainerHomePage(title: "CarGas"),
        '/editProfile' : (context) => EditProfile(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}


