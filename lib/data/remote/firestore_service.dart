import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final firestore = FirebaseFirestore.instance; // Lấy ra firestore từ FirebaseFirestore
  final authFirebase = FirebaseAuth.instance; // Lấy ra authFirebase từ FirebaseAuth
  final uuid = const Uuid();

  Stream<QuerySnapshot> getAllStaffs() {
    final user = authFirebase.currentUser; // Lấy ra user hiện tại
    return firestore
        .collection('users') // Lấy ra collection users
        .doc(user!.uid) // Lấy ra document theo id của user
        .collection('staffs') // Lấy ra collection staffs
        .snapshots(); // Lấy ra dữ liệu dạng stream
  }

  Future<void> createStaff(Map<String, dynamic> data) async {
    final user = authFirebase.currentUser;
    firestore
        .collection('users')
        .doc(user!.uid)
        .collection('staffs')
        .doc(data['id']) // Lấy ra document theo id của staff
        .set(data); // Thêm dữ liệu vào document
  }

  Future<void> deleteStaff(String id) async {
    final user = authFirebase.currentUser;
    try {
      await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('staffs')
          .doc(id)
          .delete(); // Xóa dữ liệu theo id
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateStaff(Map<String, dynamic> data) async {
    final user = authFirebase.currentUser;
    try {
      await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('staffs')
          .doc(data['id'])
          .update(data); // Cập nhật dữ liệu theo id
    } catch (e) {
      print('Error: $e');
    }
  }
}
