import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'dart:math';
import '../services/database.dart' as database;

class Search extends StatefulWidget {
  static final String id = "ChatListPage";

  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  bool searchButton = false;
  int length=0;
  @override
  TextEditingController search = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> subjectdata=[];

  Widget build(BuildContext context) {

    String? uuid = _auth.currentUser!.uid.toString();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Group Chats"),
      // ),
      body: FlatPageWrapper(
        scrollType: ScrollType.floatingHeader,
        header: FlatPageHeader(
          title: "Study Something",

          suffixWidget: FlatActionButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              setState(() {
                searchButton=!searchButton;
              });

              int index=0;
              if(search.text != "") {
                print("\n\n"+ search.text + "\n\n");
                QuerySnapshot subjects =
                await FirebaseFirestore.instance.collection('subject').get();
                //print("bitch\n\n");
                length=subjects.docs.length;
                subjects.docs
                    .map((doc) {
                  if (doc.exists) print(doc.data());
                  subjectdata.insert(
                      index++, doc.data() as Map<String, dynamic>);
                }).toList();
                //print(subjectdata.length);
              }
            },
          ),




          // suffixWidget:Row(
          // children:[
          //   TextFormField(
          //     controller:search,
          //     decoration: InputDecoration(labelText: 'Study something'),
          //   ),
          //   FlatActionButton(
          //   iconData: Icons.search,
          // ),
          // ],),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: search,
              decoration: InputDecoration(hintText: 'Search for peer groups',
                  hintStyle: TextStyle(color: Color.fromARGB(100, 80, 80, 80)),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 20)),
              ),

            ),
          ),
          FlatSectionHeader(
            title: "",
          ),

          searchButton?ListView.builder(
              shrinkWrap: true,
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                bool check=false;

                    int len=min(subjectdata[index]['subject'].length,search.text.length);
                    int searchlen=search.text.length;
                    for(int j=0;j<subjectdata[index]['subject'].length-len;j++)
                    {

                      //print("HIHIHI\n\n\n"+subjectdata[index]['subject']+"\n\n\n");
                      String result=subjectdata[index]['subject'].substring(j,searchlen+j);
                      if(result==search.text)
                        {
                          check=true;

                        }
                    }
                if(check==true)
                {return FlatChatItem(
                  // onPressed: () {
                  //   Navigator.pushNamed(context, ChatPage.id);
                  // },

                  onPressed: () async {


                    DocumentSnapshot docRef =await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).get();
                    Map<String,dynamic> data=docRef.data() as Map<String,dynamic>;
                    //int.parse(data["chatrooms"]);


                    List chatrooms=  data['chatrooms'] as List;
                    int count=int.parse(data['chatrooms'][0]) ;
                    int flag=0;
                    for(int i=0;i<count;i++)
                    {
                      if(data["chatrooms"][i]==subjectdata[index]['subject'])
                      {
                        print("\n\n\nhey sup \n\n\n");
                        flag=1;
                      }
                    }

                    if(flag==0)
                    {count+=1;



                    data["chatrooms"][0]=count.toString();
                    chatrooms.insert( count,subjectdata[index]['subject']);
                    await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).update(data);
                    }


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPage(
                              subjectdata[index]["subject"])),
                    );
                  },
                  name: subjectdata[index]["subject"],
                  profileImage: FlatProfileImage(
                    imageUrl: "",
                    //"https://cdn.dribbble.com/users/1281912/avatars/normal/febecc326c76154551f9d4bbab73f97b.jpg?1468927304",
                    onlineIndicator: true,
                  ),
                  message:
                      "Just tap here to start learning ${subjectdata[index]["subject"]}", // get latest message here
                  multiLineMessage: true,
                  // counter: FlatCounter(
                  //   text: "1",
                  // ),
                );}
                else
                  {
                    return SizedBox();
                  }


              }):SizedBox(),

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
