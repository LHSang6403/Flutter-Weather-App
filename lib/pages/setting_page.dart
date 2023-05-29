import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Auto refresh'),
            trailing: Switch(
              value: true, // Replace with your logic for the setting value
              onChanged: (bool value) {
                // Handle the setting change here
              },
            ),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: false, // Replace with your logic for the setting value
              onChanged: (bool value) {
                // Handle the setting change here
              },
            ),
          ),
        ],
      ),
    );
  }
}
