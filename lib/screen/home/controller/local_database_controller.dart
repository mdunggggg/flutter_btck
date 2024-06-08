import '../../../data/local/database/app_database.dart';
import '../../../models/staff_entity.dart';

class LocalDatabaseController {
  final staffDao = AppDatabase.getInstance().staffDao;

  Future<void> insertStaff(StaffEntity staff) async {
    await staffDao.insertStaff(staff);
  }

  Future<List<StaffEntity>> findAllStaffs() async {
    return await staffDao.findAllStaffs();
  }

  Future<StaffEntity?> findStaffById(int id) async {
    return await staffDao.findStaffById(id);
  }

  Future<void> updateStaff(StaffEntity staff) async {
    await staffDao.updateStaff(staff);
  }

  Future<void> deleteStaff(StaffEntity staff) async {
    await staffDao.deleteStaff(staff);
  }

}