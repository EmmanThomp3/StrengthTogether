import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('User Data');

  Future updateUserData(String name, bool counselor) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'Counselor': counselor,

    });
  }

  //get user data stream
  Stream<QuerySnapshot> get userData {
    return userCollection.snapshots();
  }

}