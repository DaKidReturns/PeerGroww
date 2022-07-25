import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  @override
  _Update createState() => _Update();
}

class _Update extends State<Update> {

  int _currentStep = 0;
  TextEditingController username = TextEditingController();
  TextEditingController institution = TextEditingController();
  TextEditingController skill = TextEditingController();


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
                  padding: const EdgeInsets.only( top: 0),
                  child: const Text(
                    'Update Profile',
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
                      print("\n\n\n\nhihhihihi\n\n\n\n");
                      setState(()=>_currentStep=step);
                    },
                    onStepContinue: ()async{

                      print(_currentStep);
                      print("\n\n\n");
                      _currentStep < 1 ? setState(() => _currentStep += 1) : null;
                      if(_currentStep==1 )
                      {

                        // print("\n\n\n\n"+date.text+"\n\n\n");
                        // print("\n\n\n\n"+time.text+"\n\n\n");
                        DocumentSnapshot docRef =await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).get();
                        Map<String,dynamic> data=docRef.data() as Map<String,dynamic>;
                        //int.parse(data["chatrooms"]);


                        //print("\n\n\nHELOOOOOOOOOOOOOOO"+username.text+"\n\n\n");

                        List skills=  data['skills'] as List;
                        int count=int.parse(data['skills'][0]) ;

                        int flag=0;

                        if(username.text.isEmpty)
                          {
                            data['firstName']=data['firstName'];
                          }
                        else
                          {
                            data['firstName']=username.text;
                          }

                         if(institution.text.isEmpty)
                         {
                           data['institution']=data['institution'];
                         }
                         else
                         {
                           data['institution']=institution.text;
                         }

                         if(skill.text.isEmpty)
                           {
                             flag=1;
                             print("HIIIIIIIIII");
                           }

                        print("\n\n\n\n"+username.text+"\n\n\n");
                        print("\n\n\n\n"+institution.text+"\n\n\n");
                        print("\n\n\n\n"+skill.text+"\n\n\n");

                        for(int i=0;i<count;i++)
                        {
                          if(data["skills"][i]==skill.text)
                          {
                            print("\n\n\nhey sup \n\n\n");
                            flag=1;
                          }
                        }

                        if(flag==0)
                        {count+=1;



                        data["skills"][0]=count.toString();
                        skills.insert( count,skill.text);

                        }
                        await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).update(data);
                        //await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid.toString()).update();
                        // String? name=_auth.currentUser?.displayName;
                        // //String message ="$name is taking ${topic.text} ( ${subject.text} ) at ${venue.text} on ${date.text}";
                        //
                        // Map<String, dynamic> messages = {
                        //   "sendby_uuid": _auth.currentUser!.uid,
                        //   "sendby_displayname": _auth.currentUser!.displayName,
                        //   "message": message,
                        //   "time": FieldValue.serverTimestamp(),
                        //   "chatroomid": username.text,
                        // };

                        //FirebaseFirestore.instance.collection('chatroom').doc(subject.text).collection('messages').doc().set(messages);

                        //int.parse(data["chatrooms"]);





                      }



                    },
                    onStepCancel: (){
                      print("\n\n\n\nHello\n\n\n");
                      _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
                    },
                    steps: <Step>[
                      Step(
                        title: new Text(
                          'Personal Info',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller:username,
                              decoration: InputDecoration(labelText: 'username'),
                            ),
                            TextFormField(
                              controller: institution,
                              decoration: InputDecoration(labelText: 'Institution'),
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
                          'Add Skills',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller:skill,
                              decoration: InputDecoration(labelText: 'Skill name'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
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





}
