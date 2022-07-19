import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String uid;
  String firstName;
  String lastName;
  String email;
  String? dateOfBirth;
  String? address;
  int? pincode;
  List<String>? chatIdList;

  AppUser(
  {
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email, 
    this.pincode,
    int year = -1,
    int month = -1,
    int day = -1,
    this.address,
  });
}
