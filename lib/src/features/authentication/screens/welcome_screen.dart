import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/common/common.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Image.asset('assets/images/illustration.png'),
            const Gap(32),
            const Text(
              welcomeText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Gap(32),
            SizedBox(
              width: 232,
              child: FilledButton(
                onPressed: () => Navigator.pushNamed(context, 'sign-in'),
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
