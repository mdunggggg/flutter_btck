import 'package:bai_tap_cuoi_ky/base/button.dart';
import 'package:bai_tap_cuoi_ky/base/empty_container.dart';
import 'package:bai_tap_cuoi_ky/models/staff_entity.dart';
import 'package:bai_tap_cuoi_ky/screen/home/widgets/staff_card_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';
import '../../../data/remote/firestore_service.dart';
import '../../create_staff/screen/create_staff_screen.dart';

class FirebaseStorageView extends StatefulWidget {
  const FirebaseStorageView({required this.fireStoreService, super.key});

  final FirestoreService fireStoreService;

  @override
  State<FirebaseStorageView> createState() => _FirebaseStorageViewState();
}

class _FirebaseStorageViewState extends State<FirebaseStorageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: StreamBuilder(
          stream: widget.fireStoreService.getAllStaffs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            final data = snapshot.data?.docs;
            if(data == null || data.isEmpty) {
              return const EmptyContainer();
            }
            return Container(
              padding: const EdgeInsets.all(sp16),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final staff = StaffEntity.fromJson(
                    data[index].data() as Map<String, dynamic>,
                  );
                  return Dismissible(
                    key: Key(staff.id.toString()),
                    direction: DismissDirection.endToStart,
                    dismissThresholds: const {DismissDirection.endToStart: 0.2},
                    onDismissed: (direction) async {
                      _handleDelete(staff);
                    },
                    child: InkWell(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateStaffScreen(
                              staff: staff,
                              isLocal: false,
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
                itemCount: data.length,
              ),
            );
          },
        ),
      ),
    );
  }

  _handleDelete(StaffEntity staff) {
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
              widget.fireStoreService.deleteStaff(staff.id);
              Navigator.of(context).pop();
            },
            title: 'Xóa',
          ),
        ],
      ),
    );

  }
}
