import 'package:flutter/material.dart';
import 'package:strength_together/services/auth.dart';
import 'package:strength_together/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselorHome extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userData,
      child: Scaffold(
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
        body: ListView.builder(itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 50,
              color: Colors.grey[900],
              child: Center(
                child: Text(
                  'Student 2',
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
