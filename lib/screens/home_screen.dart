import 'package:flutter/material.dart';
import 'patient_form_screen.dart';
import 'patient_details_screen.dart';
import 'multimedia_screen.dart';
import 'microcontroller_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Care')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Add Patient Details'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientFormScreen()),
            ),
          ),
          ListTile(
            title: Text('View Patient Details'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientDetailsScreen()),
            ),
          ),
          ListTile(
            title: Text('Capture Multimedia'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MultimediaScreen()),
            ),
          ),
          ListTile(
            title: Text('Microcontroller Connectivity'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MicrocontrollerScreen()),
            ),
          ),
        ],
      ),
    );
  }
}