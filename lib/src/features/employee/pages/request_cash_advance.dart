import 'package:flutter/material.dart';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/features/employee/provider/employee_provider.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class RequestCashAdvance extends ConsumerStatefulWidget {
  const RequestCashAdvance({super.key});

  @override
  ConsumerState<RequestCashAdvance> createState() => _RequestCashAdvanceState();
}

class _RequestCashAdvanceState extends ConsumerState<RequestCashAdvance> {
  final nameController = TextEditingController();
  final employeeIDController = TextEditingController();
  final positionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailAddressController = TextEditingController();
  final amountRequestedController = TextEditingController();
  final repaymentScheduleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = ref.read(authenticationProvider).value!.user!;
    final job = ref.read(jobControllerProvider).first;
    nameController.text = user.name;
    employeeIDController.text = user.employeeId!;
    positionController.text = job.title;
    emailAddressController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svgs/logo.svg'),
              const Gap(8),
              const Text(
                "Payroll Pro",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(32),
          const Text("Employee Details"),
          const Divider(color: Color(0xFFD5D5D5)),
          const Gap(28),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Employee Name",
              border: OutlineInputBorder(),
              enabled: false,
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: employeeIDController,
            decoration: const InputDecoration(
              labelText: "Employee ID",
              border: OutlineInputBorder(),
              enabled: false,
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: positionController,
            decoration: const InputDecoration(
              labelText: "Position",
              border: OutlineInputBorder(),
              enabled: false,
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: phoneNumberController,
            maxLength: 11,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: emailAddressController,
            decoration: const InputDecoration(
              labelText: "Position",
              border: OutlineInputBorder(),
              enabled: false,
            ),
          ),
          const Gap(32),
          const Text("Employee Details"),
          const Divider(color: Color(0xFFD5D5D5)),
          const Gap(28),
          TextFormField(
            controller: amountRequestedController,
            keyboardType: TextInputType.number,
            maxLength: 7,
            decoration: const InputDecoration(
              labelText: "Amount Requested",
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: repaymentScheduleController,
            decoration: const InputDecoration(
              labelText: "Repayment Schedule",
              border: OutlineInputBorder(),
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).then((value) {
                final date = DateFormat('yyyy-MM-dd').format(value!);
                repaymentScheduleController.text = date;
              });
            },
          ),
          const Gap(64),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final employee = ref.read(employeeProvider);

                    final cashAdvance = CashAdvanceEntity(
                      id: ID.unique(),
                      employeeId: employee.id,
                      amount: amountRequestedController.text,
                      repaymentDate:
                          DateTime.parse(repaymentScheduleController.text),
                      createdAt: DateTime.now(),
                      employerId: employee.employerId,
                      contactNumber: phoneNumberController.text,
                    );

                    await ref
                        .read(cashAdvanceControllerProvider.notifier)
                        .postCashAdvanceEmployee(cashAdvance);

                    WidgetsFlutterBinding.ensureInitialized()
                        .addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cash Advance Request Submitted"),
                        ),
                      );

                      nameController.clear();
                      employeeIDController.clear();
                      positionController.clear();
                      phoneNumberController.clear();
                      emailAddressController.clear();
                      amountRequestedController.clear();
                      repaymentScheduleController.clear();
                    });
                  },
                  child: const Text("Submit"),
                ),
              ),
              const Gap(16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    nameController.clear();
                    employeeIDController.clear();
                    positionController.clear();
                    phoneNumberController.clear();
                    emailAddressController.clear();
                    amountRequestedController.clear();
                    repaymentScheduleController.clear();
                  },
                  child: const Text("Clear Form"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
