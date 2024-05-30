import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/employer/employer.dart';

class EmployeeTable extends ConsumerWidget {
  const EmployeeTable({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeControllerProvider);
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
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Job Title')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Action')),
                ],
                rows: employees.map((employee) {
                  return DataRow(
                    cells: [
                      DataCell(Text(employee.firstName)),
                      DataCell(Text(employee.lastName)),
                      DataCell(Text(employee.address)),
                      DataCell(Text(employee.jobTitle)),
                      DataCell(Text(employee.status)),
                      DataCell(
                        FilledButton(
                          onPressed: () {
                            ref
                                .read(employeeControllerProvider.notifier)
                                .removeEmployee(employee);
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                                const Color(0xFFF15042)),
                            textStyle: WidgetStateProperty.all(
                                const TextStyle(color: Colors.white)),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.minimize_rounded),
                              Gap(4),
                              Text('Disable'),
                            ],
                          ),
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
