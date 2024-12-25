import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:universify/modals/faculty_list_modal.dart';
import 'package:universify/services/user_secure_storage.dart';

import '../modals/user.dart';
import '../modals/user_model.dart';

class DatabaseServices {
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
  Future<void> addUser(AppUser appUser, String uid) async {
    // var uid=await FirebaseAuth.instance.currentUser?.uid;
    _userDocRef = _usersRef.doc(uid).withConverter<AppUser>(
      fromFirestore: (snapshots, _) => AppUser.fromJson(snapshots.data()!),
      toFirestore: (appUser, _) => appUser.toJson(),
    );
    await _userDocRef.set(appUser);
  }

  //Firebase Logic for uploading Timetable
  Future<void> createDegreeTimetable(String branch, String year, String section,
      Map<String, dynamic> timetableData) async {
    // print("TimeTable: ${timetableData}");
    CollectionReference degrees = _firestore.collection('degrees');
    for (String dayId
    in timetableData["${year}-Year"][section]['timetable'].keys) {
      await degrees
          .doc(branch.toLowerCase())
          .collection("${year.toLowerCase()}-year")
          .doc(section.toLowerCase())
          .collection('timetable')
          .doc(dayId)
          .set({
        'day': timetableData["${year}-Year"][section]['timetable'][dayId]
        ['day'],
        'slots': timetableData["${year}-Year"][section]['timetable'][dayId]
        ['slots'],
      });
    }
  }

  //Uploading Faculty List
  Future<void> createFacultyList(String branch, String year, String section,
      Map<String, dynamic> facultyListData) async {
    print(facultyListData);
    CollectionReference degrees = _firestore.collection('degrees');
    final List<FacultyListModel> list = facultyListData.entries
        .map((entry) => FacultyListModel.fromMap(entry.key, entry.value))
        .toList();
    for(var faculty in list) {
        await degrees
            .doc(branch.toLowerCase())
            .collection("${year.toLowerCase()}-year")
            .doc(section.toLowerCase())
            .collection('faculty')
            .doc(faculty.code)
            .set({
          "name":faculty.name.toString(),
          "faculty":faculty.faculty.toString()
        });
    }
    //   print(faculty);
    }
  }


