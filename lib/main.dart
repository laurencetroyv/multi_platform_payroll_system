import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/app.dart';
import 'package:payroll_system/src/utils/dependency_injection.dart';

/// The main entry point of the application.
/// Initializes Firebase and runs the main app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection().initFirebase();

  runApp(
    const ProviderScope(child: MainApp()),
  );
}
