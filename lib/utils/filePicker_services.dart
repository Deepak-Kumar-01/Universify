import 'package:file_picker/file_picker.dart';

class FilePickerServices{
  //Function to pick file from device
  Future<FilePickerResult?> pickFile()async{
    FilePickerResult? result= await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    return result;
  }
}