import 'package:flutter/material.dart';
import 'package:peergroww/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      leading: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.home,
            size: 24.0,
          ),
          SizedBox(
            width: 10,
          ),
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
