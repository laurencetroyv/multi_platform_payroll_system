import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class AddJobForm extends ConsumerStatefulWidget {
  const AddJobForm({super.key, this.job});
  final JobEntity? job;

  @override
  ConsumerState<AddJobForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends ConsumerState<AddJobForm> {
  String? _id;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _id = widget.job?.id;
    _nameController.text = widget.job?.title ?? '';
    _salaryController.text = widget.job?.monthlySalary.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
              labelText: 'Job Title',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: _salaryController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Monthly Salary',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          const Gap(16),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final key = UniqueKey().toString();
                final job = JobEntity(
                  id: _id ?? key.substring(2, key.length - 1).toUpperCase(),
                  title: _nameController.text,
                  monthlySalary: double.parse(_salaryController.text),
                  isActive: true,
                );
                if (_id == null) {
                  ref.read(jobControllerProvider.notifier).addJobPosition(job);
                } else {
                  ref
                      .read(jobControllerProvider.notifier)
                      .updateJobPosition(job);
                }
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
            child: Text(
              _id == null ? 'Add Job Position' : 'Update Job Position',
            ),
          ),
        ],
      ),
    );
  }
}
