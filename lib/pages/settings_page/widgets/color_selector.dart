
import 'package:flutter/material.dart';
import 'package:fitness_app/pages/settings_page/widgets/color_widget.dart';

class ColorSelector extends StatelessWidget
{
  double colorWidgetSize = 50;
  double colorWidgetSpacing = 50;
  final Color initialColor;

  ColorSelector({
    super.key,
    required this.initialColor
  });

  Future<void> _buildPopUp(BuildContext context)
  {
    return showDialog<void>(
      context:  context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 200,
          child: Center(
            child: ColorPaletteWidget()),
        ),   
        actions: []
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {

    return ColorWidget(
              color: initialColor,
              onPressed: () => _buildPopUp(context),
              size: colorWidgetSize,
              spacing: colorWidgetSpacing,  
    );
  }
}