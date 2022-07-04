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

import '../services/database.dart';

class ChatPage extends StatefulWidget {
  static final String id = "/chatpage";

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _message = "";
  List<Widget> children = [];
  //final TextEditingController _message = TextEditingController();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  static final String Chatroomid = 'chatroomid';
  final TextEditingController inputTextController = TextEditingController();

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
      // print("\n\n\n");

      // print(_auth.currentUser?.displayName);
      // print("\n\n\n");
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser?.uid,
        "message": _message,
        "time": FieldValue.serverTimestamp(),
        "chatroomid": Chatroomid,
      };
      await _firestore
          .collection('chatroom')
          .doc(Chatroomid)
          .collection('messages')
          .add(messages);
      this.setState(() {
        _message = "";
       
      });
    } else {
      print("Enter some text");
    }
  }

  @override
  void initState() {
    super.initState();
    final subsciber = firestoreChat.listen(
      (snapshot) {
        setState(() async {
          String? uuid = _auth.currentUser!.uid.toString();
          children = snapshot.docs.map((document) {
            dynamic result = document.data();
            DatabaseService _ds = DatabaseService();
            String uuid2 = result['sendby'].toString();
            if (uuid == uuid2)
              return (FlatChatMessage(
                message: result['message'],
                messageType: MessageType.sent,
              ));
            else
              return (FlatChatMessage(
                message: result['message'],
                messageType: MessageType.received,
              ));
          }).toList();
        });
      },
      onDone: () => print("Done"),
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
          title: "Group name",
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
