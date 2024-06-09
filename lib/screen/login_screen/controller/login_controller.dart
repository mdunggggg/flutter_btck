import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/remote/firestore_service.dart';

class LoginController {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirestoreService().firestore;

  String email = '';
  String password = '';

  // Đăng nhập
  Future<bool> login() async {
    try {
      final user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _handleFirebase(user);
      return true;
    } catch (e) {
      print('error: $e');
      return false;
    }
  }


  // Thêm thông tin người dùng vào Firestore (nếu chưa tồn tại)
  void _handleFirebase(UserCredential user) {
    if(user.user != null) {
      firebaseFirestore.collection('users').doc(user.user!.uid).get().then((value) {
        if(value.exists) {
          print('User exists');
        } else {
          firebaseFirestore.collection('users').doc(user.user!.uid).set(
            {
              'email': user.user!.email,
            }
          );
        }
      });
    }
  }
}