import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/routing/routes.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authenticationProvider);
    final gradient =
        kIsWeb || Platform.isWindows ? webGradient : mobileGradient;

    return SafeArea(
      child: MaterialApp(
        title: 'Payroll Management System',
        theme: ApplicationTheme().lightTheme,
        themeMode: ApplicationTheme().themeMode,
        darkTheme: ApplicationTheme().darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        routes: authProvider.when(
          data: (data) {
            final userRole = data.user?.role;
            final routes = Routes(signedIn: data.isSignedIn);
            return routes.getRoutes(type: userRole);
          },
          error: (error, stackTrace) {
            return {
              Routes.home: (context) =>
                  ErrorWidgetComponent(error: error, stackTrace: stackTrace),
            };
          },
          loading: () {
            return {
              Routes.home: (context) => const LoadingWidget(),
            };
          },
        ),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(gradient: gradient),
            child: child!,
          );
        },
      ),
    );
  }
}
