import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strength_together/models/user.dart';
import 'package:strength_together/services/auth.dart';
import 'package:strength_together/Screens/home/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strength_together/Screens/authenticate/sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<SUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );

  }
}
