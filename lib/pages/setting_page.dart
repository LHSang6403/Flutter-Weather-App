import 'package:flutter/material.dart';
import 'package:untitled/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isdarkMode = false;
  bool isAutoRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: themeData.getPrimaryColor(indexThemeData),
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
                value: isdarkMode,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    (indexThemeData == 0)
                        ? indexThemeData = 1
                        : indexThemeData = 0;
                    isdarkMode = value;
                  });
                },
              )),
        ],
      ),
    );
  }
}
