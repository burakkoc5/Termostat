import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  double hysteresis = 0.5;
  int overrideTimeout = 60; // in minutes
  String theme = 'system';

  SettingsProvider() {
    _loadSettings();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _loadSettings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      hysteresis = prefs.getDouble('hysteresis') ?? 0.5;
      overrideTimeout = prefs.getInt('overrideTimeout') ?? 60;
      theme = prefs.getString('theme') ?? 'system';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

  Future<void> setTheme(String value) async {
    theme = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', value);
    notifyListeners();
  }
} 