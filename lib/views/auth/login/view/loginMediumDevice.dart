import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universify/controllers/auth_controller.dart';
import '../../../../services/user_secure_storage.dart';
import '../../../wrapper.dart';

class LoginMediumDevice extends StatefulWidget {
  const LoginMediumDevice({super.key});

  @override
  State<LoginMediumDevice> createState() => _LoginMediumDeviceState();
}

class _LoginMediumDeviceState extends State<LoginMediumDevice> {
  //Controller for UserEmail and Pass
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  //Accessing UserData From Provider
  AuthController _authController=AuthController();
  //show password
  bool showPass=false;
  //remember me checkbox
  bool isRemember=true;
  //On Success Login Navigate
  Future<void> _loginAndNavigate() async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing the dialog
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.blue[900],
          ),
        );
      },
    );
    User? user;

    try {
      user = await _authController.signIn(_controller1.text, _controller2.text);
      print("Login Success inside LoginMedium:$user");
    } catch (e) {
      print("Error:$e");
    }
    //Close the dialog
    if (mounted) {
      Navigator.of(context).pop();
    }
    if (user != null) {
      try {
        await UserSecureStorage.setUserUID(
            "${user.uid}");
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Wrapper()),
                (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        }
      }
    }
    else{
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User does not exist"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 160, 20, 20),
          child: Column(
            children: [
              //Logo and Welcome Message
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage("assets/logo/logo_1x.png"),
                        width: size.width * 0.25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "JSSATEN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue[900]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.9,
                    child: Text(
                      "Welcome to JSSATEN, your home for discovery, innovation, and lifelong friendships.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                        controller: _controller1,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                          label: Text("University Email"),
                          hintText: "",
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                        controller: _controller2,
                        obscureText: !showPass,
                        decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.password_sharp),
                          suffixIcon: InkWell(
                            onTap: (){
                              setState(() {
                                showPass= !showPass;
                              });
                            },
                              child: showPass?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                          border: OutlineInputBorder(),
                          label: Text("Password"),
                          hintText: "",
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //Checkbox and Forgot Password
                  SizedBox(
                      width: size.width * 0.6,
                      child: ElevatedButton(
                          onPressed: _loginAndNavigate,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(12),
                              minimumSize: Size(size.width*0.6, 60)
                          ),
                          child: const Text(
                            "Log in",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          )
                      )),
                  //Buttons
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Remember Me Checkbox
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       value: isRemember,
                      //       onChanged: (val) {
                      //         setState(() {
                      //           isRemember= !isRemember;
                      //         });
                      //       },
                      //     ),
                      //     const Text("Remember Me")
                      //   ],
                      // ),
                      //Forget Password
                      // const Forgetpassword(),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
