import 'package:flutter/material.dart';
import 'package:untitled/theme/color_converter.dart';

class customTheme {
  String name;
  Color primaryColor; // bar's color
  Color accentColor; // selected navbar button's color
  Color textColor; // unselected navbar button, text's color
  Color backgroundColor; // background's color
  Color selectedButtonColor;
  Color unselectedButtonColor;
  Color settingTextColor;

  customTheme(
      {required this.name,
      required this.primaryColor,
      required this.accentColor,
      required this.textColor,
      required this.backgroundColor,
      required this.selectedButtonColor,
      required this.unselectedButtonColor,
      required this.settingTextColor});
}

class ThemeDataModel {
  List<customTheme> listThemes = [];

  ThemeDataModel() {
    var defaultTheme = customTheme(
        name: "Default",
        primaryColor: HexColor("#0066cc"),
        accentColor: HexColor("#0066CC"),
        textColor: HexColor("#191919"),
        backgroundColor: HexColor("#f6f6f6"),
        selectedButtonColor: HexColor("#FFFDFA"),
        unselectedButtonColor: HexColor("#FFFAFC"),
        settingTextColor: HexColor("#191919"));
    listThemes.add(defaultTheme);
  }

  Color getPrimaryColor(int index) {
    return listThemes[index].primaryColor;
  }

  Color getAccentColor(int index) {
    return listThemes[index].accentColor;
  }

  Color getTextColor(int index) {
    return listThemes[index].textColor;
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

  Color getSettingTextColor(int index) {
    return listThemes[index].settingTextColor;
  }

  void handleReadOneTheme(Map<String, dynamic> eachTheme) {
    final String name = eachTheme['themes']['name'];
    final String primaryColor = eachTheme['themes']['primaryColor'];
    final String accentColor = eachTheme['themes']['accentColor'];
    final String textColor = eachTheme['themes']['textColor'];
    final String backgroundColor = eachTheme['themes']['backgroundColor'];
    final String selectedButtonColor =
        eachTheme['themes']['selectedButtonColor'];
    final String unselectedButtonColor =
        eachTheme['themes']['UnselectedButtonColor'];
    final String settingTextColor = eachTheme['themes']['settingTextColor'];

    var theme = customTheme(
        name: name,
        primaryColor: HexColor(primaryColor),
        accentColor: HexColor(accentColor),
        textColor: HexColor(textColor),
        backgroundColor: HexColor(backgroundColor),
        selectedButtonColor: HexColor(selectedButtonColor),
        unselectedButtonColor: HexColor(unselectedButtonColor),
        settingTextColor: HexColor(settingTextColor));
    listThemes.add(theme);
  }

  void parseThemes(dynamic parsedJson) {
    final themesJson = parsedJson['themes'] as List<dynamic>;

    for (final themeJson in themesJson) {
      final String name = themeJson['name'] as String;
      final String primaryColor = themeJson['primaryColor'] as String;
      final String accentColor = themeJson['accentColor'] as String;
      final String textColor = themeJson['textColor'] as String;
      final String backgroundColor = themeJson['backgroundColor'] as String;
      final String selectedButtonColor =
          themeJson['selectedButtonColor'] as String;
      final String unselectedButtonColor =
          themeJson['unselectedButtonColor'] as String;
      final String settingTextColor = themeJson['settingTextColor'] as String;

      var themeTemp = customTheme(
          name: name,
          primaryColor: HexColor(primaryColor),
          accentColor: HexColor(accentColor),
          textColor: HexColor(textColor),
          backgroundColor: HexColor(backgroundColor),
          selectedButtonColor: HexColor(selectedButtonColor),
          unselectedButtonColor: HexColor(unselectedButtonColor),
          settingTextColor: HexColor(settingTextColor));
      listThemes.add(themeTemp);
    }
  }
}
