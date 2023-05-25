import 'package:flutter/material.dart';

int convertHexToInt(String hexColor) {
  return int.parse(hexColor.substring(1), radix: 16);
}

Color convertHexToColor(String hexColor) {
  final int colorValue = int.parse(hexColor.substring(1), radix: 16);
  return Color(colorValue);
}

class customTheme {
  String name;
  String primaryColor;
  String accentColor;
  String otherColor1;
  String otherColor2;

  customTheme(
      {required this.name,
      required this.primaryColor,
      required this.accentColor,
      required this.otherColor1,
      required this.otherColor2});
}

class ThemeDataModel {
  //data Type
  List<customTheme> listThemes = [];

  ThemeDataModel() {
    listThemes = [];
  }

  void handleReadOneTheme(Map<String, dynamic> eachTheme) {
    print(eachTheme);
    // Data: Map<String, dynamic> to customTheme
    final String name = eachTheme['themes']['name'];
    final String primaryColor = eachTheme['themes']['primaryColor'];
    final String accentColor = eachTheme['themes']['accentColor'];
    final String otherColor1 = eachTheme['themes']['otherColor1'];
    final String otherColor2 = eachTheme['themes']['otherColor2'];

    var theme = customTheme(
        name: name,
        primaryColor: primaryColor,
        accentColor: accentColor,
        otherColor1: otherColor1,
        otherColor2: otherColor2);
    listThemes.add(theme);
  }

  void parseThemes(dynamic parsedJson) {
    final themesJson = parsedJson['themes'] as List<dynamic>;

    for (final themeJson in themesJson) {
      final String name = themeJson['name'] as String;
      final String primaryColor = themeJson['primaryColor'] as String;
      final String accentColor = themeJson['accentColor'] as String;
      final String otherColor1 = themeJson['otherColor1'] as String;
      final String otherColor2 = themeJson['otherColor2'] as String;

      // print(name);
      // print(primaryColor);
      // print(accentColor);
      // print(otherColor1);
      // print(otherColor2);

      var themeTemp = customTheme(
          name: name,
          primaryColor: primaryColor,
          accentColor: accentColor,
          otherColor1: otherColor1,
          otherColor2: otherColor2);
      listThemes.add(themeTemp);
    }
  }
}
