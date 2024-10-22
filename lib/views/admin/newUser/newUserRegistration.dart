import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universify/controllers/auth_controller.dart';
import 'package:universify/services/firebase_auth_service.dart';
class NewUserRegistration extends StatefulWidget {
  const NewUserRegistration({super.key});

  @override
  State<NewUserRegistration> createState() => _NewUserRegistrationState();
}

class _NewUserRegistrationState extends State<NewUserRegistration> {
  final TextEditingController _controller1=TextEditingController();
  final TextEditingController _controller2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New User Registration"),
      ),
      body: Column(
        children: [
          TextField(
              controller: _controller1,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
                label: Text("University Email"),
                hintText: "",
              )),
          TextField(
              controller: _controller2,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
                label: Text("Pass"),
                hintText: "",
              )),
          SizedBox(

              child: ElevatedButton(
                  onPressed: ()async{
                    

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(12),
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )
              )),
        ],
      ),
    );
  }
}
