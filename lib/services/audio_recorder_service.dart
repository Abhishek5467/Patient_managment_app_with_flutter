import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';

class AudioRecorderService {
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool isRecording = false;
  String? _filePath;

  // Initialize the audio recorder
  Future<void> initialize() async {
    try {
      if (!_audioRecorder.isStopped) {
        await _audioRecorder.openRecorder();
        print('Audio recorder initialized');
      }
    } catch (e) {
      print('Error initializing audio recorder: $e');
    }
  }

  // Start or stop the recording
  Future<void> toggleRecording() async {
    try {
      if (isRecording) {
        // Stop recording
        await _audioRecorder.stopRecorder();
        isRecording = false;
        print('Recording stopped. File saved at: $_filePath');
      } else {
        // Start recording
        final tempDir = Directory.systemTemp;
        _filePath = '${tempDir.path}/patient_recording.aac';
        await _audioRecorder.startRecorder(toFile: _filePath);
        isRecording = true;
        print('Recording started. Saving to: $_filePath');
      }
    } catch (e) {
      print('Error toggling recording: $e');
    }
  }

  // Retrieve the file path of the recording
  String? getFilePath() {
    if (_filePath != null) {
      print('Recording file path: $_filePath');
    } else {
      print('No recording file path available');
    }
    return _filePath;
  }

  // Check if recording is in progress
  bool isRecordingInProgress() {
    return isRecording;
  }

  // Close the audio session
  Future<void> close() async {
    try {
      if (_audioRecorder.isStopped) {
        await _audioRecorder.closeRecorder();
        print('Audio recorder session closed');
      }
    } catch (e) {
      print('Error closing audio recorder session: $e');
    }
  }
}
