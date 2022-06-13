import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class DatabaseService {
  // final String uid;
  // DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(
      {required String uid,
      required String email,
      required String firstName,
      required String lastName}) async {
    return await userCollection
        .doc(uid)
        .set({'firstName': firstName, 'lastName': lastName, 'email': email});
  }

  Future getUserData(String uid) async {
    if (uid.isNotEmpty) {
      final userDoc = await userCollection.doc(uid).get();
      //DocumentSnapshot userDoc = ud as DocumentSnapshot;
      //print(userDoc);
      print(userDoc);
      return AppUser(
          uid: uid,
          firstName: userDoc.get('firstName'),
          lastName: userDoc.get('lastName'),
          email: userDoc.get('email'));
    }
  }
}
