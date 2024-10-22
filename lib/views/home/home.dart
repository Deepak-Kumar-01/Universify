import 'package:flutter/material.dart';
import 'package:universify/services/firebase_auth_service.dart';

import '../../services/user_secure_storage.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        final AuthServices _authServices=AuthServices();
        _authServices.signOut();
        await UserSecureStorage.setUserUID("null");
      },child: Icon(Icons.exit_to_app_outlined),),
    );
  }
}
