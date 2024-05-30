import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class AddEmployeeForm extends ConsumerStatefulWidget {
  const AddEmployeeForm({super.key});

  @override
  ConsumerState<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends ConsumerState<AddEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _jobPositionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final jobPositions = ref.watch(jobControllerProvider);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(16),
          const Text(
            'Add Employee',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          DropdownMenu(
            width: 314,
            controller: _jobPositionController,
            enableFilter: true,
            hintText: "Job Title",
            dropdownMenuEntries: jobPositions
                .map((job) => DropdownMenuEntry(label: job.title, value: job))
                .toList(),
          ),
          const Gap(16),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final index = jobPositions.indexWhere(
                  (job) => job.title == _jobPositionController.text,
                );
                if (index == -1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Job Position not found'),
                    ),
                  );
                  return;
                }

                final job = jobPositions[index];

                final key = UniqueKey().toString();
                final employee = EmployeeEntity(
                  id: key.substring(2, key.length - 1).toUpperCase(),
                  firstName: _nameController.text,
                  lastName: _nameController.text.split(' ').last,
                  address: _addressController.text,
                  jobId: job.id,
                  status: true,
                );
                ref
                    .read(employeeControllerProvider.notifier)
                    .addEmployee(employee);
                Navigator.of(context).pop();
              }
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
            child: const Text('Add Employee'),
          ),
        ],
      ),
    );
  }
}
