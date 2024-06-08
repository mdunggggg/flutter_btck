
import 'package:floor/floor.dart';

@entity
class StaffEntity{
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String name;
  final String email;
  final String dateOfBirth;
  final String avatar;

  StaffEntity({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.avatar,
  });

}