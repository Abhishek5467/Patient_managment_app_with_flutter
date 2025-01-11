import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class PatientFormScreen extends StatefulWidget {
  @override
  _PatientFormScreenState createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _age = 0;
  String _gender = 'Male';

  // Create an instance of FlutterSecureStorage
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, save the data
      _formKey.currentState?.save();

      // Securely store the data using FlutterSecureStorage
      await _secureStorage.write(key: 'patient_name', value: _name);
      await _secureStorage.write(key: 'patient_age', value: _age.toString());
      await _secureStorage.write(key: 'patient_gender', value: _gender);

      // Store the data in SQLite
      Map<String, dynamic> patient = {
        'name': _name,
        'age': _age,
        'gender': _gender,
      };
      await DatabaseHelper.instance.insertPatient(patient);

      // For demonstration, print the stored data
      print('Patient Name: $_name');
      print('Patient Age: $_age');
      print('Patient Gender: $_gender');
    }
  }

  // Function to retrieve stored data from secure storage (for testing or debugging)
  Future<void> _retrieveData() async {
    String? name = await _secureStorage.read(key: 'patient_name');
    String? age = await _secureStorage.read(key: 'patient_age');
    String? gender = await _secureStorage.read(key: 'patient_gender');

    print('Stored Patient Data from Secure Storage:');
    print('Name: $name');
    print('Age: $age');
    print('Gender: $gender');

    // Retrieve data from SQLite for testing
    List<Map<String, dynamic>> patients = await DatabaseHelper.instance.getPatients();
    print('Stored Patient Data from SQLite:');
    for (var patient in patients) {
      print('Name: ${patient['name']}, Age: ${patient['age']}, Gender: ${patient['gender']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Patient Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              
              // Age field
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.tryParse(value ?? '') ?? 0;
                },
              ),
              
              // Gender dropdown
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(labelText: 'Gender'),
                onChanged: (value) {
                  setState(() {
                    _gender = value ?? 'Male';
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
              ),
              
              // Submit button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ),
              
              // Button to retrieve stored data (for testing)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _retrieveData,
                  child: Text('Retrieve Stored Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('patients.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final pathToDb = join(dbPath, path);
    return await openDatabase(pathToDb, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE patients (
      id $idType,
      name $textType,
      age $integerType,
      gender $textType
    )
    ''');
  }

  Future<int> insertPatient(Map<String, dynamic> patient) async {
    final db = await instance.database;
    return await db.insert('patients', patient);
  }

  Future<List<Map<String, dynamic>>> getPatients() async {
    final db = await instance.database;
    return await db.query('patients');
  }

  Future<int> updatePatient(Map<String, dynamic> patient) async {
    final db = await instance.database;
    final id = patient['id'];
    return await db.update(
      'patients',
      patient,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePatient(int id) async {
    final db = await instance.database;
    return await db.delete(
      'patients',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
