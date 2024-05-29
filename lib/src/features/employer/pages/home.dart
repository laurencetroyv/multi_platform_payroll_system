import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:payroll_system/src/features/employer/employer.dart';

class EmployerHome extends ConsumerWidget {
  const EmployerHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Gap(16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,
            children: [
              DashboardCard(
                amount: 10,
                title: 'Job Position',
                icon: 'assets/svgs/job_position.svg',
                color: Color(0xFF00b6b9),
                footer: Color(0xFF0095A5),
                // route: '/employer/employees',
              ),
              DashboardCard(
                amount: 5,
                title: 'Paid Employee${5 > 1 ? 's' : ''}',
                icon: 'assets/svgs/paid_employee.svg',
                color: Color(0xFF00A94E),
                footer: Color(0xFF009746),
                // route: '/employer/job_positions',
              ),
              DashboardCard(
                amount: 2,
                title: 'Cash Advanced',
                icon: 'assets/svgs/cash_advanced.svg',
                color: Color(0xFFFFBE00),
                footer: Color(0xFFE5AB01),
                // route: '/employer/pay_salary',
              ),
              DashboardCard(
                amount: 1,
                title: 'Total Employee${1 > 1 ? 's' : ''}',
                icon: 'assets/svgs/total_employees.svg',
                color: Color(0xFFF41C58),
                footer: Color(0xFFDD1730),
                // route: '/employer/check_cash_advance',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 350,
                  minHeight: 350,
                  maxWidth: 350,
                  maxHeight: 392,
                ),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You found the calendar, yeey! 🎉'),
                      ),
                    );
                  },
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(DateTime.now().year),
                    lastDay: DateTime(DateTime.now().year, 12, 30),
                    calendarStyle: const CalendarStyle(
                        defaultTextStyle: TextStyle(
                      color: Colors.black,
                    )),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
