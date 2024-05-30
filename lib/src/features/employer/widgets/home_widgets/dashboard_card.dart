import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

class DashboardCard extends ConsumerWidget {
  const DashboardCard({
    super.key,
    required this.amount,
    required this.title,
    required this.icon,
    required this.color,
    required this.footer,
    required this.route,
  });

  final int amount;
  final String title;
  final String icon;
  final Color color;
  final Color footer;
  final int route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(employerIndexProvider.notifier).setIndex(route);
      },
      child: Container(
        color: color,
        width: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$amount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(icon, width: 50, height: 50)
                ],
              ),
            ),
            Container(
              color: footer,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'More Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(8),
                  Icon(Icons.info_rounded, color: Colors.white)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
