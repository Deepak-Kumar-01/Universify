import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universify/services/firebase_auth_service.dart';
import 'package:universify/views/admin/newSession/newSession.dart';
import 'package:universify/views/admin/newUser/newUserRegistration.dart';
import 'package:universify/views/auth/login/view/loginMediumDevice.dart';
import 'package:universify/views/events/collegeEvents.dart';
import 'package:universify/views/handle_Excel.dart';
import 'package:universify/views/home/upcomingclasses/upcommigClassesController.dart';
import 'package:universify/widgets/grid_item.dart';
import '../../controllers/auth_controller.dart';
import '../../services/user_secure_storage.dart';
import 'Assignment/assignment.dart';
import 'CarouseSlider/carouselSlider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.white,
      alignment: Alignment.center,
      child: SingleChildScrollView(

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
//--------------------------------------
            CarouselSlider(),
//--------------Society and faculty------------------------
            Assignment(),
//----------------Upcoming classes--------------------------
            Container(
              height: 200,  // this height control its child widget height
              color: Colors.green,
              child: ResponsiveUpcomingClasses(),
            ),
          ],
        ),
      ),
    );
  }
}
