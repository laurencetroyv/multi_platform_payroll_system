import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarContainer extends StatelessWidget {
  const CalendarContainer({
    super.key,
  });

  static final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          child: TableCalendar(
            focusedDay: now,
            firstDay: DateTime(now.year),
            lastDay: DateTime(now.year, 12, 30),
            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(
                color: Colors.black,
              ),
            ),
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
            onDaySelected: (selectedDay, focusedDay) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'You have found: ${selectedDay.day}🎊',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
