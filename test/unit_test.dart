import 'package:bai_tap_cuoi_ky/data/local/database/app_database.dart';
import 'package:bai_tap_cuoi_ky/models/staff_entity.dart';
import 'package:flutter_test/flutter_test.dart';

main() async {
  await AppDatabase.initDatabase();
  final database = AppDatabase.getInstance();
  final staffDao = database.staffDao;
  test('Test database', () async {
    final staff = StaffEntity(
      name: 'Nguyen Van A',
      email: 'abcd@gmail.com',
      dateOfBirth: '1999-01-01',
      avatar: 'https://www.google.com',
    );
    await staffDao.insertStaff(staff);
    final staffs = await staffDao.findAllStaffs();
    expect(staffs.length, 1);
    expect(staffs[0].name, staff.name);
  });
}