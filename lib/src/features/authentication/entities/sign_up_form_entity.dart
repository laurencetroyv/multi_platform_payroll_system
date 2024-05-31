import 'package:flutter/material.dart';

import 'package:payroll_system/src/common/common.dart';

class SignUpFormEntity {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController employeeId = TextEditingController();

  String get name => nameController.text;
  String get email => emailController.text;
  String get password => passwordController.text;
  String get id => employeeId.text;

  String get employerRole => UserRoles.employer.toString();
  String get employeeRole => UserRoles.employee.toString();

  Map<String, String> toJson({String? name}) {
    return {
      'name': this.name.isNotEmpty ? this.name : name!,
      'email': email,
      'role': id.isNotEmpty ? employeeRole : employerRole,
      'employeeId': id,
    };
  }
}
