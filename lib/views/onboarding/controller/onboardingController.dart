import 'package:flutter/material.dart';
import '../../../utils/constant.dart';
import '../views/onboardingMediumDevice.dart';
import '../views/onboardingSmallDevice.dart';

class ResponsiveOnboarding extends StatelessWidget {
  const ResponsiveOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >smallDeviceWidth) {
          print("MaxWidth ${constraints.maxWidth}");
          return OnboardingMediumDevice();
        } else {
          return OnboardingSmallDevice() ;
        }
      },
    );
  }
}
