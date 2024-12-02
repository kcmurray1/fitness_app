import 'package:flutter/material.dart';
import 'package:fitness_app/common/config/timer_background.dart';

class ColorPaletteWidget extends StatelessWidget
{
  List<ColorWidget> topHalf = [];
  List<ColorWidget> botHalf = [];
  
  ColorPaletteWidget({
    super.key,
  })
  {
   
    for(int i = 0; i < TimerBackgroundColors.all.length / 2; i++)
    {
      Color firstHalf = TimerBackgroundColors.all[i];
      Color secondHalf = TimerBackgroundColors.all[TimerBackgroundColors.all.length - i - 1];

      topHalf.add(ColorWidget(color: firstHalf));
      botHalf.add(ColorWidget(color: secondHalf));

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: topHalf,
            ),
            Row(
              children: botHalf,
            )
          ],
        )
      );
  }
}

class ColorWidget extends StatelessWidget
{
  final Color color;
  ColorWidget({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: CircleBorder(),
        side: BorderSide(color: const Color.fromARGB(255, 120, 120, 120))
      ),
      onPressed: (){},
      child: CircleAvatar(
        backgroundColor: color,
      )
    ); 

  }

}