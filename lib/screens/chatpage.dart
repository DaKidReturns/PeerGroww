import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peergroww/widgets/chat_widgets/flat_action_btn.dart';
import 'package:peergroww/widgets/chat_widgets/flat_chat_message.dart';
import 'package:peergroww/widgets/chat_widgets/flat_message_input_box.dart';
import 'package:peergroww/widgets/chat_widgets/flat_page_header.dart';
import 'package:peergroww/widgets/chat_widgets/flat_page_wrapper.dart';
import 'package:peergroww/widgets/chat_widgets/flat_profile_image.dart';
import 'package:flutter/material.dart';

import '../services/database.dart' as database;

class ChatPage extends StatefulWidget {
  String chatroomname="";
  ChatPage(String chatroom) {
     this.chatroomname = chatroom;
     print(chatroomname);
  }
  @override
  _ChatPageState createState() => _ChatPageState(chatroomname);
}

class _ChatPageState extends State<ChatPage> {

  static String Chatroomid = 'chatroomid';
  _ChatPageState(String chatroom)
  {
   Chatroomid=chatroom;
  }

  String _message = "";
  List<Widget> children = [];
  //final TextEditingController _message = TextEditingController();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController inputTextController = TextEditingController();
  final database.DatabaseService _ds = database.DatabaseService();

  static Stream<QuerySnapshot> get firestoreChat {
    return _firestore
        .collection('chatroom')
        .doc(Chatroomid)
        .collection('messages')
        .orderBy("time", descending: true)
        .snapshots();
  }

  void onSendMessage() async {
    print("Sending message");
    if (_message.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby_uuid": _auth.currentUser!.uid,
        "sendby_displayname": _auth.currentUser!.displayName,
        "message": _message,
        "time": FieldValue.serverTimestamp(),
        "chatroomid": Chatroomid,
      };
      await _firestore
          .collection('chatroom')
          .doc(Chatroomid)
          .collection('messages')
          .add(messages);
    } else {
      print("Enter some text");
    }
  }

  @override
  void initState() {
    super.initState();
    dynamic childrenTemp = [];
    // final userlistener = database.userNames.listen((snapshot) {
    //   //print("Snapshot: $snapshot");
    //   snapshot.docs.forEach((element) {
    //     //print(element.data());
    //     Map data = element.data() as Map;
    //     setState(() {
    //       database.usersData[data['uid']] = data['firstName'];
    //     });
    //   });
    //   // Map data = snapshot.docs as Map;
    //   // usersData.add(data);
    // });
    final subsciber = firestoreChat.listen(
      (snapshot) {
        setState(() {
          // database.startUserListen();
          String? uuid = _auth.currentUser!.uid.toString();
          //DocumentReference userList = DatabaseService().getUserSnapshot()
          children = snapshot.docs.map((document) {
            //print(document.data().toString());
            dynamic result = document.data();

            String uuid2 = result['sendby_uuid'].toString();

            print(database.usersData);
            if (uuid == uuid2) {
              return FlatChatMessage(
                Sentby: database.usersData[uuid2],
                //Sentby: uuid,
                message: result['message'],
                messageType: MessageType.sent,
              );
            } else {
              return FlatChatMessage(
                Sentby: database.usersData[uuid2],
                //Sentby: uuid,
                message: result['message'],
                messageType: MessageType.received,
              );
            }
          }).toList();

          //print(childrenTemp);
          //children = childrenTemp;
          //for()
          // children = childrenTemp.map((messageDataElement) {
          //   if (messageDataElement != null) {
          //     print(messageDataElement);
          //     Map nonFutureDataElement = messageDataElement as Map;
          //     print(nonFutureDataElement);
          //     return FlatChatMessage(
          //       Sentby: nonFutureDataElement['firstName'],
          //       message: nonFutureDataElement['message']['message'],
          //       messageType: nonFutureDataElement['messageType'],
          //     );
          //   }
          // }).toList();
        });
      },
      onDone: () {},
    );
    subsciber.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatPageWrapper(
        scrollType: ScrollType.floatingHeader,
        reverseBodyList: true,
        header: FlatPageHeader(
          prefixWidget: FlatActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Chatroomid,
          // suffixWidget: FlatProfileImage(
          //   size: 35.0,
          //   onlineIndicator: true,
          //   imageUrl:
          //       'https://images.pexels.com/photos/3866555/pexels-photo-3866555.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
          //   onPressed: () {
          //     print("Clicked Profile Image");
          //   },
          // ),
        ),
        children: children,
        footer: FlatMessageInputBox(
          controller: inputTextController,
          onChanged: (val) {
            setState(() {
              _message = val;
            });
          },
          onSubmitted: (val) {
            onSendMessage();
            inputTextController.clear();
            _message = "";
          },
          prefix: FlatActionButton(
            iconData: Icons.add,
            iconSize: 24.0,
          ),
          roundedCorners: true,
          suffix: FlatActionButton(
            iconData: Icons.image,
            iconSize: 24.0,
          ),
        ),
      ),
    );
  }
}
