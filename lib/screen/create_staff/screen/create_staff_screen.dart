import 'package:bai_tap_cuoi_ky/base/button.dart';
import 'package:bai_tap_cuoi_ky/base/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/spacing.dart';
import '../../../models/staff_entity.dart';
import '../controller/create_staff_controller.dart';

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({this.staff, super.key});

  final StaffEntity? staff;

  @override
  State<CreateStaffScreen> createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen> {
  final key = GlobalKey<FormState>();
  final createStaffController = CreateStaffController();
  final birthDayController = TextEditingController();

  @override
  void initState() {
    if (widget.staff != null) {
      createStaffController.staffEntity = widget.staff;
      createStaffController.onNameChanged(widget.staff!.name);
      createStaffController.onEmailChanged(widget.staff!.email);
      createStaffController.onDateOfBirtChanged(DateFormat('dd/MM/yyyy').parse(widget.staff!.dateOfBirth));
      birthDayController.text = widget.staff!.dateOfBirth;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.staff != null ? 'Thông tin nhân viên' : 'Tạo nhân viên'),
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
                initialValue: widget.staff?.name,
                onChanged: createStaffController.onNameChanged,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              gapHeight(sp16),
              AppInput(
                hintText: 'Vui lòng nhập email',
                label: 'Email',
                initialValue: widget.staff?.email,
                onChanged: createStaffController.onEmailChanged,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  return null;
                },
              ),
              gapHeight(sp16),
              AppInput(
                hintText: 'Vui lòng nhập ngày sinh',
                label: 'Ngày sinh',
                readOnly: true,
                //initialValue: widget.staff?.dateOfBirth ?? '',
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập ngày sinh';
                  }
                  return null;
                },
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
                title: widget.staff != null ? 'Cập nhật' : 'Tạo',
                event: () {
                  if (key.currentState!.validate()) {
                    if (widget.staff != null) {
                      _handleUpdateStaff();
                    } else {
                      _handleCreateStaff();
                    }
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

  void _handleUpdateStaff() {
    createStaffController.update(widget.staff!.id!);
    Navigator.of(context).pop();
  }
}
