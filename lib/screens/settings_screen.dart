import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SwitchListTile(
        title: Text('Dark Mode'),
        value: _isDarkMode,
        onChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}