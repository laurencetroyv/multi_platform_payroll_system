import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/app.dart';

/// The entry point of the application.
///
/// This function initializes the Flutter binding and runs the main application.
/// It ensures that the Flutter framework is initialized before running the app.
/// The [ProviderScope] widget is used to provide dependency injection using the
/// Provider package. The [MainApp] widget is the root of the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MainApp()));
}
