import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:payroll_system/src/features/employee/provider/employee_index.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        children: [
          Row(
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
          const Gap(32),
          const DashboardCard(
            icon: 'assets/svgs/account.svg',
            title: "Employee Dashboard",
            index: 1,
            color: Color(0xFF2196F2),
          ),
          const Gap(24),
          const DashboardCard(
            icon: 'assets/svgs/check.svg',
            title: "You have been paid!",
            index: 2,
            color: Color(0xFF49B04A),
          ),
          const Gap(24),
          const DashboardCard(
            icon: 'assets/svgs/money.svg',
            title: "Request Cash Advance",
            index: 3,
            color: Color(0xFFEFA001),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends ConsumerWidget {
  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.index,
    required this.color,
  });

  final String icon;
  final String title;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(employeeIndexProvider.notifier).setIndex(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: 500,
        constraints: const BoxConstraints(
          minWidth: 250,
          maxWidth: 500,
          maxHeight: 191,
          minHeight: 191,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            const Gap(8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
