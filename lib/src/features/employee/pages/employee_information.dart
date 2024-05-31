import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

// import 'package:payroll_system/src/features/authentication/authentication.dart';

class EmployeeInformation extends ConsumerWidget {
  const EmployeeInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.read(authenticationProvider).value!.user!;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svgs/logo.svg'),
              const Gap(8),
              const Text(
                "Payroll Pro",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(32),
          // ListTile(
          //   title: const Text("Name"),
          //   subtitle: Text(user.name),
          // ),
          // ListTile(
          //   title: const Text("Job Title"),
          //   subtitle: Text(user.job ?? 'Employer'),
          // ),
          // ListTile(
          //   title: const Text("Monthly Salary"),
          //   subtitle: Text(user.monthlySalary ?? 'N/A'),
          // ),
          // ListTile(
          //   title: const Text("Payment Status"),
          //   subtitle: Text(user.isPaid == true ? 'Paid' : 'Unpaid'),
          // ),
        ],
      ),
    );
  }
}
