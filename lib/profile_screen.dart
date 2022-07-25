import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peergroww/services/auth.dart';
import '../services/database.dart' as data;
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int counter = 0;
  String skills="";
  String groups="";
  final AuthService _auth = AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    int x=int.parse(data.userdt[auth.currentUser?.uid.toString()]['skills'][0]);
    int y=int.parse(data.userdt[auth.currentUser?.uid.toString()]['chatrooms'][0]);
    for(int i=1;i<=x;i++)
      {
        skills+=data.userdt[auth.currentUser?.uid.toString()]['skills'][i];
        skills+=", ";
      }

    for(int i=1;i<=y;i++)
    {
      groups+=data.userdt[auth.currentUser?.uid.toString()]['chatrooms'][i];
      groups+=", ";
    }
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
                  Text(data.userdt[auth.currentUser?.uid.toString()]['firstName'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    data.userdt[auth.currentUser?.uid.toString()]['email'],
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
                                            "Institution",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          Text(
                                            data.userdt[auth.currentUser?.uid.toString()]['institution'],
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
                                            skills,
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
                                            groups,
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
