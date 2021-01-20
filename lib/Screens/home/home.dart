import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:strength_together/Screens/home/sessionCompleted.dart';
import 'package:strength_together/services/auth.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:strength_together/services/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:strength_together/models/user.dart';

class Home extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<DocumentSnapshot>.value(
      value: DatabaseService(uid: _auth.currentUser.uid).specificUserData,
      child: HomeChild(),
    );
  }
}

class HomeChild extends StatelessWidget {
  final FirebaseAuth _mainAuth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  final FirebaseAuth _uid = FirebaseAuth.instance;
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
      print(_uid.currentUser.uid);
    } else {
      print("could not launch $command");
      print(_uid.currentUser.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('uid->');
    print(_uid.currentUser.uid);
    print('uid->');

    if (Provider.of<DocumentSnapshot>(context) != null && Provider.of<DocumentSnapshot>(context).data() != null) {
      if (Provider.of<DocumentSnapshot>(context).data()['active'] != null){
          if(Provider.of<DocumentSnapshot>(context).data()['active']) {
        return WebviewScaffold(
          appBar: AppBar(
            title: Text(
              'ST',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
                fontSize: 40,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    customLaunch('tel:+1 708 510 9397');
                  },
                  child: Text(
                    'Panic',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.yellow,
                  size: 20,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  await DatabaseService(uid: _mainAuth.currentUser.uid).updateUserStatus();
                  return await _auth.signOut();
                },
              )
            ],
          ),
          url:
              "https://webchat.botframework.com/embed/STAPPBOT?s=T3d4crx0NCU.5p8D_mrHFkZdqRjhWTdCqvCMWcHLY1cZq4vYt5IRcm8&userid=" +
                  _uid.currentUser.uid,
        );
      } else {
        return SessionCompleted();
      }
      }else{
        return WebviewScaffold(
          appBar: AppBar(
            title: Text(
              'ST',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
                fontSize: 40,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    customLaunch('tel:+1 708 510 9397');
                  },
                  child: Text(
                    'Panic',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.yellow,
                  size: 20,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                   await DatabaseService(uid: _mainAuth.currentUser.uid).updateUserStatus();
                  return await _auth.signOut();
                },
              )
            ],
          ),
          url:
              "https://webchat.botframework.com/embed/STAPPBOT?s=T3d4crx0NCU.5p8D_mrHFkZdqRjhWTdCqvCMWcHLY1cZq4vYt5IRcm8&userid=" +
                  _uid.currentUser.uid,
        );
      }
    } else {
      return Container();
    }
  }
}
