import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:universify/controllers/auth_controller.dart';
import 'package:universify/views/wrapper.dart';
import 'firebase_options.dart';

void main() async {
  //Bind Widget Properly
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //Native Splash Screen package
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //Initializes Firebase application with the default options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // //To cache data by firebase
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (_) => AuthController(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
