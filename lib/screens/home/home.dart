import 'package:flutter/material.dart';
import 'package:strength_together/services/auth.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("could not launch $command");
    }
  }

  @override
  Widget build(BuildContext context) {
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
              await _auth.signOut();
            },
          )
        ],
      ),
      url:
          "https://webchat.botframework.com/embed/STAPPBOT?s=T3d4crx0NCU.5p8D_mrHFkZdqRjhWTdCqvCMWcHLY1cZq4vYt5IRcm8",
    );
  }
}
