import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modals/user.dart';
import '../modals/user_model.dart';
class DatabaseServices{
  String? path;
  final _firestore = FirebaseFirestore.instance;
  late DocumentReference<AppUser> _userDocRef;
  late final CollectionReference _usersRef;
  //Constructor initializing _userRef Collection Reference
  DatabaseServices(String path) {
    print(path);
    _usersRef = _firestore.collection(path).withConverter<AppUser>(
        fromFirestore: (snapshots, _) => AppUser.fromJson(snapshots.data()!),
        toFirestore: (appUser, _) => appUser.toJson());
    }
  //Adding User data after creating authentication
  Future<void> addUser(AppUser appUser)async{
    var uid=await FirebaseAuth.instance.currentUser?.uid;
    _userDocRef = _usersRef.doc(uid).withConverter<AppUser>(
      fromFirestore: (snapshots, _) => AppUser.fromJson(snapshots.data()!),
      toFirestore: (appUser, _) => appUser.toJson(),
    );
    await _userDocRef.set(appUser);
  }

  // //Firebase Logic for uploading Timetable
  // Future<void> createDegreeTimetable(
  //     String dept, String sem, Map<String, dynamic> timetableData) async {
  //   // print("TimeTable: ${timetableData}");
  //   CollectionReference degrees = firestore.collection('degrees');
  //
  //   for (String semesterId in timetableData['semesters'].keys) {
  //     // print("SemesterId: $semesterId");
  //     await degrees.doc(dept).collection('semesters').doc(semesterId).set({
  //       'name': timetableData['semesters'][semesterId]['name'],
  //     });
  //     for (String dayId
  //     in timetableData['semesters'][semesterId]['timetable'].keys) {
  //       await degrees
  //           .doc(dept)
  //           .collection('semesters')
  //           .doc(semesterId)
  //           .collection('timetable')
  //           .doc(dayId)
  //           .set({
  //         'day': timetableData['semesters'][semesterId]['timetable'][dayId]
  //         ['day'],
  //         'slots': timetableData['semesters'][semesterId]['timetable'][dayId]
  //         ['slots'],
  //       });
  //     }
  //   }
  // }
}