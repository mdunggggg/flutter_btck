
import 'package:floor/floor.dart';

@entity
class StaffEntity{
  @primaryKey
  final String id;
  final String name;
  final String email;
  final String dateOfBirth;
  final String avatar;

  StaffEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.avatar,
  });

  factory StaffEntity.fromJson(Map<String, dynamic> json) {
    return StaffEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      avatar: json['avatar'],
    );
  }

}