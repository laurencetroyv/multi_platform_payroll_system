import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/authentication/authentication.dart';

class SignInWebView extends ConsumerStatefulWidget {
  const SignInWebView({
    super.key,
    required SignInFormEntity form,
  }) : _form = form;

  final SignInFormEntity _form;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends ConsumerState<SignInWebView> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
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
                    "Sign In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                  const Gap(8),
                  Row(
                    children: [
                      Checkbox(
                        value: widget._form.saveSession,
                        onChanged: (val) {
                          setState(() {
                            widget._form.saveSession = val!;
                          });
                        },
                      ),
                      const Gap(8),
                      const Text("Remember me"),
                    ],
                  ),
                  const Gap(16),
                  Center(
                    child: SizedBox(
                      width: 215,
                      child: SignInBtn("Login", form: widget._form),
                    ),
                  ),
                  const Gap(12),
                  Center(
                    child: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('sign-up'),
                      child: const Text(
                        "Don't have an account? Sign up",
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
