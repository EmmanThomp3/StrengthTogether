import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strength_together/Screens/authenticate/authenticate.dart';
import 'package:strength_together/Screens/home/counsHome.dart';
import 'package:strength_together/Screens/home/home.dart';
import 'package:strength_together/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//final user = Provider.of<User>(context);
class Wrapper extends StatefulWidget {
  WrapperState createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  Future<DocumentSnapshot> dataSnapshot;
  final FirebaseAuth auth = FirebaseAuth.instance;

  SUser getUser(BuildContext context) {
    return Provider.of<SUser>(context);
  }

  dynamic getStartingPage(bool counselor, SUser user) {
    if (user == null || user.uid == null) {
      return Authenticate();
    } else if (counselor == true) {
      print('true');
      print(user);
      return CounselorHome();
    } else if (counselor == false || counselor == null) {
      print('\n' + 'false');
      print(user.uid);
      return Home();
    }
  }

  Future<DocumentSnapshot> getDataSnapshotForCounselor() async {
    var uid = '';
    final User user = auth.currentUser;
    if (user != null) {
      uid = user.uid;
      return await FirebaseFirestore.instance
          .collection('User Data')
          .doc(uid)
          .get();
    } else {
      uid = '';
      return null;
    }
  }

  bool getCounselorValue(DocumentSnapshot dataSnapshotForCounselor) {
    print(dataSnapshotForCounselor.data());
    //modify this by passing proper keyValue to get counselor.
    if (dataSnapshotForCounselor.data() != null) {
      return dataSnapshotForCounselor.data()['Counselor'];
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    dataSnapshot = getDataSnapshotForCounselor();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDataSnapshotForCounselor(),
        builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            print('has data');

            return getStartingPage(
                getCounselorValue(snapshot.data), getUser(context));
          }
          return Authenticate();
        });
  }
}
