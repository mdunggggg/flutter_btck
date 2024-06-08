import 'package:bai_tap_cuoi_ky/data/local/database/app_database.dart';
import 'package:bai_tap_cuoi_ky/screen/create_staff/screen/create_staff_screen.dart';
import 'package:bai_tap_cuoi_ky/screen/home/screen/local_database_view.dart';
import 'package:bai_tap_cuoi_ky/screen/login_screen/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/staff_entity.dart';
import '../controller/local_database_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localDatabaseController = LocalDatabaseController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: [
            IconButton(
              onPressed: () {
                _handleLogout();
              },
              icon: const Icon(Icons.logout_outlined),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Local Database'),
              Tab(text: 'Firebase Storage'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: LocalDatabaseView(
                localDatabaseController: localDatabaseController,
              ),
            ),
            Center(
              child: Text('Tab 2'),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => const CreateStaffScreen(),
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
    showDialog(
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
