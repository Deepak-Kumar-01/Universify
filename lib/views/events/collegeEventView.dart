import 'package:flutter/material.dart';

import '../../services/event_database_services.dart';
import 'collegeEventCard.dart';
class CollegeEventView extends StatefulWidget {
  const CollegeEventView({super.key});

  @override
  State<CollegeEventView> createState() => _CollegeEventViewState();
}

class _CollegeEventViewState extends State<CollegeEventView> {
  final EventDatabaseServices eventDatabaseServices=EventDatabaseServices("mca_event");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing Event"),
      ),
      body: StreamBuilder(stream: eventDatabaseServices.getEvents(), builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No events available"));
        }
        final events=snapshot.data!;
        // return Expanded(
        //   child: ListView.builder(
        //     itemCount: events.length,
        //     itemBuilder: (context,index){
        //       final event= events[index];
        //       return ListTile(
        //         title: Text(event.title),
        //         trailing: Checkbox(
        //           value: event.isDone,
        //           onChanged: (bool? value) {  },
        //         ),
        //       );
        //     },
        //   ),
        // );
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return CollegeEventCard(
              title: event.title,
              department: event.department,
              dateTime: event.dateTime,
              contactDetails: event.contactDetails,
              venue: event.venue,
              description: event.description,
              techTag:event.techTag,
              backgroundColor: Colors.blueGrey[900]!, // Custom background color
              textColor: Colors.white,                // Custom text color
              imageUrl: event.imageUrl,
            );
          },
        );
      }),
    );
  }
}
