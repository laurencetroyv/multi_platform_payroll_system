import 'package:flutter/material.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/features/employee/employee.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class Routes {
  bool _isSignedIn;
  static final Routes _route = Routes._internal(signedIn: false);

  factory Routes({required bool signedIn}) {
    _route._isSignedIn = signedIn;
    return _route;
  }

  Routes._internal({required bool signedIn}) : _isSignedIn = signedIn;

  static const home = '/';

  Map<String, WidgetBuilder> getRoutes({UserRoles? type}) {
    if (!_isSignedIn) {
      return {
        home: (context) => const WelcomeScreen(),
        'sign-in': (context) => const SignIn(),
        'sign-up': (context) => const SignUp(),
      };
    }

    switch (type!) {
      case UserRoles.employee:
        return {
          home: (context) => const Dashboard(),
          'employee-information': (context) => const EmployeeInformation(),
          'payment-details': (context) => const PaymentDetails(),
          'request-cash-advance': (context) => const RequestCashAdvance(),
        };
      case UserRoles.employer:
        return {
          home: (context) => const EmployerDashboard(),
          'employees': (context) => const EmployeeInformation(),
          'job-positions': (context) => const PaymentDetails(),
          'pay-salary': (context) => const PaySalary(),
          'check-cash-advance': (context) => const CheckCashAdvance()
        };
      case UserRoles.admin:
        return {
          home: (context) => const Scaffold(
                body: Center(
                  child: Text('Admin is not implemented yet.'),
                ),
              ),
        };
    }
  }
}
