import 'package:cloud_firestore/cloud_firestore.dart';

import '../modals/timetable_model.dart';

class TimetableService{
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  Stream<TimetableModal> getTimeTableStream(String branch,String year,String section){
    try {
      return _db
          .collection('degrees')
          .doc(branch.toLowerCase())
          .collection(year.toLowerCase())
          .doc(section.toLowerCase())
          .collection('timetable')
          .snapshots()
          .map((snapshot) => _modalFromSnapshot(snapshot));
    } catch (e) {
      print('Error fetching timetable data: $e');
      throw e;
    }
  }
  TimetableModal _modalFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot){
    List<Day> timetable = [];

    snapshot.docs.forEach((doc) {
      // print("DAY:${doc.data()['day']}");
      var day = Day(
        day: doc.id, // Assuming document id is 'day_0', 'day_1', ..., 'day_5'
        dname: doc.data()['day'],
        slots: _slotsFromSnapshot(doc['slots']),
      );
      timetable.add(day);
    });

    // Assuming 'First Semester' is the name you want to assign
    var semester = Semester(name: 'First Semester', timetable: timetable);

    return TimetableModal(semesters: [semester]);
  }
  List<Slot> _slotsFromSnapshot(List<dynamic> slotsSnapshot) {
    List<Slot> slots = [];

    slotsSnapshot.forEach((slotJson) {

      var slot = Slot(
        faculty: slotJson['faculty']??'',
        subject: slotJson['subject'] ?? '', // Provide a default value if 'subject' is null
        subCode: slotJson['subCode']??'',
        time: slotJson['time'] ?? '', // Provide a default value if 'time' is null

      );
      slots.add(slot);
    });

    return slots;
  }
}