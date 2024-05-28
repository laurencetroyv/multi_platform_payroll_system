import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/features/authentication/entities/entities.dart';
import 'package:payroll_system/src/features/authentication/providers/authentication_provider.dart';

class SignUpBtn extends ConsumerWidget {
  const SignUpBtn(this.name, {super.key, required SignUpFormEntity form})
      : _form = form;

  final SignUpFormEntity _form;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () async {
        final response =
            await ref.read(authenticationProvider.notifier).signUp(_form);
        if (response) {
          WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
            Navigator.pop(context);
          });
        }
      },
      child: Text(name),
    );
  }
}
