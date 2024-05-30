import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/features/employer/employer.dart';

class EmployeeTable extends ConsumerStatefulWidget {
  const EmployeeTable({
    super.key,
  });

  @override
  ConsumerState<EmployeeTable> createState() => _EmployeeTableState();
}

class _EmployeeTableState extends ConsumerState<EmployeeTable> {
  @override
  Widget build(BuildContext context) {
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
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Job Title')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Action')),
                ],
                rows: employees.map((employee) {
                  final employeeDisable = employee.status == false;

                  return DataRow(
                    cells: [
                      DataCell(Text(employee.id)),
                      DataCell(Text(employee.firstName)),
                      DataCell(Text(employee.lastName)),
                      DataCell(Text(employee.address)),
                      DataCell(Text(employee.jobTitle)),
                      DataCell(Text(employee.status ? 'Active' : 'Inactive')),
                      DataCell(
                        FilledButton(
                          onPressed: () {
                            ref
                                .read(employeeControllerProvider.notifier)
                                .disableEmployee(employee);
                            setState(() {});
                          },
                          child: Text(!employeeDisable ? 'Disable' : 'Enable'),
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
