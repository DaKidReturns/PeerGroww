import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teach extends StatefulWidget {
  @override
  _TeachState createState() => _TeachState();
}

class _TeachState extends State<Teach> {
  int _currentStep = 0;
  TextEditingController subject = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController venue = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.20),
                Container(
                  padding: const EdgeInsets.only(right: 250, top: 10),
                  child: const Text(
                    'Teach',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step){
                      //print("\n\n\n\nhihhihihi\n\n\n\n");
                      setState(()=>_currentStep=step);
                    },
                    onStepContinue: () async {

                      print("Current step: $_currentStep\n");
                      //print("\n\n\n");
                      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
                      if(_currentStep==2 && time.text.isNotEmpty)
                        {
                          print("\n\n\n\n"+subject.text+"\n\n\n");
                          print("\n\n\n\n"+topic.text+"\n\n\n");
                          print("\n\n\n\n"+venue.text+"\n\n\n");
                          print("\n\n\n\n"+date.text+"\n\n\n");
                          print("\n\n\n\n"+time.text+"\n\n\n");
                          DocumentSnapshot docRef = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).get();
                          Map<String,dynamic> data=docRef.data() as Map<String,dynamic>;
                          //int.parse(data["chatrooms"]);

                          //DocumentSnapshot chatdocref = await FirebaseFirestore.instance.collection('chatrooms').doc(_auth.currentUser!.uid.toString()).get();
                          List chatrooms=  data['chatrooms'] as List;
                          int count=int.parse(data['chatrooms'][0]) ;
                          int flag=0;
                          if(chatrooms.contains(subject.text)){
                            print("\n\nNumber of ${subject.text} = $count\n\n");
                            flag = 1;
                          }else{
                              print("\n\n\nChat not found\n\n\n");
                          }
                          // for(int i=0;i<count;i++)
                          //   {
                          //     if(data["chatrooms"][i]==subject.text)
                          //       {
                          //         print("\n\n\nhey sup \n\n\n");
                          //         flag=1;
                          //       }
                          //   }

                          if(flag==0)
                          {
                            count+=1;

                            print("\n\n\nhey sup123 \n\n\n");

                            data["chatrooms"][0]=count.toString();
                            chatrooms.insert( count,subject.text);
                            await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).update(data);
                          }
                          //await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).update();
                          String? name=_auth.currentUser?.displayName;
                          String message ="$name is taking ${topic.text} ( ${subject.text} ) at ${venue.text} on ${date.text}";

                          Map<String, dynamic> messages = {
                            "sendby_uuid": _auth.currentUser!.uid,
                            "sendby_displayname": _auth.currentUser!.displayName,
                            "message": message,
                            "time": FieldValue.serverTimestamp(),
                            "chatroomid": subject.text,
                          };

                            FirebaseFirestore.instance.collection('chatroom').doc(subject.text).collection('messages').doc().set(messages);
                            Map<String,dynamic> data1=docRef.data() as Map<String,dynamic>;
                          //int.parse(data["chatrooms"]);

                           Map<String, dynamic> newsubject = {
                              "subject": subject.text,
                           };
                          FirebaseFirestore.instance.collection('subject').doc(subject.text).set(newsubject);
                          if(flag == 0){
                            await alertDialog(context,"Group Created successfully");
                          }
                          else {
                            await alertDialog(context,"Study scheduled successfully");
                          }
                          setState(() {
                            subject.clear();
                            venue.clear();
                            date.clear();
                            topic.clear();
                            time.clear();
                            _currentStep = 0;});

                        }
                    },
                    onStepCancel: (){
                      print("\n\n\n\nHello\n\n\n");
                      _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
                    },
                    steps: <Step>[
                      Step(
                        title: new Text(
                          'Subject',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller:subject,
                              decoration: InputDecoration(labelText: 'Subject'),
                            ),
                            TextFormField(
                              controller: topic,
                              decoration: InputDecoration(labelText: 'Topic'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text(
                          'Venue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller:venue,
                              decoration: InputDecoration(labelText: 'Venue'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text(
                          'Date & Time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller:date,
                              decoration: InputDecoration(labelText: 'Date'),
                            ),
                            TextFormField(
                              controller:time,
                              decoration: InputDecoration(labelText: 'Time'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }


  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

Future<dynamic> alertDialog( BuildContext context,String successMessage) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Done'),
          content: Text(successMessage),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
