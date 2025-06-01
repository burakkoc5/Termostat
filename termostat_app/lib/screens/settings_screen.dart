import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: settings.theme == 'dark',
                  onChanged: (isOn) {
                    settings.toggleTheme();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 