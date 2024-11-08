import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:universify/controllers/storage_controller.dart';
import 'package:universify/utils/filePicker_services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewSession extends StatefulWidget {
  const NewSession({super.key});

  @override
  State<NewSession> createState() => _NewSessionState();
}

class _NewSessionState extends State<NewSession> {
  final TextEditingController _branchController = TextEditingController();
  String? selectedBranch=null;
  String? selectedSection=null;
  String? selectedSem=null;
  String? selectedStudentDocFile=null;
  String? selectedRoutineDocFile=null;
  List<String> branchList=["MCA","Btech_CSE","Btech_AI/ML","BPharma"];
  List<String> sectionList=["Sec-A (default)","Sec-B","Sec-C","Sec-D"];
  List<String> semList=["First","Second","Third","Fourth","Fifth","Sixth","Seventh","Eighth"];


  Future<void> _pickFile(String? param) async{
    FilePickerServices _pickServices=FilePickerServices();
    FilePickerResult? result=await _pickServices.pickFile() as FilePickerResult?;
    print("Picked File: ${result?.names.first}");
    setState(() {
      if(param==selectedStudentDocFile){
        selectedStudentDocFile=result?.names.first;
      }else if(param==selectedRoutineDocFile){
        selectedRoutineDocFile=result?.names.first;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Session"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Warning
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.yellow[100], // Light yellow background
                  border: Border.all(
                      color: Colors.orange, width: 2), // Orange border
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.warning, // Warning icon
                      color: Colors.orange,
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        "You need to download the default Excel format before you upload any attachment. Attachements are given below",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Download Items
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    child: InkWell(
                      onTap: () async{
                        final String? stotagePath=dotenv.env["STORAGE_PATH_Student_Details_Template"];
                        print("Download Routine record clicked");
                        StorageController _controller=StorageController();
                        String? url=await _controller.downloadTemplate(stotagePath!, "Student_Details_Template.xlsx");
                        if(await canLaunchUrlString(url!)){
                          await launchUrlString(url);
                        }else{
                          print("can't launch url");
                        }
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.orange,
                        child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Student Details",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 100,
                    child: InkWell(
                      onTap: () async{
                        final String? stotagePath=dotenv.env["STORAGE_PATH_Routine_Template"];
                        print("Download Routine record clicked");
                        StorageController _controller=StorageController();
                        String? url=await _controller.downloadTemplate(stotagePath!,"Routine_Template.xlsx");
                        if(await canLaunchUrlString(url!)){
                          await launchUrlString(url);
                        }else{
                          print("can't launch url");
                        }
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.green[600],
                        child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Time Table",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            //STEP 01
            SizedBox(
              height: 70,
              width: size.width,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Step 01",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                  tileColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton<String>(
                          value: selectedBranch,
                          hint: Text("Select Branch"), // Displays if selectedBranch is null
                          onChanged: (String? newVal) {
                            setState(() {
                              selectedBranch = newVal; // Updates the selected value
                              print("Selected Branch: $selectedBranch");
                            });
                          },
                          items: branchList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton<String>(
                          value: selectedSection,
                          hint: Text("(default if N.A)"), // Displays if selectedBranch is null
                          onChanged: (String? newVal) {
                            setState(() {
                              selectedSection = newVal; // Updates the selected value
                              print("Selected Section: $selectedSection");
                            });
                          },
                          items: sectionList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButton<String>(
                      value: selectedSem,
                      hint: Text("Select Semester"), // Displays if selectedBranch is null
                      onChanged: (String? newVal) {
                        setState(() {
                          selectedSem = newVal; // Updates the selected value
                          print("Selected Semester: $selectedSem");
                        });
                      },
                      items: semList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            //STEP 02
            SizedBox(
              height: 70,
              width: size.width,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Step 02",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                  tileColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.8,
                child: ListTile(
                  title: Text(
                    'Student Records: ${selectedStudentDocFile != null ? selectedStudentDocFile!.split('/').last : 'No File Selected'}',
                  ),
                  leading: Icon(Icons.attach_file),
                  onTap: (){
                    _pickFile(selectedStudentDocFile);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.8,
                child: ListTile(
                  title: Text(
                    'Routine Records: ${selectedRoutineDocFile != null ? selectedRoutineDocFile!.split('/').last : 'No File Selected'}',
                  ),
                  leading: Icon(Icons.attach_file),
                  onTap: (){
                    _pickFile(selectedRoutineDocFile);
                  },
                ),
              ),
            ),
            ElevatedButton(onPressed: (){}, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
