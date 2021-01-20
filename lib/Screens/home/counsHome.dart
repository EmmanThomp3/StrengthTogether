import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:strength_together/Screens/home/studentInformation.dart';
import 'package:strength_together/services/auth.dart';
import 'package:strength_together/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strength_together/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strength_together/shared/decrypter.dart';

class CounselorHome extends StatelessWidget {
  final SUser user;
  final DocumentSnapshot userData;
  CounselorHome({Key key, this.user, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().allSummaryData,
      child: SecondWidget(user: user, userData: userData),
    );
  }
}

class SecondWidget extends StatelessWidget {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final SUser user;
  final DocumentSnapshot userData;
  SecondWidget({Key key, this.user, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Provider.of<QuerySnapshot>(context) != null) {
      return Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            title: Text(
              'Counselor page',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.yellow,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: ListView.builder(
              itemCount: Provider.of<QuerySnapshot>(context).docs.length,
              itemBuilder: (context, index) {
                var testData;
                testData = json.decode(decryptAESCryptoJS(
                    Provider.of<QuerySnapshot>(context)
                        .docs[index]
                        .data()['encrypted'],
                    'strengthtogether2020'));
                    print(testData);
                return StreamBuilder(
                    stream:
                        DatabaseService(uid: testData['uid']).specificUserData,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        print('---');
                        print(snapshot.data.data());
                        print(auth.currentUser.email);
                        if (snapshot.data.data() != null && snapshot.data.data()['counselors Email'] ==
                            auth.currentUser.email) {
                              print('true');
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Material(
                                child: InkWell(
                                    onTap: () {
                                      var newUserData =
                                          Provider.of<QuerySnapshot>(context,
                                                  listen: false)
                                              .docs[index]
                                              .data();
                                      newUserData['uid'] =
                                          Provider.of<QuerySnapshot>(context,
                                                  listen: false)
                                              .docs[index]
                                              .id;
                                      print(newUserData['uid']);
                                      return Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => StudentInformation(
                                                user: snapshot.data.data(),
                                                summary:testData)),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      color: Colors.grey[900],
                                      child: Center(
                                        child: Text(
                                          snapshot.data.data()['name'] ?? '',
                                          style:
                                              TextStyle(color: Colors.yellow),
                                        ),
                                      ),
                                    ))),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    });
              }));
    } else {
      return Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            title: Text(
              'Counselor page',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.yellow,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: Container());
    }
  }
}
