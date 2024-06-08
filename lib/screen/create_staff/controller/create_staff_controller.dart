import 'package:bai_tap_cuoi_ky/data/local/dao/staff_dao.dart';
import 'package:bai_tap_cuoi_ky/data/local/database/app_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../models/staff_entity.dart';

class CreateStaffController {
  final StaffDao staffDao = AppDatabase.getInstance().staffDao;

  late String _name = '';
  String get name => _name;

  late String _email = '';
  String get email => _email;

  late DateTime _dateOfBirt;
  DateTime get dateOfBirt => _dateOfBirt;

  late String avatar = '';
  String get getAvatar => avatar;

  StaffEntity? staffEntity;
  StaffEntity? get getStaffEntity => staffEntity;




  void onNameChanged(String value) {
    _name = value;
  }

  void onEmailChanged(String value) {
    _email = value;
  }

  void onDateOfBirtChanged(DateTime value) {
    _dateOfBirt = value;
  }

  void onAvatarChanged(String value) {
    avatar = value;
  }

  Future<void> create() async {
    await staffDao.insertStaff(StaffEntity(
      name: _name,
      email: _email,
      dateOfBirth: DateFormat('dd/MM/yyyy').format(dateOfBirt),
      avatar: avatar,
    ));
  }

  Future<void> update(int id) async {
    await staffDao.updateStaff(StaffEntity(
      id: id,
      name: _name,
      email: _email,
      dateOfBirth: DateFormat('dd/MM/yyyy').format(dateOfBirt),
      avatar: avatar,
    ));
  }

}
