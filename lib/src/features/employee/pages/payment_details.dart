import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class PaymentDetails extends ConsumerWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userControllerProvider);
    final job = ref.read(jobControllerProvider).first;
    final salary = ref
        .read(paidControllerProvider)
        .where((element) => element.createdAt.month == DateTime.now().month)
        .length;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
            ListTile(
              title: const Text("Payment Date:"),
              subtitle: Text(user.name),
            ),
            const Gap(28),
            ListTile(
              title: const Text("Payment Amount:"),
              subtitle: Text("${job.monthlySalary}"),
            ),
            const Gap(28),
            ListTile(
              title: const Text("Payment Status"),
              subtitle: Text('${salary == 1 ? 'Paid' : 'Unpaid'} this month'),
            ),
          ],
        ),
      ),
    );
  }
}
