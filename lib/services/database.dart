import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('User Data');

  bool student = false;

  Future updateUserData(String name, bool counselor, String counselorEmail, String imageUrl) async {
    if(counselor == null){
      counselor = student;
    }
    return await userCollection.doc(uid).set({
      'name': name,
      'Counselor': counselor,
      'imageUrl': imageUrl,
      if(counselor == student)
      'counselors Email': counselorEmail,
    });
  }

  //get user data stream
  Stream<QuerySnapshot> get userData {
    return userCollection.snapshots();
  }

}