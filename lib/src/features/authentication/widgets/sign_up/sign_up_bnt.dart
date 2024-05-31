import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class SignUpBtn extends ConsumerWidget {
  const SignUpBtn(
    this.name, {
    super.key,
    required SignUpFormEntity form,
    required this.ids,
    required this.employer,
  }) : _form = form;

  final SignUpFormEntity _form;
  final String name;
  final List<EmployeeIds> ids;
  final bool employer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authenticationProvider);

    return authProvider.isLoading
        ? const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircularProgressIndicator(),
            ],
          )
        : FilledButton(
            onPressed: () async {
              late final EmployeeEntity? employeeResponse;
              if (!employer) {
                final index =
                    ids.indexWhere((element) => element.id == _form.id);
                if (index == -1) {
                  WidgetsFlutterBinding.ensureInitialized()
                      .addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid Employee ID'),
                      ),
                    );
                  });
                  return;
                }

                final employee = ids[index];

                employeeResponse = await ref
                    .read(employeeControllerProvider.notifier)
                    .getEmployee(employee.reference);
              } else {
                employeeResponse = null;
              }

              try {
                final response = await ref
                    .read(authenticationProvider.notifier)
                    .signUp(_form, name: employeeResponse?.firstName);
                if (response) {
                  WidgetsFlutterBinding.ensureInitialized()
                      .addPostFrameCallback((_) {
                    Navigator.pop(context);
                  });
                }
              } catch (e) {
                WidgetsFlutterBinding.ensureInitialized()
                    .addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                });
              }
            },
            child: Text(name),
          );
  }
}
