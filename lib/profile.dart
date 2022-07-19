// ignore_for_file: prefer_const_constructors, unused_local_variable, sized_box_for_whitespace
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'models/app_user.dart';
import 'services/database.dart';

class Colorchangebutton extends StatefulWidget {
  bool onpressed = false;
  String name = "container";
  @override
  State<Colorchangebutton> createState() => _Colorchangebutton();
}

class _Colorchangebutton extends State<Colorchangebutton> {
  var b = new Colorchangebutton();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Container(
        width: 95,
        child: Container(
          decoration: BoxDecoration(
              color: b.onpressed
                  ? Colors.amber
                  : Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber)),
          child: MaterialButton(
            onPressed: () {
              setState(() {
                b.onpressed = !b.onpressed;
                _buildPopupDialog();
              });
            },
            child: Text(
              b.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: b.onpressed ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog() {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  AppUser? _user;
  String? name;
  String? emailId;
  final double coverheight = 280;

  final double profileheight = 62;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseService _ds = DatabaseService();
    User? usr = FirebaseAuth.instance.currentUser;
    if (usr != null) {
      _ds.getUserData(usr.uid).then((value) {
        _user = value as AppUser;
        if (_user != null) {
          setState(() {
            name = _user!.firstName + " " + _user!.lastName;
            emailId = _user!.email;
            print(name);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double h = queryData.size.height;
    double w = queryData.size.width;
    var b1 = new Colorchangebutton();
    var b2 = new Colorchangebutton();
    var b3 = new Colorchangebutton();
    var b4 = new Colorchangebutton();
    b1.name = "C++";
    b2.name = "PYTHON";
    b3.name = "FLUTTER";
    b4.name = "WEB DEV";



    var skillist = ['a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c'];
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 237, 237),
        body: Stack(children: <Widget>[
          Image.asset('assets/login.png'),
          ListView(
            scrollDirection: Axis.vertical,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            children: [
              Align(
                alignment: Alignment(-1, -1),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Align(
                  alignment: Alignment(0.0, 1.0),
                  child: Text(
                    name ?? 'NAME',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  child: buildProfileImage(),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 65, left: 10),
                  child: Text(
                    'ABOUT USER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(children: const <Widget>[
                        Icon(
                          Icons.apartment_rounded,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text(
                          ' ADDRESS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Row(children: const <Widget>[
                        Icon(
                          Icons.school,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text(
                          ' EDUCATION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Row(children: const <Widget>[
                        Icon(
                          Icons.male_rounded,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text(
                          ' GENDER',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Row(children: const <Widget>[
                        Icon(
                          Icons.directions_subway_filled_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text(
                          ' DISTANCE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Row(children: const <Widget>[
                        Icon(
                          Icons.hail,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text(
                          ' OCCUPATION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ]),
              ),
              const Divider(
                height: 60,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Color.fromARGB(255, 99, 97, 97),
              ),
              // SingleChildScrollView(
              //     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              //     physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              //     scrollDirection: Axis.horizontal,
              //     controller: ScrollController(
              //         initialScrollOffset: 3, keepScrollOffset: true),
              //     child: Row(
              //       children: skillist.map((country) {
              //         return Container(
              //             color: Colors.orangeAccent,
              //             height: 100,
              //             width: 150,
              //             alignment: Alignment.center,
              //             child: Text(country));
              //       }).toList(),
              //     )),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Row(children: const <Widget>[
                  Icon(
                    Icons.apartment_rounded,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  Text(
                    ' SKILLS',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ]),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    b1,
                    b2,
                    b3,
                    b4,
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Align(
                  alignment: Alignment(1.0, 1.0),
                  child: FlatButton(
                      color: Colors.amber,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile(),
                            ));
                        // FirebaseFirestore.instance.collection("amal").doc("rahul").set({
                        //   'name': 'AMAL',
                        //   'age': 20,
                        // });
                      },
                      child: Text("EDIT PROFILE")),
                ),
              ),
            ],
          ),
        ]));
  }

  Widget buildCoverImage() => Container(
        child: Image.asset(
          'assets/1385607.webp',
          width: 1000,
          height: coverheight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
      radius: 68,
      backgroundColor: Colors.yellow,
      child: CircleAvatar(
        radius: profileheight,
        backgroundColor: Colors.grey.shade800,
        //backgroundImage: AssetImage('profilepic.jpg'),
      ));

  // Widget colorchangebutton() => Align(
  //       alignment: Alignment(0, 0),
  //       child: Container(
  //         width: 95,
  //         child: Container(
  //           decoration: BoxDecoration(
  //               color: onpressed ? Colors.yellow : Colors.white,
  //               borderRadius: BorderRadius.circular(10),
  //               border: Border.all(color: Colors.amber)),
  //           child: MaterialButton(
  //             onPressed: () {
  //               setState(() {
  //                 onpressed = !onpressed;
  //               });
  //             },
  //             child: Text(
  //               "CONTAINER",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 color: onpressed ? Colors.white : Colors.black,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
}
*/