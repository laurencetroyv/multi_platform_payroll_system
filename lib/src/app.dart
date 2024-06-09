import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/routing/routes.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Map<String, Widget Function(BuildContext)> route = {
    Routes.home: (context) => const LoadingWidget()
  };

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authenticationProvider);
    final gradient =
        kIsWeb || Platform.isWindows ? webGradient : mobileGradient;

    authProvider.when(
      data: (data) {
        final userRole = data.user?.role;
        final routes = Routes(signedIn: data.isSignedIn);
        setState(() {
          route = routes.getRoutes(type: userRole);
        });
      },
      error: (error, stackTrace) {
        final routes = Routes(signedIn: false);
        setState(() {
          route = routes.getRoutes();
        });
      },
      loading: () {
        final routes = Routes(signedIn: false);
        setState(() {
          route = routes.getRoutes();
        });
      },
    );

    return SafeArea(
      child: MaterialApp(
        title: 'Payroll Management System',
        theme: ApplicationTheme().lightTheme,
        themeMode: ApplicationTheme().themeMode,
        darkTheme: ApplicationTheme().darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        routes: route,
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
