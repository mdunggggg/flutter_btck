import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../models/staff_entity.dart';
import '../dao/staff_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [StaffEntity])
abstract class AppDatabase extends FloorDatabase {
  static AppDatabase? _instance;

  static AppDatabase getInstance() {
    return _instance!;
  }

  StaffDao get staffDao;
  static Future<void> initDatabase() async {
    _instance =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}