import 'package:bai_tap_cuoi_ky/base/button.dart';
import 'package:bai_tap_cuoi_ky/base/text_field.dart';
import 'package:bai_tap_cuoi_ky/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/spacing.dart';
import '../../../models/staff_entity.dart';
import '../controller/create_staff_controller.dart';

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({this.isLocal, this.staff, super.key});

  final StaffEntity? staff;
  final bool? isLocal;


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
      createStaffController.onDateOfBirtChanged(
          DateFormat('dd/MM/yyyy').parse(widget.staff!.dateOfBirth),);
      birthDayController.text = widget.staff!.dateOfBirth;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('===============local${widget.isLocal}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.staff != null ? 'Thông tin nhân viên' : 'Tạo nhân viên',),
        backgroundColor: whiteColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(sp16),
        decoration: const BoxDecoration(
          color: whiteColor,
        ),
        child: Form(
          key: key,
          child: Column(
            children: [
              widget.isLocal == null ? Row(children: [
                Expanded(
                  child: ExtraButton(
                    title: 'Local Database',
                    event: () {
                      createStaffController.setIsLocal();
                      setState(() {});
                    },
                    borderColor:
                        createStaffController.isLocal ? mainColor : greyColor,
                    backgroundColor:
                        createStaffController.isLocal ? mainColor : whiteColor,
                    textColor:
                        createStaffController.isLocal ? whiteColor : blackColor,
                  ),
                ),
                gapWidth(sp16),
                Expanded(
                  child: ExtraButton(
                    title: 'Firebase Storage',
                    event: () {
                      createStaffController.setIsRemote();
                      setState(() {});
                    },
                    borderColor:
                    createStaffController.isRemote ? mainColor : greyColor,
                    backgroundColor:
                    createStaffController.isRemote ? mainColor : whiteColor,
                    textColor:
                    createStaffController.isRemote ? whiteColor : blackColor,
                  ),
                ),
              ],) : Container(),
              gapHeight(sp16),
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
                      birthDayController.text =
                          DateFormat('dd/MM/yyyy').format(value);
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
                    if(!createStaffController.isLocal && !createStaffController.isRemote){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: red_1,
                          content: Text('Vui lòng chọn loại lưu trữ'),
                        ),
                      );
                      return;
                    }
                    if (widget.staff != null) {
                      _handleUpdateStaff();
                    } else {
                      _handleCreateStaff();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleCreateStaff() async {
    await createStaffController.create();
    Navigator.of(context).pop();
  }

  void _handleUpdateStaff() {
    if(widget.isLocal == true) {
      createStaffController.updateLocal(widget.staff!.id);
    }
    else {
      createStaffController.updateRemote(widget.staff!.id);
    }
    Navigator.of(context).pop();
  }
}
