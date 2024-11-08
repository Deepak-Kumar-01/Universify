import 'package:firebase_storage/firebase_storage.dart';

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


}
