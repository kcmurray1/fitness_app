import 'package:flutter/material.dart';

class ColorUtils {
  static String serialize(Color color)
  {
    return "${color.value}";
  }

  static Color deserialize(String colorStr)
  {
    return Color(int.parse(colorStr));
  }


}