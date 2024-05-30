import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/employer/employer.dart';

import 'add_employee_form.dart';

class EmployeeHeader extends ConsumerWidget {
  const EmployeeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 28.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const EmployerTitle('Company Employees'),
          FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const SizedBox(
                      width: 346,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: AddEmployeeForm(),
                      ),
                    ),
                  );
                },
              );
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(const Color(0xFF5199EE)),
              textStyle: WidgetStateProperty.all(
                const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.add),
                Gap(8),
                Text('Add Employee'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
