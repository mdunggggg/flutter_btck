import 'package:firebase_auth/firebase_auth.dart';

class RegisterController {
  final firebaseAuth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  Future<bool> register() async {
    try {
      print('email: $email');
      print('password: $password');
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print('error: $e');
      return false;
    }
  }

}