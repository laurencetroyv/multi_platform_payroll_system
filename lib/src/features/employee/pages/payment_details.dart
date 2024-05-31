import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class PaymentDetails extends ConsumerWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            const ListTile(
              title: Text("Payment Date:"),
              subtitle: Text("John Doe"),
            ),
            const Gap(28),
            const ListTile(
              title: Text("Payment Amount:"),
              subtitle: Text("Employer"),
            ),
          ],
        ),
      ),
    );
  }
}
