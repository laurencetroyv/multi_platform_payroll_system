import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            title: const Text('Employee Information'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'employee-information');
            },
          ),
          ListTile(
            title: const Text('Payment Details'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'payment-details');
            },
          ),
          ListTile(
            title: const Text('Request Cash Advance'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'request-cash-advance');
            },
          ),
        ],
      ),
    );
  }
}
