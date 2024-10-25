import 'package:cloud_firestore/cloud_firestore.dart';

import '../modals/event_model.dart';

class EventDatabaseServices {
  String? dept;
  late final CollectionReference eventCollectionReference;

  EventDatabaseServices(String department) {
    this.dept = department;
    eventCollectionReference = FirebaseFirestore.instance.collection(dept!);
  }

  //initiate stream
  Stream<List<EventModel>> getEvents() {
    return eventCollectionReference.snapshots().map((query) =>
        query.docs.map((doc) => EventModel.fromDocument(doc)).toList());
  }

  //Add new event
  Future<void> addEvent(
      String title,
      String department,
      DateTime dateTime,
      String contactDetails,
      String venue,
      String description,
      String techTag,
      String imageUrl,
      bool isDone) async {
    await eventCollectionReference.add({
      'title': title,
      'department': department,
      'dateTime': dateTime,
      'contactDetails': contactDetails,
      'venue': venue,
      'description': description,
      'techTag': techTag,
      'imageUrl':imageUrl,
      'isDone':isDone
    });
  }

  //Delete Event
  Future<void> deleteEvent(String id) async {
    await eventCollectionReference.doc(id).delete();
  }
}
