import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/employer/employer.dart';

class PaySalary extends ConsumerWidget {
  const PaySalary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmployerTitle("Manage Employee Salary"),
          Gap(16),
          SalaryTable(),
        ],
      ),
    );
  }
}
