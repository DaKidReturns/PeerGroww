import 'package:campus365/register.dart';
import 'package:flutter/material.dart';
import 'package:campus365/login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login':(content) => const MyLogin(),
      'register':(context) => const MyRegister(),
    },
  ));
}
