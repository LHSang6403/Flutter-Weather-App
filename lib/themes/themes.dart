import 'package:flutter/material.dart';

class Themes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Colors.red, opacity: 0.8),
  );
}

class HandleColor {
  late final Color primaryColor;
  late final Color accentColor;

  HandleColor(BuildContext context) {
    final theme = Theme.of(context);
    primaryColor = theme.colorScheme.primary;
    accentColor = theme.colorScheme.secondary;
  }

  Color getSystemPrimaryColor() {
    return primaryColor;
  }

  Color getSystemAccentColor() {
    return accentColor;
  }
}
