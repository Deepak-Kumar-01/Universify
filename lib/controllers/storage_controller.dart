import 'package:universify/services/storage_download_upload_services.dart';

class StorageController{
  StorageDownloadUploadServices _sdus=StorageDownloadUploadServices();
  //download template
  Future<String?> downloadTemplate(String filePath,String fileName)async{
    String? urlPath=await _sdus.downloadFromFirebase(filePath);
    // print("fetched Url: $urlPath");
    return urlPath;
  }
}