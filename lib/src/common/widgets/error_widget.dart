import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorWidgetComponent extends ConsumerWidget {
  const ErrorWidgetComponent(
      {super.key, required this.error, required this.stackTrace});
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('An error occurred: $error'),
      ),
    );
  }
}
