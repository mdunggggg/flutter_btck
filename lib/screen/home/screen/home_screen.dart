import 'package:bai_tap_cuoi_ky/constants/colors.dart';
import 'package:bai_tap_cuoi_ky/screen/create_staff/screen/create_staff_screen.dart';
import 'package:bai_tap_cuoi_ky/screen/home/screen/local_database_view.dart';
import 'package:bai_tap_cuoi_ky/screen/login_screen/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/remote/firestore_service.dart';
import '../controller/local_database_controller.dart';
import 'firebase_storage_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localDatabaseController = LocalDatabaseController();
  final fireStoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( // Tạo TabBar
      length: 2, // Số lượng tab
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Trang chủ'),
          backgroundColor: whiteColor,
          actions: [
            IconButton(
              onPressed: () {
                _handleLogout();
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
          bottom: const TabBar( // Các tab
            tabs: [
              Tab(text: 'Local Database'),
              Tab(text: 'Firebase Storage'),
            ],
          ),
        ),
        body: TabBarView( // Nội dung của các tab
          children: [
            Center(
              child: LocalDatabaseView(
                localDatabaseController: localDatabaseController,
              ),
            ),
            Center(
              child: FirebaseStorageView(
                fireStoreService: fireStoreService,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => const CreateStaffScreen(

                    ),
                  ),
                )
                .then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _handleLogout() {
    showDialog( // Hiển thị dialog xác nhận đăng xuất
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: const Text('Đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }
}
