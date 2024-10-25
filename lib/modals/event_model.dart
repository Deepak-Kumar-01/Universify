import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String title;
  bool isDone;
  Timestamp createdOn;

  EventModel({required this.title, required this.isDone, required this.createdOn});

  // Convert Event to Map for Firestore
  Map<String,dynamic> toMap(){
    return{
      'title':title,
      'isDone':isDone,
      'createdOn':createdOn
    };
  }

  //Convert firebase Document to Event object
  factory EventModel.fromDocument(DocumentSnapshot doc){
    return EventModel(
      title: doc['title'],
      isDone: doc['isDone'],
      createdOn: doc['createdOn']
    );
  }
}
