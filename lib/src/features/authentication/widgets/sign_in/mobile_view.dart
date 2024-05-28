import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/authentication/authentication.dart';

class SignInMobileView extends ConsumerStatefulWidget {
  const SignInMobileView({
    super.key,
    required SignInFormEntity form,
  }) : _form = form;

  final SignInFormEntity _form;

  @override
  ConsumerState<SignInMobileView> createState() => _MobileViewState();
}

class _MobileViewState extends ConsumerState<SignInMobileView> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          const Gap(28),
          Image.asset('assets/images/illustration.png'),
          const Gap(64),
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
          SignInBtn("\t\tLogin\t\t", form: widget._form),
          const Gap(16),
          FilledButton(
            onPressed: () {
              Navigator.pushNamed(context, 'sign-up');
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}
