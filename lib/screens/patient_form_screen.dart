import '../services/storage_service.dart';
import 'package:flutter/material.dart';

class PatientFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Add Patient Details')),
      body: Center(child: Text('Patient Form Screen')),
    );
  }
}

