import 'package:bai_tap_cuoi_ky/data/local/dao/staff_dao.dart';
import 'package:bai_tap_cuoi_ky/data/local/database/app_database.dart';
import 'package:bai_tap_cuoi_ky/data/remote/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../models/staff_entity.dart';

class CreateStaffController {
  final StaffDao staffDao = AppDatabase.getInstance().staffDao;
  final FirestoreService firestoreService = FirestoreService();
  final uuid = const Uuid();

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

  bool isLocal = true;

  bool get getIsLocal => isLocal;

  bool isRemote = false;

  void setIsLocal() {
    isLocal = !isLocal;
  }

  void setIsRemote() {
    isRemote = !isRemote;
  }

  void setStaffEntity(StaffEntity value) {
    staffEntity = value;
  }

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
    if (isLocal) {
      await staffDao.insertStaff(
        StaffEntity(
          id: uuid.v4(),
          name: _name,
          email: _email,
          dateOfBirth: DateFormat('dd/MM/yyyy').format(dateOfBirt),
          avatar: avatar,
        ),
      );
    }
    if (isRemote) {
      final req = {
        'id': uuid.v4(),
        'name': _name,
        'email': _email,
        'dateOfBirth': DateFormat('dd/MM/yyyy').format(dateOfBirt),
        'avatar': avatar,
      };
      await firestoreService.createStaff(req);
    }
  }

  Future<void> updateLocal(String id) async {
    if (isLocal) {
      await staffDao.updateStaff(
        StaffEntity(
          id: id,
          name: _name,
          email: _email,
          dateOfBirth: DateFormat('dd/MM/yyyy').format(dateOfBirt),
          avatar: avatar,
        ),
      );
    }
  }

  Future<void> updateRemote(String id) async {
    final req = {
      'id': id,
      'name': _name,
      'email': _email,
      'dateOfBirth': DateFormat('dd/MM/yyyy').format(dateOfBirt),
      'avatar': avatar,
    };
    await firestoreService.updateStaff(req);
  }
}
