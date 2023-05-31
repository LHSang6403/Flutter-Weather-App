import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
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
  bool isAutoRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor:
            themeData.getPrimaryColor(viewModeController.indexThemeData.value),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
              title: const Text('Auto refresh'),
              trailing: Switch(
                value: isAutoRefresh,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    isAutoRefresh = value;
                  });
                },
              )),
          ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: viewModeController.isDarkMode.value,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  // setState(() {
                  //   (indexThemeData == 0)
                  //       ? indexThemeData = 1
                  //       : indexThemeData = 0;
                  //   viewModeController.isDarkMode.value = value;
                  // });
                  viewModeController.increaseTheme();
                },
              )),
        ],
      ),
    );
  }
}
