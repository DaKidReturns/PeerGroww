import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

Stream<QuerySnapshot> get userNames {
  return FirebaseFirestore.instance.collection('users').snapshots();
}

Map usersData = {};
//static
void startUserListen() async {
  final subsciber = userNames.listen((snapshot) {
    //print("Snapshot: $snapshot");
    snapshot.docs.forEach((element) {
      //print(element.data());
      Map data = element.data() as Map;
      usersData[data['uid']] = data['firstName'];
    });
    // Map data = snapshot.docs as Map;
    // usersData.add(data);
  });
}

class DatabaseService {
  // final String uid;
  // DatabaseService({required this.uid});
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(
      {required String uid,
      required String email,
      required String firstName,
      required String lastName}) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });
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

  DocumentReference getUserDocument(String uuid) {
    return userCollection.doc(uuid);
  }
}
