import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universify/modals/faculty_list_modal.dart';

import '../modals/timetable_model.dart';

class FacultyListServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to create a Firestore stream
  // Stream<List<FacultyListModel>> getFacultyListStream(String branch,
  //     String year, String section) {
  //   // Reference to Firestore collection (modify the path as per your structure)
  //   final collectionPath = '/degrees/mca/first-year/sec-a/faculty';
  //
  //   return FirebaseFirestore.instance
  //       .collection(collectionPath)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return FacultyListModel.fromMap(
  //           doc.id, doc.data() as Map<String, dynamic>);
  //     }).toList();
  //   });
  // }

//   // Fetch stream of subjects from Firestore
  Stream<List<FacultyListModel>> getFacultyListStream(
      String branch, String year, String section) {
    final collectionPath = '/degrees/mca/first-year/sec-a/faculty';

    return FirebaseFirestore.instance
        .collection(collectionPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return FacultyListModel.fromMap(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
