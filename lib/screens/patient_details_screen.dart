import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailsScreen> {
  final String _name = 'John Doe';  // Example default value
  final String _age = '30';         // Example default value
  final String _gender = 'Male';    // Example default value

  @override
  void initState() {
    super.initState();
    // If you need to fetch data from another source, you can do so here.
    // For example, if the data is passed from another screen or fetched from an API.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Name
            Text('Name: $_name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            // Patient Age
            Text('Age: $_age', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            // Patient Gender
            Text('Gender: $_gender', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
