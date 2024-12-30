
import 'package:flutter/material.dart';
import 'package:fitness_app/pages/settings_page/widgets/color_widget.dart';

/// Display and update circle icon with color [ColorSelector.initialColor] 
class ColorSelector extends StatefulWidget
{
  Color initialColor;
  final Function onColorChange;

  ColorSelector({
    super.key,
    required this.initialColor,
    required this.onColorChange
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector>
{
  double colorWidgetSize = 50;
  double colorWidgetSpacing = 50;


  Future<void> _buildPopUp(BuildContext context)
  {
    return showDialog<void>(
      context:  context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 200,
          child: Center(
            child: ColorPaletteWidget(
              onColorWidgetPressed: (color){
                setState(() {
                  widget.initialColor = color;
                });
                Navigator.of(context).pop();
              },
            )),
        ),   
        actions: []
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {

    return ColorWidget(
              color: widget.initialColor,
              onPressed: (color) async {
                await _buildPopUp(context);
                widget.onColorChange(widget.initialColor);
              },
              size: colorWidgetSize,
              spacing: colorWidgetSpacing,  
    );
  }
}