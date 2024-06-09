import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final firestore = FirebaseFirestore.instance;
  final authFirebase = FirebaseAuth.instance;
  final uuid = const Uuid();

  Stream<QuerySnapshot> getAllStaffs() {
    final user = authFirebase.currentUser;
    return firestore
        .collection('users')
        .doc(user!.uid)
        .collection('staffs')
        .snapshots();
  }

  Future<void> createStaff(Map<String, dynamic> data) async {
    final user = authFirebase.currentUser;
    firestore
        .collection('users')
        .doc(user!.uid)
        .collection('staffs')
        .doc(data['id'])
        .set(data);
  }

  Future<void> deleteStaff(String id) async {
    final user = authFirebase.currentUser;
    try {
      await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('staffs')
          .doc(id)
          .delete();
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
          .update(data);
    } catch (e) {
      print('Error: $e');
    }
  }
}
