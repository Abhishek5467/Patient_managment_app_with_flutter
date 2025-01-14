import 'package:flutter/material.dart';
import 'patient_form_screen.dart';
import 'patient_details_screen.dart';
import 'multimedia_screen.dart';
import 'microcontroller_screen.dart';
import '../services/audio_recorder_service.dart';
import '../services/audio_player_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioRecorderService _audioRecorderService = AudioRecorderService();
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  String? _recordingFilePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _audioRecorderService.initialize();
      await _audioPlayerService.initialize();
    } catch (e) {
      print('Error initializing services: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Start or stop the recording
  void _toggleRecording() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _audioRecorderService.toggleRecording();
      setState(() {
        _recordingFilePath = _audioRecorderService.getFilePath();
      });
    } catch (e) {
      print('Error toggling recording: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Play the recorded sound
  void _playRecording() async {
    if (_recordingFilePath != null) {
      try {
        await _audioPlayerService.playAudio(_recordingFilePath!);
      } catch (e) {
        print('Error playing recording: $e');
      }
    } else {
      print("No recording found!");
      _showSnackbar("No recording found!");
    }
  }

  // Show a Snackbar for user feedback
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _audioRecorderService.close();
    _audioPlayerService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Care')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
