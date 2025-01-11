import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PatientDetailsScreen extends StatefulWidget {
  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailsScreen> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String _name = '';
  String _age = '';
  String _gender = '';

  // Function to retrieve stored data
  Future<void> _retrieveData() async {
    String? name = await _secureStorage.read(key: 'patient_name');
    String? age = await _secureStorage.read(key: 'patient_age');
    String? gender = await _secureStorage.read(key: 'patient_gender');

    setState(() {
      _name = name ?? 'Not available';
      _age = age ?? 'Not available';
      _gender = gender ?? 'Not available';
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveData(); // Retrieve patient data when the screen is loaded
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
