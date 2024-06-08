import 'package:bai_tap_cuoi_ky/data/local/database/app_database.dart';
import 'package:bai_tap_cuoi_ky/screen/home/screen/local_database_view.dart';
import 'package:flutter/material.dart';

import '../../../models/staff_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Home Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Local Database'),
              Tab(text: 'Firebase Storage'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: LocalDatabaseView(),
            ),
            Center(
              child: Text('Tab 2'),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppDatabase.getInstance().staffDao.insertStaff(
                StaffEntity(
                  name: 'Nguyen Van A',
                  email: 'abcd@gmail.com',
                  dateOfBirth: '1999-01-01',
                  avatar: '',
                )
            );
          },
          child: const Icon(Icons.add),
        )
      ),
    );
  }
}
