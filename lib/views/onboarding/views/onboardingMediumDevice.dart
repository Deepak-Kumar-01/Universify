import 'package:flutter/material.dart';
import '../widgets/customPageWidget/customPageWidget.dart';
import '../widgets/nextButton/mediumDeviceNextButton.dart';
import '../widgets/onboardingButtons/onboardingSkipButton.dart';
import '../widgets/pageIndicator/mediumDevicePageIndicator.dart';

class OnboardingMediumDevice extends StatefulWidget {
  const OnboardingMediumDevice({super.key});
  @override
  State<OnboardingMediumDevice> createState() => _OnboardingMediumDeviceState();
}

class _OnboardingMediumDeviceState extends State<OnboardingMediumDevice> {
  int currentValue = 0;
  void onPageChange(int index) {
    setState(() {
      currentValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Current Value:$currentValue");
    final size = MediaQuery.of(context).size;
    print("width${size.width}");
    final pageController = PageController(
      initialPage: 0,
    );
    // print("Re-build");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        //Horizontal PageView
        PageView(
          controller: pageController,
          onPageChanged: onPageChange,
          children: [
            CustomPageWidget(
              size: size,
              image: "assets/onboarding_gifs/study.gif",
              title: "Campus Connect",
              subTitle:
              "Building Bridges Between Students, Faculty, and Resources for Enhanced Learning and Achievement",
              // "Empowering Your Academic Journey",
            ),
            CustomPageWidget(
              size: size,
              image: "assets/onboarding_gifs/peace.gif",
              title: "AttendEase & EventSync",
              subTitle:
              "Track Attendance and Keep Tabs on Upcoming Events with Ease",
            ),
            CustomPageWidget(
                size: size,
                image: "assets/onboarding_gifs/welcome.gif",
                title: "Learning Synergy",
                subTitle:"Navigating Your Academic Journey with Ease and Confidence"
            ),
          ],
        ),
        //Skip Button
        currentValue==2?Text(""):OnboardingSkipButton(
            size: size, lastIndex: 3, controller: pageController),
        //Page Indicator
        currentValue < 3
            ? MediumPageIndicator(size: size, currentValue: currentValue)
            : Text(""),
        //Button
        // --------------------------------
        currentValue < 3
            ? MediumNextButton(
          size: size,
          controller: pageController,
          currentIndex: currentValue +1,
        )
            : Text("something went wrong"),
      //   -----------------------------------------
      ]),
    );
  }
}



