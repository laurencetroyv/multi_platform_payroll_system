import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class CashAdvanceDialog extends ConsumerWidget {
  const CashAdvanceDialog(this.cashAdvance, {super.key});
  final CashAdvanceEntity cashAdvance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employee = ref
        .watch(employeeControllerProvider)
        .where((e) => e.id == cashAdvance.employeeId)
        .first;

    final job = ref
        .watch(jobControllerProvider)
        .where((j) => j.id == employee.jobId)
        .first
        .title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Employee Details'),
        ),
        const Gap(2),
        const Divider(),
        const Gap(6),
        ListTile(
          title: const Text('Employee Name:'),
          subtitle: Text('${employee.firstName} ${employee.lastName}'),
        ),
        const Gap(4),
        ListTile(
          title: const Text('Employee ID:'),
          subtitle: Text(employee.id),
        ),
        const Gap(4),
        ListTile(
          title: const Text('Job Title:'),
          subtitle: Text(job),
        ),
        const Gap(4),
        ListTile(
          title: const Text('Phone Number:'),
          subtitle: Text(job),
        ),
        const Gap(4),
        ListTile(
          title: const Text('Email Address:'),
          subtitle: Text(job),
        ),
        const Gap(16),
        const ListTile(
          title: Text('Cash Advance Detail'),
        ),
        const Gap(2),
        const Divider(),
        const Gap(6),
        ListTile(
          title: const Text('Amount Request:'),
          subtitle: Text('₱${cashAdvance.amount}'),
        ),
        const Gap(4),
        ListTile(
          title: const Text('Repayment Schedule:'),
          subtitle: Text(DateFormat.yMMMd().format(cashAdvance.repaymentDate)),
        ),
      ],
    );
  }
}
