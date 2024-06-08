import 'package:bai_tap_cuoi_ky/screen/home/widgets/staff_card_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/spacing.dart';
import '../../../models/staff_entity.dart';
import '../controller/local_database_controller.dart';

class LocalDatabaseView extends StatefulWidget {
  const LocalDatabaseView({super.key});

  @override
  State<LocalDatabaseView> createState() => _LocalDatabaseViewState();
}

class _LocalDatabaseViewState extends State<LocalDatabaseView> {
  final localDatabaseController = LocalDatabaseController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: FutureBuilder(
        future: localDatabaseController.findAllStaffs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final staffs = snapshot.data as List<StaffEntity>;
          return Container(
            padding: const EdgeInsets.all(sp16),
            child: ListView.builder(
              itemCount: staffs.length,
              itemBuilder: (context, index) {
                final staff = staffs[index];
                return StaffCardView(
                  staff: staff,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
