// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class EventModel {
//   String title;
//   bool isDone;
//   Timestamp createdOn;
//
//   EventModel({required this.title, required this.isDone, required this.createdOn});
//
//   // Convert Event to Map for Firestore
//   Map<String,dynamic> toMap(){
//     return{
//       'title':title,
//       'isDone':isDone,
//       'createdOn':createdOn
//     };
//   }
//
//   //Convert firebase Document to Event object
//   factory EventModel.fromDocument(DocumentSnapshot doc){
//     return EventModel(
//       title: doc['title'],
//       isDone: doc['isDone'],
//       createdOn: doc['createdOn']
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String title;
  final String department;
  final DateTime dateTime;
  final String contactDetails;
  final String venue;
  final String description;
  final String techTag;
  final String? imageUrl;
  final bool isDone;

  EventModel({
    required this.title,
    required this.department,
    required this.dateTime,
    required this.contactDetails,
    required this.venue,
    required this.description,
    required this.techTag,
    this.imageUrl,
    this.isDone = false,
  });

  // Factory constructor to create an instance of CollegeEvent from Firestore
  factory EventModel.fromDocument(DocumentSnapshot doc) {
    return EventModel(
      title: doc['title'] ?? '',
      department: doc['department'] ?? '',
      dateTime: (doc['dateTime'] as Timestamp).toDate(),
      contactDetails: doc['contactDetails'] ?? '',
      venue: doc['venue'] ?? '',
      description: doc['description'] ?? '',
      techTag: doc['techTag'] ?? '',
      imageUrl: doc['imageUrl'],
      isDone: doc['isDone'] ?? false,
    );
  }

  // Method to convert CollegeEvent to Map for saving in Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'department': department,
      'dateTime': dateTime,
      'contactDetails': contactDetails,
      'venue': venue,
      'description': description,
      'techTag': techTag,
      'imageUrl': imageUrl,
      'isDone': isDone,
    };
  }
}
