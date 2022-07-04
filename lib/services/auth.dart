import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dataServ = DatabaseService();

  Future signInEmailAndPass(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user;
    } on FirebaseAuthException catch (e) {
      return Future.error(e);
    }
  }

  Future regWithEmailAndPass(
      {required String email,
      required String password,
      required firstName,
      required lastName}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? usr = credential.user;
      _dataServ.updateUserData(
          uid: usr!.uid,
          firstName: firstName,
          lastName: lastName,
          email: email);
      if(usr!=null) {
        print("Account created successfully");
        _auth.currentUser!.updateDisplayName(firstName);
      }


      return credential;
    } on FirebaseAuthException catch (e) {
      print('Error caught ${e.code}');
      return Future.error(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
