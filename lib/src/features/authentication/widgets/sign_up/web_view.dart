import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';

class SignUpWebView extends ConsumerStatefulWidget {
  const SignUpWebView(
    this.ids, {
    super.key,
    required SignUpFormEntity form,
  }) : _form = form;

  final SignUpFormEntity _form;
  final List<EmployeeIds> ids;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends ConsumerState<SignUpWebView> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = kIsWeb
        ? false
        : MediaQuery.of(context).size.width < 400 ||
            (Platform.isAndroid || Platform.isIOS);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 400,
          foregroundDecoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                'assets/images/illustration.png',
              ),
            ),
          ),
        ),
        Card(
          color: const Color(0xFFB5C0D0).withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 346,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: widget._form.nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                  ),
                  if (isMobile) const Gap(16),
                  if (isMobile)
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
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: !showPassword,
                  ),
                  const Gap(16),
                  Center(
                    child: SizedBox(
                      width: 215,
                      child: SignUpBtn(
                        "Register",
                        form: widget._form,
                        ids: widget.ids,
                        employer: true,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Already have an account? Sign up",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
