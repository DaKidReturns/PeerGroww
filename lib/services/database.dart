import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class DatabaseService {
  // final String uid;
  // DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(String uid, String firstName, String lastName) async {
    return await userCollection
        .doc(uid)
        .set({'fistName': firstName, 'lastName': lastName});
  }

  Future getUserData(String uid) async {
    if (uid.isNotEmpty) {
      final userDoc = userCollection.doc(uid).get();
      print(userDoc);
    }
  }
}
