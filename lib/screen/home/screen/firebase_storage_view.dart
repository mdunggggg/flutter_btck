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
      child: RefreshIndicator( // Hiển thị hiệu ứng khi kéo xuống
        onRefresh: () async {
          setState(() {}); // cập nhật lại trạng thái khi kéo xuống
        },
        child: StreamBuilder( // lấy dữ liệu từ firebase
          stream: widget.fireStoreService.getAllStaffs(), // lấy dữ liệu từ firebase
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
            // dữ liệu trả về từ firebase
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
                  return Dismissible( // Taạo hiệu ứng khi vuốt sang trái dể xóa
                    key: Key(staff.id.toString()),
                    direction: DismissDirection.endToStart, // vuốt từ phải sang trái
                    dismissThresholds: const {DismissDirection.endToStart: 0.2},
                    onDismissed: (direction) async { // xử lý khi vuốt
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
    return showDialog( // Hiển thị dialog xác nhận xóa
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
