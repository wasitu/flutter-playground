import 'package:flutter/material.dart';

class ThemeColor {
  final Brightness _brightness;
  Brightness get brightness => _brightness;
  const ThemeColor(this._brightness);

  static ThemeColor of(BuildContext context, {bool sample = false}) {
    return ThemeColor(Theme.of(context).brightness);
  }

  Color get label =>
      // brightness == Brightness.light ? Colors.black : Colors.white;
      brightness == Brightness.light
          ? Colors.black.withOpacity(0.8)
          : Colors.white.withOpacity(0.8);
  Color get label2 => brightness == Brightness.light
      ? Colors.black.withOpacity(0.6)
      : Colors.white.withOpacity(0.6);
}
