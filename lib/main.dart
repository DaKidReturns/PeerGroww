import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:peergroww/home_screen.dart';
import 'package:peergroww/bottom_nav_screen.dart';
import 'login.dart';
import 'home_screen.dart';
import 'register.dart';
import 'profile.dart';

void main() async {
  print("Hello there");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initRoute =
        FirebaseAuth.instance.currentUser == null ? '/login' : '/home';
    /*FirebaseAuth.instance.currentUser != null
        ? initRoute = 'home'
        : initRoute = 'login';*/

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (cntxt, user) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: initRoute,
            routes: {
              '/login': (content) => const MyLogin(),
              '/register': (context) => const MyRegister(),
              '/home': (context) => BottomNavScreen(),
              '/profile': (context) => Profile(),
            },
          );
        });
  }
}
