import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final firebaseAuth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  Future<bool> login() async {
    try {
      print('email: $email');
      print('password: $password');
      final uid = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print('uid: $uid');
      return true;
    } catch (e) {
      print('error: $e');
      return false;
    }
  }
}