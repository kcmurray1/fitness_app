import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

///Creates and plays audio given an audio file path
class SoundPlayer {

  final AudioPlayer _audioPlayer;
  final String audioPath;
  Timer? _timer;
  SoundPlayer({required this.audioPath}) : _audioPlayer = AudioPlayer()
  {
    _playSound(audioPath);
  }
  
  // Play audio and then repeat every 1 second
  Future<void> _playSound(String path) async
  {
    await _audioPlayer.play(AssetSource(path));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _audioPlayer.play(AssetSource(path));
    });
    
  }

  // Stop playing and repeating audio
  void stop()
  {
    _audioPlayer.stop();
    _timer!.cancel();
  }
}