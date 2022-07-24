import 'package:firebase_auth/firebase_auth.dart';
import 'package:peergroww/screens/chatpage.dart';
import 'package:peergroww/widgets/chat_widgets/flat_action_btn.dart';
import 'package:peergroww/widgets/chat_widgets/flat_add_story_btn.dart';
import 'package:peergroww/widgets/chat_widgets/flat_chat_item.dart';
import 'package:peergroww/widgets/chat_widgets/flat_counter.dart';
import 'package:peergroww/widgets/chat_widgets/flat_page_header.dart';
import 'package:peergroww/widgets/chat_widgets/flat_page_wrapper.dart';
import 'package:peergroww/widgets/chat_widgets/flat_profile_image.dart';
import 'package:peergroww/widgets/chat_widgets/flat_section_header.dart';
//import 'package:peergroww/screens/chatpage.dart';
import 'package:flutter/material.dart';
import '../services/database.dart' as database;


class ChatListPage extends StatefulWidget {
  static final String id = "ChatListPage";

  @override
  _ChatListPage createState() => _ChatListPage();
}

class _ChatListPage extends State<ChatListPage> {
  @override

  FirebaseAuth _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    String? uuid = _auth.currentUser!.uid.toString();
    return Scaffold(
      body: FlatPageWrapper(
        scrollType: ScrollType.floatingHeader,
        header: FlatPageHeader(
          title: "Group Chats",
          suffixWidget: FlatActionButton(
            iconData: Icons.search,
          ),
        ),
        children: [
          FlatSectionHeader(
            title: "Chats",
          ),



    ListView.builder(
    shrinkWrap: true,
    itemCount: int.parse(database.userdt[uuid]['chatrooms'][0]),
    itemBuilder: (BuildContext context, int index) {
          return FlatChatItem(
            // onPressed: () {
            //   Navigator.pushNamed(context, ChatPage.id);
            // },

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ChatPage(database.userdt[uuid]['chatrooms'][index+1])),
              );
            },
            name: database.userdt[uuid]['chatrooms'][index+1],
            profileImage: FlatProfileImage(
              imageUrl: "",
              //"https://cdn.dribbble.com/users/1281912/avatars/normal/febecc326c76154551f9d4bbab73f97b.jpg?1468927304",
              onlineIndicator: true,
            ),
            message:
            "Hello World!, Welcome to Flutter.", // get latest message here
            multiLineMessage: true,
            // counter: FlatCounter(
            //   text: "1",
            // ),
          );
    }),

          // FlatChatItem(
          //   profileImage: FlatProfileImage(
          //     onlineIndicator: true,
          //     imageUrl: "",
          //     //"https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
          //   ),
          //   name: "DSA learining group",
          // )

        ],
      ),
    );
  }
}
