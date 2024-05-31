import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/authentication/providers/authentication_provider.dart';
import 'package:payroll_system/src/features/employee/pages/pages.dart';
import 'package:payroll_system/src/features/employee/provider/employee_index.dart';

export 'pages/pages.dart';
export 'widgets/widgets.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final List _pages = [
    const Home(),
    const EmployeeInformation(),
    const PaymentDetails(),
    const RequestCashAdvance()
  ];

  final List _titles = [
    'Home',
    'Employee Information',
    'Payment Details',
    'Request Cash Advance'
  ];

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(employeeIndexProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[index]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF992ad1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                ref.read(employeeIndexProvider.notifier).setIndex(0);
              },
            ),
            ListTile(
              title: const Text('Employee Information'),
              onTap: () {
                ref.read(employeeIndexProvider.notifier).setIndex(1);
              },
            ),
            ListTile(
              title: const Text('Payment Details'),
              onTap: () {
                ref.read(employeeIndexProvider.notifier).setIndex(2);
              },
            ),
            ListTile(
              title: const Text('Request Cash Advance'),
              onTap: () {
                ref.read(employeeIndexProvider.notifier).setIndex(3);
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () async {
                await ref.read(authenticationProvider.notifier).logout();
                WidgetsFlutterBinding.ensureInitialized()
                    .addPostFrameCallback((_) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                });
              },
            ),
          ],
        ),
      ),
      body: _pages[index],
    );
  }
}
