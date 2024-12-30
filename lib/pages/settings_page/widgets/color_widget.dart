import 'package:flutter/material.dart';
import 'package:fitness_app/common/config/timer_background.dart';

/// Popup containing palette of [ColorWidget]. 
/// 
/// Returns [Color] of selected [ColorWidget] 
class ColorPaletteWidget extends StatelessWidget
{
  final List<ColorWidget> topHalf = [];
  final List<ColorWidget> botHalf = [];
  final ValueChanged<Color> onColorWidgetPressed;
  
  ColorPaletteWidget({
    super.key,
    required this.onColorWidgetPressed
  })
  {
   
    for(int i = 0; i < TimerBackgroundColors.all.length / 2; i++)
    {
      Color firstHalf = TimerBackgroundColors.all[i];
      Color secondHalf = TimerBackgroundColors.all[TimerBackgroundColors.all.length - i - 1];

      topHalf.add(ColorWidget(color: firstHalf, onPressed: (color) => onColorWidgetPressed(firstHalf)));
      botHalf.add(ColorWidget(color: secondHalf, onPressed: (color) => onColorWidgetPressed(secondHalf)));

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
  final ValueChanged<Color> onPressed;

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
        onPressed: () => onPressed(color),
        child: CircleAvatar(
          radius: size,
          backgroundColor: color,
        )
      ),
    ); 

  }

}