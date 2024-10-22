import 'package:flutter/material.dart';

import '../../../../utils/constant.dart';
import '../view/loginMediumDevice.dart';
import '../view/loginSmallDevice.dart';

class ResponsiveLogin extends StatelessWidget {
  const ResponsiveLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > smallDeviceWidth) {
          // return LoginMediumDevice();
          return LoginMediumDevice();
        } else {
          // return LoginSmallDevice();
          return Text("Login small");
        }
      },
    );
  }
}
