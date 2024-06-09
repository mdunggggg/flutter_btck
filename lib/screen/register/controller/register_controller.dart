import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/remote/firestore_service.dart';

class RegisterController {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirestoreService().firestore;

  String email = '';
  String password = '';

  Future<bool> register() async {
    try {
      // Đăng ký tài khoản
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _addUserToFirestore(userCredential);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  // Thêm thông tin người dùng vào Firestore (nếu chưa tồn tại)
  void _addUserToFirestore(UserCredential user) {
    if (user.user != null) {
      firebaseFirestore.collection('users').doc(user.user!.uid).set({
        'email': user.user!.email,
      });
    }
  }
}
