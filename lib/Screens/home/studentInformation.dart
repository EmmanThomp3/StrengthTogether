import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:strength_together/Screens/authenticate/sign_in.dart';
import 'package:strength_together/services/auth.dart';
import 'package:strength_together/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strength_together/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strength_together/shared/decrypter.dart';
import 'package:strength_together/shared/loading.dart';

class StudentInformation extends StatefulWidget {
  final Map<String, dynamic> user;
  final Map<String, dynamic> summary;
  StudentInformation({Key key, this.user, this.summary}) : super(key: key);

  @override
  _StudentInformationState createState() => _StudentInformationState();
}

class _StudentInformationState extends State<StudentInformation> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<QuerySnapshot> stream;
  var chosenData = {};

  @override
  void initState() {
    super.initState();
    stream = DatabaseService().allSummaryData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text(
            'Student Information',
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
                return Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SignIn()),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            // height: 50,
            color: Colors.grey[900],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      //  mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Material(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Loading(),
                              errorWidget: (context, url, error) => Material(
                                child: Icon(Icons.error, size: 200),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              imageUrl: widget.user['imageUrl'] ?? '',
                              width: 140.0,
                              height: 140.0,
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(70.0)),
                          ),
                        )
                      ]),
                  SizedBox(height: 20),
                  Text(
                    widget.user['name'] ?? '',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  SizedBox(height: 20),
                  Column(children: <Widget>[
                    Text(
                      'Average Intensity: ' +
                              widget.summary['avgIntensity'].toString() ??
                          '',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    Text(
                      'Average Score: ' +
                              widget.summary['avgScore'].toString() ??
                          '',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    Text(
                      'Keywords: ' + widget.summary['keywords'].toString() ??
                          '',
                      style: TextStyle(color: Colors.yellow),
                    )
                  ])
                ]),
          ),
        ));
  }
}
