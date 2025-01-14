import 'package:flutter_sound/flutter_sound.dart';

class AudioPlayerService {
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  // Initialize the audio player
  Future<void> initialize() async {
    try {
      if (!_audioPlayer.isOpen()) {
        await _audioPlayer.openPlayer();
      }
    } catch (e) {
      print('Error initializing audio player: $e');
    }
  }

  // Play the audio from a given file path
  Future<void> playAudio(String filePath) async {
    try {
      if (!_audioPlayer.isPlaying) {
        await _audioPlayer.startPlayer(fromURI: filePath);
      } else {
        print('Audio is already playing');
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  // Stop the audio playback
  Future<void> stopAudio() async {
    try {
      if (_audioPlayer.isPlaying) {
        await _audioPlayer.stopPlayer();
      } else {
        print('No audio is currently playing');
      }
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  // Pause the audio playback
  Future<void> pauseAudio() async {
    try {
      if (_audioPlayer.isPlaying) {
        await _audioPlayer.pausePlayer();
      } else {
        print('No audio is currently playing to pause');
      }
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  // Resume the audio playback
  Future<void> resumeAudio() async {
    try {
      if (!_audioPlayer.isPlaying) {
        await _audioPlayer.resumePlayer();
      } else {
        print('Audio is already playing');
      }
    } catch (e) {
      print('Error resuming audio: $e');
    }
  }

  // Check if audio is currently playing
  bool isPlaying() {
    return _audioPlayer.isPlaying;
  }

  // Close the audio session
  Future<void> close() async {
    try {
      if (_audioPlayer.isStopped) {
        await _audioPlayer.closePlayer();
      }
    } catch (e) {
      print('Error closing audio session: $e');
    }
  }
}
