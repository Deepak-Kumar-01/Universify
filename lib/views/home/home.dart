import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universify/services/firebase_auth_service.dart';
import 'package:universify/views/admin/newSession/newSession.dart';
import 'package:universify/views/admin/newUser/newUserRegistration.dart';
import 'package:universify/views/auth/login/view/loginMediumDevice.dart';
import 'package:universify/views/events/collegeEvents.dart';
import 'package:universify/views/handle_Excel.dart';
import 'package:universify/widgets/grid_item.dart';
import '../../controllers/auth_controller.dart';
import '../../services/user_secure_storage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController?>(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text("USER uid: ${authProvider?.user?.email}",style: TextStyle(fontSize: 20),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(crossAxisCount: 2,children: [
          GridItem(title: "New User",tileColor: Colors.pink,url:"assets/adminIcons/createAuth.png",navigateTo: NewUserRegistration(),),
          GridItem(title: "New Session ",tileColor: Colors.orange,url:"assets/images/Java.png",navigateTo: NewSession(),),
          GridItem(title: "New User",tileColor: Colors.grey,url:"assets/adminIcons/createAuth.png",navigateTo: CollegeEvents(),),
          GridItem(title: "Handle Excel",tileColor: Colors.grey,url:"assets/adminIcons/createAuth.png",navigateTo: HandleExcel(),),



        ],),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        final AuthServices _authServices=AuthServices();
        _authServices.signOut();
        await UserSecureStorage.setUserUID("null");
      },child: Icon(Icons.exit_to_app_outlined),),
    );
  }
}
