import 'package:bai_tap_cuoi_ky/base/button.dart';
import 'package:bai_tap_cuoi_ky/base/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/spacing.dart';
import '../controller/create_staff_controller.dart';

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({super.key});

  @override
  State<CreateStaffScreen> createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen> {
  final key = GlobalKey<FormState>();
  final createStaffController = CreateStaffController();
  final birthDayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Staff Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(sp16),
        child: Form(
          key: key,
          child: Column(
            children: [
              AppInput(
                hintText: 'Vui lòng nhập tên',
                label: 'Tên',
                onChanged: createStaffController.onNameChanged,
              ),
              gapHeight(sp16),
              AppInput(
                hintText: 'Vui lòng nhập email',
                label: 'Email',
                onChanged: createStaffController.onEmailChanged,
              ),
              gapHeight(sp16),
              AppInput(
                hintText: 'Vui lòng nhập ngày sinh',
                label: 'Ngày sinh',
                readOnly: true,
                controller: birthDayController,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    locale: const Locale('vi', 'VN'),
                  ).then((value) {
                    if (value != null) {
                      createStaffController.onDateOfBirtChanged(value);
                      birthDayController.text = DateFormat('dd/MM/yyyy').format(value);
                    }
                  });
                },
              ),
              gapHeight(sp16),
              MainButton(
                largeButton: true,
                title: 'Tạo nhân viên',
                event: () {
                  if (key.currentState!.validate()) {
                    _handleCreateStaff();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleCreateStaff() {
    createStaffController.create();
    Navigator.of(context).pop();
  }
}
