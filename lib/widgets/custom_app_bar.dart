import 'package:flutter/material.dart';
import 'package:peergroww/config/palette.dart';
import 'package:peergroww/services/auth.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      leading: Row(
        children: [
          /*SizedBox(
            width: 10,
          ),*/
          IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 24,
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (Route<dynamic> route) => false);
              }),
          /*SizedBox(
            width: 10,
          ),*/
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.account_circle),
          iconSize: 28.0,
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
