import 'package:flutter/material.dart';
import 'package:universify/services/event_database_services.dart';
import 'package:universify/views/events/collegeEventView.dart';
import 'package:universify/views/events/CollegeEventForm.dart';

import 'collegeEventCard.dart';

class CollegeEvents extends StatefulWidget {
  const CollegeEvents({super.key});

  @override
  State<CollegeEvents> createState() => _CollegeEventsState();
}

class _CollegeEventsState extends State<CollegeEvents> {
  final EventDatabaseServices eventDatabaseServices=EventDatabaseServices("mca_event");
  final TextEditingController controller1=TextEditingController();
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index){
          setState(() {
            _currentIndex=index;
          });
        },
        indicatorColor: Colors.blue[200],
        backgroundColor: Colors.white,
        destinations: [
          NavigationDestination(icon: Icon(Icons.event), label: "Create Event"),
          NavigationDestination(icon: Icon(Icons.view_agenda_outlined), label: "Preview"),
        ],
      ),
      body: [CollegeEventForm(),const CollegeEventView()][_currentIndex],
    );
  }
}
