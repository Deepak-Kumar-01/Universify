import 'package:firebase_storage/firebase_storage.dart';
import 'package:universify/services/storage_download_upload_services.dart';
import 'dart:io';
class StorageController{

  StorageDownloadUploadServices _sdus=StorageDownloadUploadServices();
  //download template
  Future<String?> downloadTemplate(String filePath,String fileName)async{
    String? urlPath=await _sdus.downloadFromFirebase(filePath);
    // print("fetched Url: $urlPath");
    return urlPath;
  }

  //Upload new docs to firebaseStorage
    Future<bool> uploadDocument(String? branch,String? semester,String? section,String? fileName,File file)async{
      try{
        final storageRef= await FirebaseStorage.instance.ref();
        final docsRefs= await storageRef.child("$branch/$semester/$section/$fileName");
        await docsRefs.putFile(file);
        return true;
      }catch(e){
        print("Error While Uploading: $e");
        return false;
      }
    }
}