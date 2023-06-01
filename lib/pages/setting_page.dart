import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:get/get.dart';
import 'package:untitled/pages/setting_controller.dart';

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
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
                color: themeData
                    .getColor1(viewModeController.indexThemeData.value),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: themeData
              .getPrimaryColor(viewModeController.indexThemeData.value),
        ),
        body: Center(
          child: Container(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Choose theme options',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 6.0),
                Wrap(
                  spacing: 12.0,
                  children: List<Widget>.generate(
                    themeData.listThemes.length,
                    (int index) {
                      return ChoiceChip(
                        label: Text(
                          index == 0
                              ? 'Default'
                              : index == 1
                                  ? 'Dark'
                                  : 'Custom ${index - 1}',
                        ),
                        selected: viewModeController.currentIndex == index,
                        onSelected: (bool selected) {
                          viewModeController.currentIndex =
                              selected ? index : 0;
                          viewModeController.changeTheme(index);
                        },
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Choose view options',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 6.0),
                Wrap(
                  spacing: 12.0,
                  children: List<Widget>.generate(
                    viewModeController.viewModes.length,
                    (int index) {
                      return ChoiceChip(
                        label: Text('${viewModeController.viewModes[viewModeController.viewModesIndex]}'),
                        selected: viewModeController.viewModesIndex == index,
                        onSelected: (bool selected) {
                          viewModeController.viewModesIndex = selected ? index : 0;
                          // do action
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
