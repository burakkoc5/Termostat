import 'package:flutter/material.dart';
import '../widgets/settings_form.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SettingsForm(),
      ),
    );
  }
} 