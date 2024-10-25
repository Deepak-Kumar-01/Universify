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
  Future<void> addEvent(String title)async{
    await eventCollectionReference.add({
      'title':title,
      'isDone':false,
      'createdOn':DateTime.timestamp()
    });
  }
  //Delete Event
  Future<void> deleteEvent(String id) async{
    await eventCollectionReference.doc(id).delete();
  }
}
