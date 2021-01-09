import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:strength_together/services/auth.dart';
import 'package:strength_together/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strength_together/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strength_together/shared/loading.dart';

<<<<<<< HEAD
=======

>>>>>>> c210f85b6ebab25e4b1e6147ae3628362a671e43
class SessionCompleted extends StatelessWidget {
  final AuthService _auth = AuthService();
  final Map<String, dynamic> user;
  SessionCompleted({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text(
            'Session Completed',
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
<<<<<<< HEAD
            // height: 50,
=======
           // height: 50,
>>>>>>> c210f85b6ebab25e4b1e6147ae3628362a671e43
            color: Colors.grey[900],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
<<<<<<< HEAD
                   'You\'ve completed your session ',
=======
                    'Session Completed',
>>>>>>> c210f85b6ebab25e4b1e6147ae3628362a671e43
                    style: TextStyle(color: Colors.yellow),
                  ),
                ]),
          ),
        ));
  }
}
