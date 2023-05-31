import 'package:flutter/material.dart';
import 'package:untitled/theme/color_converter.dart';

class customTheme {
  String name;
  Color primaryColor; // bar's color
  Color accentColor; // button's color
  Color otherColor1; // text's color
  Color otherColor2; 

  customTheme(
      {required this.name,
      required this.primaryColor,
      required this.accentColor,
      required this.otherColor1,
      required this.otherColor2});
}

class ThemeDataModel {
  List<customTheme> listThemes = [];

  ThemeDataModel() {
    var defaultTheme = customTheme(
        name: "Default",
        primaryColor: HexColor("#0066cc"),
        accentColor: HexColor("#FFFDFA"),
        otherColor1: HexColor("#FFFAFC"),
        otherColor2: HexColor("#cadeef"));
    listThemes.add(defaultTheme);
  }

  Color getPrimaryColor(int index) {
    return listThemes[index].primaryColor;
  }

  Color getAccentColor(int index) {
    return listThemes[index].accentColor;
  }

  Color getColor1(int index) {
    return listThemes[index].otherColor1;
  }

  Color getColor2(int index) {
    return listThemes[index].otherColor2;
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
      primaryColor: HexColor(primaryColor),
      accentColor: HexColor(accentColor),
      otherColor1: HexColor(otherColor1),
      otherColor2: HexColor(otherColor2),
    );
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

      var themeTemp = customTheme(
          name: name,
          primaryColor: HexColor(primaryColor),
          accentColor: HexColor(accentColor),
          otherColor1: HexColor(otherColor1),
          otherColor2: HexColor(otherColor2));
      listThemes.add(themeTemp);
    }
  }
}
