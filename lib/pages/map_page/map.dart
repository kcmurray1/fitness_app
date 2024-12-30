

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/pages/timer_page/widgets/sound_player.dart';

class MapPage extends StatelessWidget
{

  final player = AudioPlayer();
  String soundPath = "audio/alarm.mp3";

  Future<void> PlaySound() async
  {
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: Text("press me"),
          onPressed: () async {
            SoundPlayer(audioPath: soundPath);
            // await PlaySound();
          },
        )
      ],
    );
  }
}