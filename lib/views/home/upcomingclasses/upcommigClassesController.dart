import 'package:flutter/material.dart';
import 'package:universify/views/home/upcomingclasses/upcomingclassesMediumDevice.dart';
import 'package:universify/views/home/upcomingclasses/upcomingclassesSmallDevice.dart';

import '../../../utils/constant.dart';

class ResponsiveUpcomingClasses extends StatelessWidget {
  const ResponsiveUpcomingClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > smallDeviceWidth) {
          print("Medium Screen");
          return UpcomingClassesMediumDevice();
        } else {
          print("Small Screen");
          return UpcomingClassesSmallDevice();
        }
      },
    );
  }
}
