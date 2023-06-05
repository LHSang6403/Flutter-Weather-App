import 'package:flutter/material.dart';
import 'package:untitled/theme/color_converter.dart';

class customTheme {
  String name;
  Color primaryColor; // bar's color
  Color accentColor; // selected navbar button's color
  Color accentColor2; // unselected navbar button, text's color
  Color backgroundColor; // background's color
  Color selectedButtonColor;
  Color unselectedButtonColor;

  customTheme(
      {required this.name,
      required this.primaryColor,
      required this.accentColor,
      required this.accentColor2,
      required this.backgroundColor,
      required this.selectedButtonColor,
      required this.unselectedButtonColor});
}

class ThemeDataModel {
  List<customTheme> listThemes = [];

  ThemeDataModel() {
    var defaultTheme = customTheme(
        name: "Default",
        primaryColor: HexColor("#0066cc"),
        accentColor: HexColor("#FFFDFA"),
        accentColor2: HexColor("#FFFAFC"),
        backgroundColor: HexColor("#f6f6f6"),
        selectedButtonColor: HexColor("#1cb2f5"),
        unselectedButtonColor: HexColor("#dddddd"));
    listThemes.add(defaultTheme);
  }

  Color getPrimaryColor(int index) {
    return listThemes[index].primaryColor;
  }

  Color getAccentColor(int index) {
    return listThemes[index].accentColor;
  }

  Color getAccentColor2(int index) {
    return listThemes[index].accentColor2;
  }

  Color getBackgroundColor(int index) {
    return listThemes[index].backgroundColor;
  }

  Color getSelectedButtonColor(int index) {
    return listThemes[index].selectedButtonColor;
  }

  Color getUnselectedButtonColor(int index) {
    return listThemes[index].unselectedButtonColor;
  }

  void handleReadOneTheme(Map<String, dynamic> eachTheme) {
    final String name = eachTheme['themes']['name'];
    final String primaryColor = eachTheme['themes']['primaryColor'];
    final String accentColor = eachTheme['themes']['accentColor'];
    final String accentColor2 = eachTheme['themes']['accentColor2'];
    final String backgroundColor = eachTheme['themes']['backgroundColor'];
    final String selectedButtonColor =
        eachTheme['themes']['selectedButtonColor'];
    final String unselectedButtonColor =
        eachTheme['themes']['UnselectedButtonColor'];

    var theme = customTheme(
        name: name,
        primaryColor: HexColor(primaryColor),
        accentColor: HexColor(accentColor),
        accentColor2: HexColor(accentColor2),
        backgroundColor: HexColor(backgroundColor),
        selectedButtonColor: HexColor(selectedButtonColor),
        unselectedButtonColor: HexColor(unselectedButtonColor));
    listThemes.add(theme);
  }

  void parseThemes(dynamic parsedJson) {
    final themesJson = parsedJson['themes'] as List<dynamic>;

    for (final themeJson in themesJson) {
      final String name = themeJson['name'] as String;
      final String primaryColor = themeJson['primaryColor'] as String;
      final String accentColor = themeJson['accentColor'] as String;
      final String accentColor2 = themeJson['accentColor2'] as String;
      final String backgroundColor = themeJson['backgroundColor'] as String;
      final String selectedButtonColor =
          themeJson['selectedButtonColor'] as String;
      final String unselectedButtonColor =
          themeJson['unselectedButtonColor'] as String;

      var themeTemp = customTheme(
          name: name,
          primaryColor: HexColor(primaryColor),
          accentColor: HexColor(accentColor),
          accentColor2: HexColor(accentColor2),
          backgroundColor: HexColor(backgroundColor),
          selectedButtonColor: HexColor(selectedButtonColor),
          unselectedButtonColor: HexColor(unselectedButtonColor));
      listThemes.add(themeTemp);
    }
  }
}
