import 'package:flutter/material.dart';

import 'package:payroll_system/src/common/common.dart';

class SignUpFormEntity {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String get name => nameController.text;
  String get email => emailController.text;
  String get password => passwordController.text;

  Map<String, String> toJson() {
    return {
      'name': name,
      'email': email,
      'role': UserRoles.employer.toString(),
    };
  }
}
