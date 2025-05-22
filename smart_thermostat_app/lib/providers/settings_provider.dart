import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  double hysteresis = 0.5;
  int overrideTimeout = 60; // in minutes
  String firebasePath = '/thermostat';

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    hysteresis = prefs.getDouble('hysteresis') ?? 0.5;
    overrideTimeout = prefs.getInt('overrideTimeout') ?? 60;
    firebasePath = prefs.getString('firebasePath') ?? '/thermostat';
    notifyListeners();
  }

  Future<void> setHysteresis(double value) async {
    hysteresis = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('hysteresis', value);
    notifyListeners();
  }

  Future<void> setOverrideTimeout(int value) async {
    overrideTimeout = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('overrideTimeout', value);
    notifyListeners();
  }

  Future<void> setFirebasePath(String value) async {
    firebasePath = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firebasePath', value);
    notifyListeners();
  }
} 