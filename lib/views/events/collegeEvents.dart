import 'package:flutter/material.dart';
import 'package:universify/services/event_database_services.dart';

import 'collegeEventCard.dart';

class CollegeEvents extends StatefulWidget {
  const CollegeEvents({super.key});

  @override
  State<CollegeEvents> createState() => _CollegeEventsState();
}

class _CollegeEventsState extends State<CollegeEvents> {
  final EventDatabaseServices eventDatabaseServices=EventDatabaseServices("mca_event");
  final TextEditingController controller1=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event list"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller1,
            decoration: InputDecoration(hintText: 'Add a new task'),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              if(controller1.text.isNotEmpty){
                eventDatabaseServices.addEvent(controller1.text);
                controller1.clear();
              }
            },
          ),
          StreamBuilder(stream: eventDatabaseServices.getEvents(), builder: (context,snapshot){
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
            return Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return CollegeEventCard(
                    title: "Flutter Workshop",
                    department: "Computer Science",
                    dateTime: DateTime(2024, 11, 12, 10, 30),
                    contactDetails: "+1234567890",
                    venue: "Auditorium, Block A",
                    description: "An introductory workshop on Flutter for mobile app development.",
                    techTag: "Flutter",
                    backgroundColor: Colors.blueGrey[900]!, // Custom background color
                    textColor: Colors.white,                // Custom text color
                    imageUrl: "assets/images/lazyPanda.jpg",
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
