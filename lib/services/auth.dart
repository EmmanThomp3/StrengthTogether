import 'package:firebase_auth/firebase_auth.dart';
import 'package:strength_together/models/user.dart';
import 'package:strength_together/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //instance of counselor
  bool _counselor;

  bool get counselor => counselor;

  void setCounselor(bool counselor) {
    _counselor = counselor;
  }

  //create user obj based on firebase user from my code
  SUser _userFromFirebaseUser(User user) {
    return user != null ? SUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<SUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //method to sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //method to sign in with email/pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //method to register with email/pass
  Future registerWithEmailAndPassword(
      String email, String password, String name, String counselorEmail) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create a new document for that user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData(name, _counselor, counselorEmail);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with google

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
