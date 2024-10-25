import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universify/services/event_database_services.dart';

class CollegeEventForm extends StatefulWidget {
  @override
  _CollegeEventFormState createState() => _CollegeEventFormState();
}

class _CollegeEventFormState extends State<CollegeEventForm> {
  final _formKey = GlobalKey<FormState>();
  final EventDatabaseServices eventDatabaseServices=EventDatabaseServices("mca_event");

  String? title;
  String? department;
  DateTime? dateTime;
  String? contactDetails;
  String? venue;
  String? description;
  String? techTag;
  String? imageUrl;

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          dateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageUrl = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create College Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => title = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Department'),
                onSaved: (value) => department = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter department' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Details'),
                onSaved: (value) => contactDetails = value,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter contact details'
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Venue'),
                onSaved: (value) => venue = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter venue' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter description' : null,
                maxLines: 3,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tech Tag'),
                onSaved: (value) => techTag = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter tech tag' : null,
              ),
              ListTile(
                title: Text(
                  'Event Date & Time: ${dateTime != null ? DateFormat('yyyy-MM-dd HH:mm').format(dateTime!) : 'Select Date & Time'}',
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDateTime,
              ),
              ListTile(
                title: Text(
                  'Event Image: ${imageUrl != null ? imageUrl!.split('/').last : 'No Image Selected'}',
                ),
                trailing: Icon(Icons.image),
                onTap: _pickImage,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Now you can use these variables to create a CollegeEventCard or process further
                    eventDatabaseServices.addEvent(title!, department!, dateTime!, contactDetails!, venue!, description!, techTag!, imageUrl!, false);
                    print("Title: $title");
                    print("Department: $department");
                    print("DateTime: $dateTime");
                    print("Contact Details: $contactDetails");
                    print("Venue: $venue");
                    print("Description: $description");
                    print("Tech Tag: $techTag");
                    print("Image URL: $imageUrl");
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
