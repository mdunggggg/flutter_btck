import 'package:floor/floor.dart';

import '../../../models/staff_entity.dart';

@dao
abstract class StaffDao{

  @Query('SELECT * FROM StaffEntity')
  Future<List<StaffEntity>> findAllStaffs();

  @Query('SELECT * FROM StaffEntity WHERE id = :id')
  Future<StaffEntity?> findStaffById(int id);

  @insert
  Future<void> insertStaff(StaffEntity staff);

  @update
  Future<void> updateStaff(StaffEntity staff);

  @delete
  Future<void> deleteStaff(StaffEntity staff);

}