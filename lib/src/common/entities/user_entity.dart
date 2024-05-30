import 'package:payroll_system/src/common/common.dart';

class UserEntity {
  String id;
  String name;
  String email;
  UserRoles role;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    final role = json['role'] as String;

    final index =
        UserRoles.values.indexWhere((element) => element.toString() == role);

    return UserEntity(
      id: json['\$id'],
      name: json['name'],
      email: json['email'],
      role: UserRoles.values[index],
    );
  }
}
