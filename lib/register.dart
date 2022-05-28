import 'services/auth.dart';
import 'widgets/form_fields.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  FormFieldsDecoration.textFieldDecoration(
                                      hintText: "Name"),
                              onChanged: (val) => setState(() => name = val),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 41, 41)),
                              decoration:
                                  FormFieldsDecoration.textFieldDecoration(
                                      hintText: "Email"),
                              onChanged: (val) => setState(() {
                                email = val;
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  FormFieldsDecoration.textFieldDecoration(
                                      hintText: "Password"),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () async {
                                        //if (_formKey.currentState!.validate()) {
                                        dynamic result =
                                            await _auth.regWithEmailAndPass(
                                                email: email,
                                                password: password);
                                        //}
                                        if (result != null) {
                                          Navigator.pushNamed(context, '/home');
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: const Text(
                                    'Sign In',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  style: const ButtonStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
