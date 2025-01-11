import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';

class AudioRecorderService {
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool isRecording = false;
  String? _filePath;

  // Initialize the audio recorder
  Future<void> initialize() async {
    await _audioRecorder.openAudioSession();
  }

  // Start or stop the recording
  Future<void> toggleRecording() async {
    if (isRecording) {
      // Stop recording
      await _audioRecorder.stopRecorder();
      isRecording = false;
    } else {
      // Start recording
      final tempDir = Directory.systemTemp;
      _filePath = '${tempDir.path}/patient_recording.aac';
      await _audioRecorder.startRecorder(toFile: _filePath);
      isRecording = true;
    }
  }

  // Retrieve the file path of the recording
  String? getFilePath() {
    return _filePath;
  }

  // Check if recording is in progress
  bool isRecordingInProgress() {
    return isRecording;
  }

  // Close the audio session
  Future<void> close() async {
    await _audioRecorder.closeAudioSession();
  }
}
