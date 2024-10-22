import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/grid_item.dart';
import '../newUser/newUserRegistration.dart';

class NewSession extends StatefulWidget {
  const NewSession({super.key});

  @override
  State<NewSession> createState() => _NewSessionState();
}

class _NewSessionState extends State<NewSession> {
  final TextEditingController _branchController = TextEditingController();
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
                      onTap: () {
                        // String url="https://drive.google.com/file/d/1a9ceHKgy5Eh_AYb8eNlZCNxsX8TsIgx-/view?usp=drive_link";
                        // _launchURL(url);
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
                      onTap: () {
                        // String url="https://drive.google.com/file/d/1a9ceHKgy5Eh_AYb8eNlZCNxsX8TsIgx-/view?usp=drive_link";
                        // _launchURL(url);
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.green[600],
                        child: Center(
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
                        width: size.width * 0.4,
                        child: TextField(
                            controller: _branchController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Branch"),
                              hintText: "",
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.4,
                        child: TextField(
                            controller: _branchController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Section"),
                              hintText: "",
                            )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * 0.4,
                    child: TextField(
                        controller: _branchController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Semester"),
                          hintText: " 1-8",
                        )),
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
                child: TextField(
                    controller: _branchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_file),
                      border: OutlineInputBorder(),
                      label: Text("Upload Student Details"),
                      hintText: "",
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.8,
                child: TextField(
                    controller: _branchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_file),
                      border: OutlineInputBorder(),
                      label: Text("Upload Student Details"),
                      hintText: "",
                    )),
              ),
            ),
            ElevatedButton(onPressed: (){}, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
