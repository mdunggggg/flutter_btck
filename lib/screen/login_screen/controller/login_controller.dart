import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final firebaseAuth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  Future<bool> login() async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}