import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class SoundPlayer {

  final AudioPlayer _audioPlayer;
  final String audioPath;
  SoundPlayer({required this.audioPath}) : _audioPlayer = AudioPlayer()
  {
    _playSound(audioPath);
  }

  Future<void> _playSound(String path) async
  {
    await _audioPlayer.play(AssetSource(path));
  }
}

// class SoundPlayer extends StatefulWidget {
//   final String audioPath;

//   SoundPlayer({
//     required this.audioPath
//   });

//   @override
//   State<SoundPlayer> createState() => _SoundPlayerState();
// }

// class _SoundPlayerState extends State<SoundPlayer>
// {
//   final _audioPlayer = AudioPlayer();

//   Future<void> _playSound() async
//   {
//     await _audioPlayer.play(AssetSource(widget.audioPath));
//   }

//   @override
//   void initState() {
//     super.initState();
//     _playSound();
//   }

//   @override
//   void dispose()
//   {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.shrink();
    
//   }
// }