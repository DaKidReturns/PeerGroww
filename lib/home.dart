import 'package:flutter/material.dart';
import 'package:peergroww/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _auth.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (Route<dynamic> route) => false);
          },
          child: Text("Logout"),
        ),
      ),
    ));
  }
}
