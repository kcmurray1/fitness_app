import 'package:flutter/material.dart';

class TimerBackgroundColors {
  // General colors
  static const Color neutralGray = Color(0xFFB9B9B9); // Neutral gray, high contrast
  static const Color softWhite = Color(0xFFF5F5F5);// Soft white, for light themes
  static const Color deepBlack = Color(0xFF1A1A1A);  // Deep black, for dark themes
  
  // Colors for Deuteranopia and Protanopia (red-green blindness)
  static const Color orange = Color(0xFFF09000);  // Orange (for warm tones)
  static const Color teal = Color(0xFF008080);    // Teal (good for blue-green contrast)
  static const Color yellow = Color(0xFFF3E500);  // Yellow (distinctive and vibrant)

  // Colors for Tritanopia (blue-yellow blindness)
  static const Color magenta = Color(0xFFAA00FF); // Magenta (stands out well)
  static const Color limeGreen = Color(0xFF32CD32); // Lime green (distinct and bright)
  static const Color red = Color(0xFFFF0000);      // Red (for distinctiveness)

  // Colors for combined accessibility
  static const Color lightBlue = Color(0xFF56B4E9);  // Light blue, highly accessible
  static const Color brightPurple = Color(0xFF9400D3); // Bright purple, good contrast
  static const Color warmBrown = Color(0xFF8B4513);   // Warm brown, for natural tones


  static List<Color> all = [
    neutralGray,
    softWhite,
    deepBlack,
    orange,
    teal,
    yellow,
    magenta,
    limeGreen,
    red,
    lightBlue,
    brightPurple,
    warmBrown
  ];

}