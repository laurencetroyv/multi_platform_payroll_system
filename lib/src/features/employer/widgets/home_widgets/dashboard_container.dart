import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/features/employer/employer.dart';
import 'package:payroll_system/src/features/employer/providers/providers.dart';

import 'dashboard_card.dart';

class DashboardCardContainer extends ConsumerWidget {
  const DashboardCardContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobController = ref.watch(jobControllerProvider).length;
    final paidController = ref.watch(paidControllerProvider).length;
    final cashAdvanceController = ref.watch(cashAdvanceControllerProvider);
    final employeeController = ref.watch(employeeControllerProvider).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.min,
      children: [
        DashboardCard(
          amount: jobController,
          title: 'Job Position',
          icon: 'assets/svgs/job_position.svg',
          color: const Color(0xFF00b6b9),
          footer: const Color(0xFF0095A5),
          route: 2,
        ),
        DashboardCard(
          amount: paidController,
          title: 'Paid Employee${paidController > 1 ? 's' : ''}',
          icon: 'assets/svgs/paid_employee.svg',
          color: const Color(0xFF00A94E),
          footer: const Color(0xFF009746),
          route: 3,
        ),
        DashboardCard(
          amount: cashAdvanceController,
          title: 'Cash Advanced',
          icon: 'assets/svgs/cash_advanced.svg',
          color: const Color(0xFFFFBE00),
          footer: const Color(0xFFE5AB01),
          route: 4,
        ),
        DashboardCard(
          amount: employeeController,
          title: 'Total Employee${employeeController > 1 ? 's' : ''}',
          icon: 'assets/svgs/total_employees.svg',
          color: const Color(0xFFF41C58),
          footer: const Color(0xFFDD1730),
          route: 1,
        ),
      ],
    );
  }
}
