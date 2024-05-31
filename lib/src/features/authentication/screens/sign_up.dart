import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final SignUpFormEntity _form = SignUpFormEntity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        automaticallyImplyLeading: false,
        elevation: kIsWeb || Platform.isWindows ? 256 : null,
      ),
      body: FutureBuilder(
        future: ref.read(authenticationProvider.notifier).getEmployeeIds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final ids = snapshot.data as List<EmployeeIds>;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: kIsWeb || Platform.isWindows
                ? SignUpWebView(ids, form: _form)
                : SignUpMobileView(ids, form: _form),
          );
        },
      ),
    );
  }
}
