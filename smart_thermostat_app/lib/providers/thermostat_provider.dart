import 'package:flutter/material.dart';
import '../models/thermostat.dart';
import '../services/firebase_service.dart';

class ThermostatProvider extends ChangeNotifier {
  final FirebaseService _firebase = FirebaseService();
  Thermostat? _thermostat;

  Thermostat? get thermostat => _thermostat;

  ThermostatProvider() {
    _firebase.thermostatStream().listen((event) {
      _thermostat = Thermostat.fromMap(Map<String, dynamic>.from(event.snapshot.value as Map));
      notifyListeners();
    });
  }

  Future<void> setTargetTemp(double temp) async {
    await _firebase.setTargetTemp(temp);
  }

  Future<void> setManualOverride(bool value) async {
    await _firebase.setManualOverride(value);
  }

  Future<void> setBoilerStatus(String status) async {
    await _firebase.setBoilerStatus(status);
  }
} 