import 'package:flutter/material.dart';
import 'patient_form_screen.dart';
import 'patient_details_screen.dart';
import 'multimedia_screen.dart';
import 'microcontroller_screen.dart';
import '../services/audio_recorder_service.dart';
import '../services/audio_player_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioRecorderService _audioRecorderService = AudioRecorderService();
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  String? _recordingFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorderService.initialize();
    _audioPlayerService.initialize();
  }

  // Start or stop the recording
  void _toggleRecording() async {
    await _audioRecorderService.toggleRecording();
    setState(() {
      _recordingFilePath = _audioRecorderService.getFilePath();
    });
  }

  // Play the recorded sound
  void _playRecording() {
    if (_recordingFilePath != null) {
      _audioPlayerService.playAudio(_recordingFilePath!);
    } else {
      print("No recording found!");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioRecorderService.close();
    _audioPlayerService.close();
  }

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
          // Add Sound Recorder Section
          ListTile(
            title: Row(
              children: [
                ElevatedButton(
                  onPressed: _toggleRecording,
                  child: Text(_audioRecorderService.isRecordingInProgress()
                      ? 'Stop Recording'
                      : 'Start Recording'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _playRecording,
                  child: Text('Play Recording'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
