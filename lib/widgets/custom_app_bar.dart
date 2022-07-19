import 'package:flutter/material.dart';
import 'package:peergroww/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
