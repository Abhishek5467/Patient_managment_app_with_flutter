import 'package:flutter_sound/flutter_sound.dart';

class AudioPlayerService {
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  // Initialize the audio player
  Future<void> initialize() async {
    await _audioPlayer.openAudioSession();
  }

  // Play the audio from a given file path
  Future<void> playAudio(String filePath) async {
    await _audioPlayer.startPlayer(fromURI: filePath);
  }

  // Stop the audio playback
  Future<void> stopAudio() async {
    await _audioPlayer.stopPlayer();
  }

  // Pause the audio playback
  Future<void> pauseAudio() async {
    await _audioPlayer.pausePlayer();
  }

  // Resume the audio playback
  Future<void> resumeAudio() async {
    await _audioPlayer.resumePlayer();
  }

  // Close the audio session
  Future<void> close() async {
    await _audioPlayer.closeAudioSession();
  }
}
