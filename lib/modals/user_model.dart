import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String name;
  final String mobileNo;
  final String dob;
  final String universityRoll;
  final String admissionNo;
  final String universityEmailId;
  final String personalEmail;
  final int currentSemester;
  final bool isVerified;
  final String createdBy;
  final String role;
  final Timestamp createdOn;
  final Map<String, Routine>? routine;

  AppUser({
    required this.name,
    required this.mobileNo,
    required this.dob,
    required this.universityRoll,
    required this.admissionNo,
    required this.universityEmailId,
    required this.personalEmail,
    required this.currentSemester,
    required this.isVerified,
    required this.createdBy,
    required this.role,
    required this.createdOn,
    required this.routine,
  });

  // Factory method to create a Student object from a JSON map (for Firestore)
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      name: json['name'] as String,
      mobileNo: (json['mobileNo'] as num).toString(),
      dob: json['dob'] as String,
      universityRoll: (json['universityRoll'] as num).toString(),
      admissionNo: json['admissionNo'] as String,
      universityEmailId: json['universityEmailId'] as String,
      personalEmail: json['personalEmail'] as String,
      currentSemester: json['currentSemester'] as int,
      isVerified: json['isVerified'] as bool,
      createdBy: json['createdBy'] as String,
      role: json['role'] as String,
      createdOn: (json['createdOn'] as Timestamp),
      routine: (json['routine'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, Routine.fromJson(value)),
      ),
    );
  }

  // Method to convert a Student object to a JSON map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobileNo': mobileNo,
      'dob': dob,
      'universityRoll': universityRoll,
      'admissionNo': admissionNo,
      'universityEmailId': universityEmailId,
      'personalEmail': personalEmail,
      'currentSemester': currentSemester,
      'isVerified': isVerified,
      'createdBy': createdBy,
      'role': role,
      'createdOn': createdOn,
      'routine': routine?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class Routine {
  final int attended;
  final int total;
  final int absent;

  Routine({
    required this.attended,
    required this.total,
    required this.absent,
  });

  // Factory method to create a Routine object from a JSON map
  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      attended: json['attended'] as int,
      total: json['total'] as int,
      absent: json['absent'] as int,
    );
  }

  // Method to convert a Routine object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'attended': attended,
      'total': total,
      'absent': absent,
    };
  }
}
