import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/features/authentication/authentication.dart';

class SignInBtn extends ConsumerWidget {
  const SignInBtn(this.name, {super.key, required SignInFormEntity form})
      : _form = form;

  final SignInFormEntity _form;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () async {
        try {
          await ref.read(authenticationProvider.notifier).login(_form);
          WidgetsFlutterBinding.ensureInitialized()
              .addPostFrameCallback((timeStamp) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          });
        } catch (e) {
          WidgetsFlutterBinding.ensureInitialized()
              .addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          });
        }
      },
      child: Text(name),
    );
  }
}
