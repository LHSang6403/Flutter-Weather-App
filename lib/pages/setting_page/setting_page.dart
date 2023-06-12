import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:get/get.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ViewModeController viewModeController = Get.put(ViewModeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: Colors.white.withOpacity(0.0),
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
                color: themeData
                    .getAccentColor2(viewModeController.indexThemeData.value),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: themeData
              .getPrimaryColor(viewModeController.indexThemeData.value),
        ),
        body: Center(
          child: SizedBox(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  'View options',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: viewModeController.indexThemeData.value == 0
                        ? Colors.black
                        : themeData.getAccentColor2(
                            viewModeController.indexThemeData.value),
                  ),
                ),
                Row(children: [
                  Expanded(
                      child: Text(
                    viewModeController.isGrid.value == false
                        ? 'Enable Grid'
                        : 'Disable Grid',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: viewModeController.indexThemeData.value == 0
                          ? Colors.black
                          : themeData.getAccentColor2(
                              viewModeController.indexThemeData.value),
                    ),
                  )),
                  Switch(
                    value: viewModeController.isGrid.value,
                    onChanged: (newValue) {
                      viewModeController.toggleChangeView(newValue);
                    },
                  ),
                ]),
                Divider(
                  color: viewModeController.indexThemeData.value == 0
                      ? Colors.black
                      : themeData.getAccentColor2(
                          viewModeController.indexThemeData.value),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Theme options',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: viewModeController.indexThemeData.value == 0
                        ? Colors.black
                        : themeData.getAccentColor2(
                            viewModeController.indexThemeData.value),
                  ),
                ),
                const SizedBox(height: 6.0),
                Wrap(
                  spacing: 14.0,
                  children: themeData.listThemes.map(
                    (item) {
                      var index = themeData.listThemes.indexOf(item);
                      return ChoiceChip(
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/images/weather_icons/theme${themeData.listThemes.indexOf(item)}.jpg"),
                        ),
                        label: Text(
                          index == 0
                              ? 'Default'
                              : index == 1
                                  ? 'Dark'
                                  : 'Custom ${index - 1}',
                        ),
                        selected: viewModeController.currentIndex == index,
                        labelStyle: TextStyle(
                          fontWeight: viewModeController.currentIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: viewModeController.currentIndex == index
                              ? themeData.getAccentColor(
                                  viewModeController.indexThemeData.value)
                              : Colors.black87,
                        ),
                        backgroundColor:
                            viewModeController.currentIndex == index
                                ? themeData.getSelectedButtonColor(
                                    viewModeController.indexThemeData.value)
                                : themeData.getUnselectedButtonColor(
                                    viewModeController.indexThemeData.value),
                        onSelected: (bool selected) {
                          viewModeController.currentIndex =
                              selected ? index : 0;
                          viewModeController.changeTheme(index);
                          //setState(() {});
                          //print('re-render theme');
                        },
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        )));
  }
}
