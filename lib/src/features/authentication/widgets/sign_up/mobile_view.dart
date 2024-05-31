import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';

class SignUpMobileView extends ConsumerStatefulWidget {
  const SignUpMobileView(
    this.ids, {
    super.key,
    required SignUpFormEntity form,
  }) : _form = form;

  final SignUpFormEntity _form;
  final List<EmployeeIds> ids;

  @override
  ConsumerState<SignUpMobileView> createState() => _MobileViewState();
}

class _MobileViewState extends ConsumerState<SignUpMobileView> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 400 ||
        (Platform.isAndroid || Platform.isIOS);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svgs/logo.svg'),
              const Text(
                "Payroll Pro",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(28),
          Image.asset('assets/images/illustration.png'),
          const Gap(64),
          if (!isMobile)
            TextFormField(
              controller: widget._form.nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
            ),
          const Gap(16),
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            controller: widget._form.employeeId,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Employee ID',
              hintText: 'Employee ID must came from HR Department',
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: widget._form.emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: widget._form.passwordController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter your password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            obscureText: !showPassword,
          ),
          const Gap(64),
          SignUpBtn(
            "\t\tSign up\t\t",
            form: widget._form,
            ids: widget.ids,
            employer: false,
          ),
          const Gap(16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Already have an Account"),
          ),
        ],
      ),
    );
  }
}
