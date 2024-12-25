import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:universify/services/user_secure_storage.dart';

class StorageDownloadUploadServices {
  //Download file from firebase storage
  Future<String?> downloadFromFirebase(String firebasePath) async {
    try {
      //Get Url of the file
      String url =
          await FirebaseStorage.instance.ref(firebasePath).getDownloadURL();
      return url;
    } catch (e) {
      throw Exception("Failed to generate download Url");
    }
  }

  //getMca notes
  Future<List<Reference>?> getPyqAndNotes(
      String branch, String sem, String docType) async {
    String path = "${branch.toLowerCase()}/semester/${sem.toLowerCase()}/${docType.toLowerCase()}";
    try {
      final userId = await UserSecureStorage.getUserUID();
      print("1 $userId");
      final storageRef = await FirebaseStorage.instance.ref();
      print("2 $storageRef");
      final docsRefs = await storageRef.child(path);
      print("3 $docsRefs");
      final docs = await docsRefs.listAll();
      print("Documents: ${docs.items.length} items found");
      if (docs.items.isEmpty) {
        print("No files found at the specified path.");
      } else {
        for (var item in docs.items) {
          print("Found file: ${item.name}");
        }
        return docs.items;
      }
    } catch (e) {
      print("Error whiling fetching MCA Notes: $e");
    }
    return null;
  }
}
