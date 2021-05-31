import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_mobile/models/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFormFirebaseUser(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future girisEmailvePassword(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFormFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future kayitOlEmailvePassword(String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFormFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future cikisYap() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
