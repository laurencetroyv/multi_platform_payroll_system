import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:payroll_system/src/features/employer/employer.dart';

class CheckCashAdvance extends ConsumerStatefulWidget {
  const CheckCashAdvance({super.key});

  @override
  ConsumerState<CheckCashAdvance> createState() => _CheckCashAdvanceState();
}

class _CheckCashAdvanceState extends ConsumerState<CheckCashAdvance> {
  @override
  Widget build(BuildContext context) {
    final cashAdvanced = ref.watch(cashAdvanceControllerProvider);
    final employees = ref.watch(employeeControllerProvider);
    final jobs = ref.watch(jobControllerProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const EmployerTitle("Cash Advanced"),
          const Gap(16),
          ListView(
            shrinkWrap: true,
            children: cashAdvanced.map((ca) {
              final employee = employees.where((e) => e.id == ca.id).first;
              final job = jobs.where((j) => j.id == employee.jobId).first;
              final name = '${employee.firstName} ${employee.lastName}';

              return ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: CircleAvatar(
                  child: Text(
                    '${employee.firstName[0].toUpperCase()}${employee.lastName[0].toUpperCase()}',
                  ),
                ),
                title: Text(name),
                subtitle: Text(
                  '${job.title}, ₱${ca.amount}, ${DateFormat.yMMMd().format(ca.createdAt)}',
                ),
                trailing: FilledButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return CashAdvanceDialog(ca);
                      },
                    );
                    setState(() {});
                  },
                  child: const Text(
                    'View Details',
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
