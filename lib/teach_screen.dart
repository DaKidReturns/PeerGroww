import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teach extends StatefulWidget {
  @override
  _TeachState createState() => _TeachState();
}

class _TeachState extends State<Teach> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
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
                              decoration: InputDecoration(labelText: 'Subject'),
                            ),
                            TextFormField(
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
                              decoration: InputDecoration(labelText: 'Date'),
                            ),
                            TextFormField(
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

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
