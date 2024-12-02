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

      topHalf.add(ColorWidget(color: firstHalf, onPressed: (){
      }));
      botHalf.add(ColorWidget(color: secondHalf, onPressed: (){
      },));

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: topHalf,
            ),
            Padding(padding: EdgeInsets.all(15)),
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
  final double spacing;
  final double size;
  final Function onPressed;

  ColorWidget({
    super.key,
    required this.color,
    required this.onPressed,
    this.size = 75,
    this.spacing = 100
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: spacing,
      height: size,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(5),
          shape: CircleBorder(),
          side: BorderSide(color: const Color.fromARGB(255, 120, 120, 120))
        ),
        onPressed: () => onPressed(),
        child: CircleAvatar(
          radius: size,
          backgroundColor: color,
        )
      ),
    ); 

  }

}