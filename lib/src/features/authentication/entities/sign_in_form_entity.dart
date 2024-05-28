import 'package:flutter/material.dart';

class SignInFormEntity {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool saveSession = false;

  String get email => emailController.text;
  String get password => passwordController.text;
}
