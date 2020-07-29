import 'package:flutter/material.dart';

class MyTextStyle {
  static TextStyle title = TextStyle(fontSize: 28.0, color: Colors.grey[400]);
  static TextStyle label = TextStyle(
      fontSize: 18.0,
      color: Colors.amber,
      letterSpacing: 1.0,
      fontWeight: FontWeight.w900);
  static TextStyle getLabel(Color color) {
    return TextStyle(
        fontSize: 18.0,
        color: color,
        letterSpacing: 1.0,
        fontWeight: FontWeight.w900);
  }
}
