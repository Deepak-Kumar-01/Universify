// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../../flashMessage/customSnackBar.dart';
// import '../../../forgot password/forgotpassword.dart';
// import '../../../providers/authProvider.dart';
// import '../../../services/authentication.dart';
// import '../../../services/secureStorage.dart';
// import '../../../wrapper.dart';
//
// class LoginSmallDevice extends StatefulWidget {
//   const LoginSmallDevice({super.key});
//
//   @override
//   State<LoginSmallDevice> createState() => _LoginSmallDeviceState();
// }
//
// class _LoginSmallDeviceState extends State<LoginSmallDevice> {
//   final TextEditingController _controller1 = TextEditingController();
//   final TextEditingController _controller2 = TextEditingController();
//   final AuthServices _authRef = AuthServices();
//   final MyAuthProvider _authProvider=MyAuthProvider();
//   //show password
//   bool showPass=false;
//   //remember me checkbox
//   bool isRemember=true;
//
//   Future<void> _loginAndNavigate() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents dismissing the dialog
//       builder: (context) {
//         return Center(
//           child: CircularProgressIndicator(
//             backgroundColor: Colors.blue[900],
//           ),
//         );
//       },
//     );
//     User? user;
//     try {
//       user = await _authProvider.signIn(_controller1.text, _controller2.text);
//       print("Login Success inside LoginMedium:$user");
//     } catch (e) {
//       print("Error:$e");
//     }
//     // Close the dialog
//     if (mounted) {
//       Navigator.of(context).pop();
//     }
//     if(user!=null){
//       try{
//         await UserSecureStorage.setUserUID(
//             "${user.uid}");
//         if(mounted){
//           Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => Wrapper()),
//                 (Route<dynamic> route) => false,
//           );
//         }
//       }catch(e){
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: CustomSnackBar(errorMsg: e.toString()),
//               behavior: SnackBarBehavior.floating,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//             ),
//           );
//         }
//       }
//     }else{
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: CustomSnackBar(errorMsg: "User does not exist"),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller1.dispose();
//     _controller2.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
//           child: Column(
//             children: [
//               //Logo and Welcome Message
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image(
//                         image: const AssetImage("assets/logo/logo_1x.png"),
//                         width: size.width * 0.20,
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "JSSATEN",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.blue[900]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     width: size.width * 0.9,
//                     child: Text(
//                       "Welcome to JSSATEN, your home for discovery, innovation, and lifelong friendships.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey[800]),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Form(
//                   child: Column(
//                 children: [
//                   //Email
//                   SizedBox(
//                     width: 300,
//                     child: TextField(
//                         maxLines: 1,
//                         controller: _controller1,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Icons.email_outlined),
//                           border: OutlineInputBorder(
//                               // borderRadius: BorderRadius.circular(30)
//                               ),
//                           contentPadding: EdgeInsets.symmetric(vertical: 10),
//                           label: Text("University Email"),
//                           hintText: "",
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     width: 300,
//                     child:TextField(
//                         controller: _controller2,
//                         obscureText: !showPass,
//                         decoration:  InputDecoration(
//                           prefixIcon: Icon(Icons.password_sharp),
//                           suffixIcon: InkWell(
//                               onTap: (){
//                                 setState(() {
//                                   showPass= !showPass;
//                                 });
//                               },
//                               child: showPass?Icon(Icons.visibility):Icon(Icons.visibility_off)),
//                           border: OutlineInputBorder(),
//                           label: Text("Password"),
//                           hintText: "",
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   //Checkbox and Forgot Password
//                   //Remember
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: isRemember,
//                             onChanged: (val) {
//                               setState(() {
//                                 isRemember= !isRemember;
//                               });
//                             },
//                           ),
//                           Text("Remember Me")
//                         ],
//                       ),
//                       const Forgetpassword(),
//                     ],
//                   ),
//                   //Buttons
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         width: size.width * 0.4,
//                         child: ElevatedButton(
//                             onPressed: _loginAndNavigate,
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue[900],
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                                 padding: EdgeInsets.all(12),
//                                 minimumSize: Size(size.width*0.6, 50)
//                             ),
//                             child: const Text(
//                               "Log in",
//                               style: TextStyle(color: Colors.white, fontSize: 16),
//                             )
//                       )),
//                     ],
//                   )
//                 ],
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }