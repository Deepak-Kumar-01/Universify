import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:universify/controllers/auth_controller.dart';
import 'package:universify/views/home/home.dart';
import '../services/user_secure_storage.dart';
import 'auth/login/controller/loginFormController.dart';
import 'onboarding/controller/onboardingController.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String? userUid;
  String _isOnboarded = "false";

  Future<void> initialization() async {
    print('ready in 3...');
    String? onBoardingStatus = await UserSecureStorage.getOnboarding();
    print('ready in 2...');
    setState(() {
      _isOnboarded = onBoardingStatus ?? "false";
    });
    print('ready in 1...');
    userUid=await UserSecureStorage.getUserUID();
    print(userUid);
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController?>(context);
    print("Inside Wrapper:${authProvider?.user}");
    return Scaffold(
        body:Center(
          child: _isOnboarded != "false"
              ? (authProvider?.user?.uid == null
              ? const ResponsiveLogin()
              : const Home())
              : const ResponsiveOnboarding(),
        )
    );
  }
}
