import 'package:flutter/material.dart';
import 'package:peergroww/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int counter = 0;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                child: Column(children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 330.0,
                      ),
                      IconButton(
                          icon: const Icon(Icons.logout_rounded),
                          iconSize: 32.0,
                          color: Colors.white,
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.pushNamedAndRemoveUntil(context, '/login',
                                (Route<dynamic> route) => false);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: AssetImage('assets/user_profile.jpg'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('User Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'user@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.grey[200],
                child: Center(
                    child: Card(
                        child: Container(
                            width: 330.0,
                            height: 330.0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: Colors.blueAccent[400],
                                        size: 45,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Address",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          Text(
                                            "TKM College of Engineering \n Kollam Kerala 691005",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.auto_awesome,
                                        color: Colors.yellowAccent[400],
                                        size: 45,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Skills",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          Text(
                                            "Data Structures & Algorithms",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.people,
                                        color: Colors.lightGreen[400],
                                        size: 45,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Groups",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          Text(
                                            "DS ,Java",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )))),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
