export 'pages/pages.dart';
export 'providers/providers.dart';
export 'widgets/widgets.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/features/employer/pages/pages.dart';
import 'package:payroll_system/src/features/employer/providers/providers.dart';

class EmployerDashboard extends ConsumerStatefulWidget {
  const EmployerDashboard({super.key});

  @override
  ConsumerState<EmployerDashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<EmployerDashboard> {
  final List _pages = [
    const EmployerHome(),
    const Employees(),
    const JobPositions(),
    const PaySalary(),
    const CheckCashAdvance(),
  ];
  int index = 0;

  // final List _titles = [
  //   '',
  //   'Employees',
  //   'Job Positions',
  //   'Pay Salary',
  //   'Check Cash Advance',
  // ];

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authenticationProvider).asData?.value.user;
    return Scaffold(
      appBar: AppBar(
        // title: Text(_titles[index]),
        actions: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have found a secret feature! 🎉'),
                ),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.person),
                const Gap(8),
                Text(
                  user?.name.split(" ")[0] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(32),
              ],
            ),
          )
        ],
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
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/dashboard.svg'),
                  const Gap(8),
                  const Text('Dashboard'),
                ],
              ),
              onTap: () {
                ref.read(employerIndexProvider.notifier).setIndex(0);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/employee.svg'),
                  const Gap(8),
                  const Text('Employees'),
                ],
              ),
              onTap: () {
                ref.read(employerIndexProvider.notifier).setIndex(1);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/job_position.svg'),
                  const Gap(8),
                  const Text('Job Position'),
                ],
              ),
              onTap: () {
                ref.read(employerIndexProvider.notifier).setIndex(2);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/pay_salary.svg'),
                  const Gap(8),
                  const Text('Pay Salary'),
                ],
              ),
              onTap: () {
                ref.read(employerIndexProvider.notifier).setIndex(3);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/cash_advance.svg'),
                  const Gap(8),
                  const Text('Check Cash Advance'),
                ],
              ),
              onTap: () {
                ref.read(employerIndexProvider.notifier).setIndex(4);
              },
            ),
            ListTile(
              title: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  Gap(8),
                  Text('Log out'),
                ],
              ),
              onTap: () {
                ref.read(authenticationProvider.notifier).logout();
                WidgetsFlutterBinding.ensureInitialized()
                    .addPostFrameCallback((timeStamp) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                });
              },
            ),
          ],
        ),
      ),
      body: _pages[ref.watch(employerIndexProvider)],
    );
  }
}
