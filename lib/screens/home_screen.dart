import 'package:flutter/material.dart';
import 'package:peergroww/config/palette.dart';
import 'package:peergroww/widgets/widgets.dart';
import 'package:peergroww/services/database.dart' as db;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peergroww/models/app_user.dart';

class HomeScreen extends StatefulWidget {
  @override
   
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppUser? _user;
  String? name;
  @override
  void initState() {
    super.initState();
    db.startUserListen();
    db.DatabaseService _ds = db.DatabaseService();
    User? usr = FirebaseAuth.instance.currentUser;

    //print("HELLO"+usr!.displayName.toString());
    if (usr != null) {
      _ds.getUserData(usr.uid).then((value) {
        _user = value as AppUser;
        if (_user != null) {
          setState(() {
            name = _user!.firstName;
            print(name);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _header(screenHeight),
          _middle(screenHeight),
          _bottom(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _header(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Hi, ' + (name ?? "User"),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Learn together,',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Learn better',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _middle(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Image.asset('assets/learn_1.png'),
                      Text(
                        'Learn',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/learn.png'),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Teach',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _bottom(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('assets/complete_reg.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Enjoy Teaching & Learning',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Text(
                      'Start your new journey of learning\nwith your peers..',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(width: 2),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
