import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peergroww/widgets/chat_widgets/flat_action_btn.dart';
import 'package:peergroww/widgets/chat_widgets/flat_chat_message.dart';
import 'package:peergroww/widgets/chat_widgets/flat_message_input_box.dart';
import 'package:peergroww/widgets/chat_widgets/flat_page_header.dart';
import 'package:peergroww/widgets/chat_widgets/flat_page_wrapper.dart';
import 'package:peergroww/widgets/chat_widgets/flat_profile_image.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static final String id = "/chatpage";

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _message = "";
  //final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  static final String Chatroomid = 'chatroomid';

  Stream<QuerySnapshot> get firestoreChat {
    return _firestore
        .collection('chatroom')
        .doc(Chatroomid)
        .collection('messages')
        .orderBy("time", descending: false)
        .snapshots();
  }

  void onSendMessage() async {
    print("Sending message");
    if (_message.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser?.displayName,
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
        //children:
        //[
        // StreamBuilder<QuerySnapshot>(
        //     stream: _firestore
        //         .collection('chatroom')
        //         .doc(Chatroomid)
        //         .collection('messages')
        //         .orderBy("time", descending: false)
        //         .snapshots(),
        //     builder: (BuildContext context,
        //         AsyncSnapshot<QuerySnapshot> snapshot) {
        //       print(Chatroomid);
        //       if (snapshot.data != null) {
        //         print(snapshot.data!.docs.length);
        //         return ListView(
        //           children: snapshot.data!.docs.map((document) {
        //             print(document['message']);
        //             return (FlatChatMessage(message: document['message']));
        //           }).toList(),
        //         );

        //         // return ListView(
        //         //   children: [ ],
        //         // );
        //       } else {
        //         return Container();
        //       }
        //     })
        //],
        children: [
          FlatChatMessage(
            message: "Hello World!, This is the first message.",
            messageType: MessageType.sent,
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message: "Typing another message from the input box.",
            messageType: MessageType.sent,
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message: "Message Length Small.",
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message:
                "Message Length Large. This message has more text to configure the size of the message box.",
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message: "Meet me tomorrow at the coffee shop.",
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message: "Around 11 o'clock.",
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message:
                "Flat Social UI kit is going really well. Hope this finishes soon.",
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message: "Final Message in the list.",
            showTime: true,
            time: "2 mins ago",
          ),
        ],
        footer: FlatMessageInputBox(
          onChanged: (val) {
            setState(() {
              print("Changed");
              _message = val;
            });
          },
          onSubmitted: onSendMessage,
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
