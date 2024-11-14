import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:universify/controllers/auth_controller.dart';
import 'package:universify/services/firebase_database_service.dart';

import '../modals/user_model.dart';
import '../services/user_secure_storage.dart';
class HandleExcel extends StatefulWidget {
  const HandleExcel({super.key});

  @override
  State<HandleExcel> createState() => _HandleExcelState();
}

class _HandleExcelState extends State<HandleExcel> {
  List<Map<String, dynamic>> setAuthForStudent = [];
  Map<String, dynamic> rowMap = {};
  List<String> headers = [];
  String? createdByName;
  String? path=null;
  final AuthController _authController=AuthController();
  void extractUserAuthDetail() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );
    if (result != null) {
      setAuthForStudent.clear();
      File file = File(result.files.single.path!);
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet != null) {
          headers.clear();
          //Keys are extracted
          for (int i = 0; i < sheet.maxColumns; i++) {
            headers.add(sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
                .value
                .toString());
          }
          print("header: $headers");
          // header: [University Roll Number, Admission Number, Name, DOB, Mobile Number, Personal Email, University Email, Branch, Section, Year, Semester, Role]
          print(sheet.maxRows);
          //keys mapped to its value object file created
          for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++) {
            for (int colIndex = 0; colIndex < sheet.maxColumns; colIndex++) {
              var cellValue = sheet
                  .cell(CellIndex.indexByColumnRow(
                  columnIndex: colIndex, rowIndex: rowIndex))
                  .value;
              if (headers[colIndex] == "DOB") {
                String extractedDate = cellValue.toString();
                print(extractedDate);
                // DateTime parsedDate = DateTime.parse("2023-11-14")
                DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(extractedDate);
                print(parsedDate);
                String formattedDate = DateFormat('dd-MM-yyyy')
                    .format(parsedDate)
                    .replaceAll("-", "");
                rowMap[headers[colIndex]] = formattedDate;
              } else {
                rowMap[headers[colIndex]] = cellValue;
              }
            }
          }
            print("ROW MAP== $rowMap");
            setAuthForStudent.add(rowMap);
            //Creating auth(email,pass) for new user
            // await _authController.newAuthForUser( rowMap['University Email'].toString(), rowMap['DOB'].toString());
            // print("USER: ${FirebaseAuth.instance.currentUser?.uid} ");
            // String uid = "${FirebaseAuth.instance.currentUser?.uid}";
            // final adminUID = await UserSecureStorage.getUserUID();
            AppUser appUser = AppUser(
                name: rowMap['Name'].toString(),
                mobileNo: rowMap['Mobile Number'].toString(),
                universityRoll: rowMap['University Roll Number'].toString(),
                universityEmailId: rowMap['University Email'].toString(),
                admissionNo: rowMap['Admission Number'].toString(),
                personalEmail: rowMap['Personal Email'].toString(),
                dob: rowMap['DOB'],
                // currentSemester: rowMap['Semester'],
                currentSemester: 1,
                isVerified: false,
                createdBy: "admin",
                role: rowMap['Role'].toString(),
                createdOn: Timestamp.now(), routine: null);
                // routine: {'AI':Routine(absent: 0,attended: 0,total: 0)}
                //Add user after creating auth
            path="degrees/${rowMap['Branch'].toString()}/Sem-${rowMap['Semester'].toString()}/Sec-${rowMap['Section'].toString()}/users";
            DatabaseServices _databaseRef=DatabaseServices(path!);
            await _databaseRef.addUser(appUser);
            print("APP USER DATA:-----------------${appUser.toJson()}");
          //   // print(rowMap['dob']);
          // }
          // print(setAuthForStudent);
          //List of Student objects
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Handle Excel File"),
      ),
      body:Center(
        child: ElevatedButton(
          child: Text("Upload"),
          onPressed: (){
            extractUserAuthDetail();
          },
        ),
      ),
    );
  }
}

