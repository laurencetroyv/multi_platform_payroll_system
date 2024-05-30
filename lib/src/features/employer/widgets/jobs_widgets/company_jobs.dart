import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/employer/employer.dart';
import 'package:payroll_system/src/features/employer/widgets/jobs_widgets/add_job_form.dart';

class CompanyJobTable extends ConsumerStatefulWidget {
  const CompanyJobTable({super.key});

  @override
  ConsumerState<CompanyJobTable> createState() => _CompanyJobTableState();
}

class _CompanyJobTableState extends ConsumerState<CompanyJobTable> {
  @override
  Widget build(BuildContext context) {
    final employees = ref.watch(employeeControllerProvider);
    final positions = ref.watch(jobControllerProvider);
    final jobPositions = positions.map((job) {
      final employee = employees
          .where((employee) => employee.jobTitle == job.title)
          .toList();
      return {
        'job': job,
        'title': job.title,
        'employee': employee.length,
        'salary': job.monthlySalary,
      };
    }).toList();

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
                  DataColumn(label: Text('Job Position')),
                  DataColumn(label: Text('People Hired')),
                  DataColumn(label: Text('Monthly Salary')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: jobPositions.map((position) {
                  final job = position['job'] as JobEntity;
                  final title = position['title'] as String;
                  final employee = position['employee'] as int;
                  final salary = position['salary'] as double;
                  return DataRow(
                    cells: [
                      DataCell(Text(title)),
                      DataCell(Text(employee.toString())),
                      DataCell(Text(salary.toString())),
                      DataCell(
                        FilledButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: SizedBox(
                                    width: 346,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: AddJobForm(job: job),
                                    ),
                                  ),
                                );
                              },
                            );
                            setState(() {});
                          },
                          child: const Text('Edit'),
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
