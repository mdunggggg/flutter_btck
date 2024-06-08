import 'package:bai_tap_cuoi_ky/base/button.dart';
import 'package:bai_tap_cuoi_ky/base/empty_container.dart';
import 'package:bai_tap_cuoi_ky/screen/home/widgets/staff_card_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/spacing.dart';
import '../../../models/staff_entity.dart';
import '../../create_staff/screen/create_staff_screen.dart';
import '../controller/local_database_controller.dart';

class LocalDatabaseView extends StatefulWidget {
  const LocalDatabaseView({required this.localDatabaseController, super.key});

  final LocalDatabaseController localDatabaseController;

  @override
  State<LocalDatabaseView> createState() => _LocalDatabaseViewState();
}

class _LocalDatabaseViewState extends State<LocalDatabaseView> {

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: FutureBuilder(
        future: widget.localDatabaseController.findAllStaffs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final staffs = snapshot.data as List<StaffEntity>;
          if(staffs.isEmpty) return const EmptyContainer();
          return Container(
            padding: const EdgeInsets.all(sp16),
            child: ListView.builder(
              itemCount: staffs.length,
              itemBuilder: (context, index) {
                final staff = staffs[index];
                return Dismissible(
                  key: Key(staff.id.toString()),
                  direction: DismissDirection.startToEnd,
                  dismissThresholds: const {DismissDirection.endToStart: 0.2},
                  onDismissed: (direction) async {
                    _handleDelete(staff).then(
                      (value) => setState(() {}),
                    );
                  },
                  child: InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateStaffScreen(
                            staff: staff,
                          ),
                        ),
                      ).then((value) {
                        setState(() {});

                      });
                    },
                    child: StaffCardView(
                      staff: staff,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleDelete(StaffEntity staff) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc chắn muốn xóa nhân viên này không?'),
        actions: [
          MainButton(
            event: () {
              //localDatabaseController.deleteStaff(staff);
              Navigator.of(context).pop();
            },
            title: 'Hủy',
          ),
          MainButton(
            event: () {
              widget.localDatabaseController.deleteStaff(staff);
              Navigator.of(context).pop();
            },
            title: 'Xóa',
          ),
        ],
      ),
    );
  }
}
