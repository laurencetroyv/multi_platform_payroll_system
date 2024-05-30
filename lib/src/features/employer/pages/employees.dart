import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/employer/employer.dart';

class Employees extends ConsumerWidget {
  const Employees({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmployeeHeader(),
          Gap(16),
          EmployeeTable(),
        ],
      ),
    );
  }
}
