import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('User Data');

  final CollectionReference summaryCollection = FirebaseFirestore.instance.collection('SummaryData');


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

<<<<<<< HEAD
  //get specific user data stream
=======
    //get user data stream
>>>>>>> c210f85b6ebab25e4b1e6147ae3628362a671e43
  Stream<DocumentSnapshot> get specificUserData {
    return userCollection.doc(uid).snapshots();
  }

<<<<<<< HEAD
=======
      //get user data stream
  Stream<DocumentSnapshot> get specificUserSummaryData {
    return summaryCollection.doc(uid).snapshots();
  }

        //get user data stream
  Stream<QuerySnapshot> get allSummaryData {
    return summaryCollection.snapshots();
  }

>>>>>>> c210f85b6ebab25e4b1e6147ae3628362a671e43
}