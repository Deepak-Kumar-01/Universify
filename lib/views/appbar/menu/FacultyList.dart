import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universify/controllers/faculty_list_controller.dart';
import 'package:universify/modals/faculty_list_modal.dart';

import '../../../controllers/timetable_controller.dart';
import '../../../modals/timetable_model.dart';
import '../../timetable/timetable.dart';
class FacultyList extends StatefulWidget {
  const FacultyList({super.key});

  @override
  State<FacultyList> createState() => _FacultyListState();
}

class _FacultyListState extends State<FacultyList> {
  // Generate a list of the next 5 days including the current date
  List<DateTime> nextDays = List.generate(7, (index) {
    return dateTime.add(Duration(days: index));
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty List",style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the back arrow color here
        ),
      ),
      body: StreamBuilder<List<FacultyListModel>>(
        stream: FacultyListServices().getFacultyListStream("mca", "first-year", "sec-a"),
        builder: (context, AsyncSnapshot<List<FacultyListModel>> snapshot) {
          if (snapshot.hasError) {
            // Display error if the stream has an issue
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the stream is being fetched
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final facultyList = snapshot.data;

          if (facultyList == null || facultyList.isEmpty) {
            // Show a message if no data is available
            return const Center(
              child: Text('No faculty data available.'),
            );
          }

          // Display the faculty list in a ListView
          return ListView.builder(
            itemCount: facultyList.length,
            itemBuilder: (context, index) {
              final faculty = facultyList[index];
              return ListTile(
                title: Text(faculty.faculty),
                subtitle: Text(faculty.name),
                trailing: Text(faculty.code),
              );
            },
          );
        },
      )
    );
  }
}
