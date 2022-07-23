import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:peergroww/screens/chat_list.dart';
import 'package:peergroww/screens/chatpage.dart';
import 'package:peergroww/screens/home_screen.dart';
import 'package:peergroww/screens/bottom_nav_screen.dart';
import 'package:peergroww/screens/login.dart';
import 'package:peergroww/screens/register.dart';
import 'package:peergroww/screens/profile.dart';

void main() async {
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
              //'/profile': (context) => Profile(),
              '/chatpage': (context) => ChatPage('HI')
            },
          );
        });
  }
}
