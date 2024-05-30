import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class SalaryTable extends ConsumerStatefulWidget {
  const SalaryTable({
    super.key,
  });

  @override
  ConsumerState<SalaryTable> createState() => _SalaryTableState();
}

class _SalaryTableState extends ConsumerState<SalaryTable> {
  @override
  Widget build(BuildContext context) {
    final employees = ref.watch(employeeControllerProvider);
    final jobs = ref.watch(jobControllerProvider);
    final paidEmployees = ref.watch(paidControllerProvider);

    return Expanded(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              DataTable(
                dataTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                headingTextStyle:
                    Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black,
                        ),
                columns: const [
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Job Title')),
                  DataColumn(label: Text('Monthly Salary')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Action')),
                ],
                rows: employees.map((employee) {
                  final salary = jobs
                      .firstWhere((job) => job.title == employee.jobTitle)
                      .monthlySalary;
                  final now = DateTime.now();
                  final isPaid = paidEmployees
                      .where((paid) =>
                          paid.userId == employee.id &&
                          paid.createdAt.month == now.month)
                      .isNotEmpty;

                  return DataRow(
                    cells: [
                      DataCell(Text(employee.firstName)),
                      DataCell(Text(employee.lastName)),
                      DataCell(Text(employee.jobTitle)),
                      DataCell(Text(salary.toString())),
                      DataCell(Text(isPaid ? 'Paid' : 'Unpaid')),
                      DataCell(
                        FilledButton(
                          onPressed: () {
                            final paymentEntity = PaymentEntity(
                              id: employee.id,
                              status: true,
                              userId: employee.id,
                              createdAt: DateTime.now(),
                            );

                            ref
                                .read(paidControllerProvider.notifier)
                                .addPaidEmployee(paymentEntity);
                            setState(() {});
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          child: Text(isPaid ? 'Payed' : 'Pay'),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
