
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  String name;
  String dob;
  String universityRoll;
  String admissionNo;
  String universityEmailId;
  String personalEmail;
  String currentSemester = "1";
  bool isVerified = false;
  String createdBy;
  String role = "student";
  Timestamp createdOn;
  AppUser(
      {required this.name,
        required this.dob,
        required this.universityRoll,
        required this.admissionNo,
        required this.universityEmailId,
        required this.personalEmail,
        required this.currentSemester,
        required this.isVerified,
        required this.createdBy,
        required this.role,
        required this.createdOn});
}