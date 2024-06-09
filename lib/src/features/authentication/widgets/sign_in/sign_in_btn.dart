import 'package:flutter/material.dart';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/features/authentication/authentication.dart';

class SignInBtn extends ConsumerWidget {
  const SignInBtn(this.name, {super.key, required SignInFormEntity form})
      : _form = form;

  final SignInFormEntity _form;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authenticationProvider);

    final button = FilledButton(
      onPressed: () async {
        final response =
            await ref.read(authenticationProvider.notifier).login(_form);

        if (response != null && response.isSignedIn == true) {
          WidgetsFlutterBinding.ensureInitialized()
              .addPostFrameCallback((timeStamp) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          });

          ref.read(authenticationProvider.notifier).setState(response);
        }
      },
      child: Text(name),
    );

    return authProvider.when(
      data: (data) {
        return button;
      },
      error: (error, stackTrace) {
        final message = error as AppwriteException;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${message.message}"),
            ),
          );
        });

        return button;
      },
      loading: () {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
