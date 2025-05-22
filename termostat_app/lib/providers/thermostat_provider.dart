import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/thermostat.dart';

class ThermostatProvider with ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Thermostat? _thermostat;
  bool _isLoading = false;
  String? _error;

  Thermostat? get thermostat => _thermostat;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initializeThermostat(String deviceId) async {
    _isLoading = true;
    _error = null;

    try {
      final snapshot = await _database.child('devices/$deviceId').get();
      if (snapshot.exists && snapshot.value is Map) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        data['id'] = deviceId;
        _thermostat = Thermostat.fromJson(data);
      } else {
        _error = 'Device not found or invalid format';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTemperature(double temperature) async {
    if (_thermostat == null) return;
    try {
      await _database.child('devices/${_thermostat!.id}/targetTemperature').set(temperature);
      _thermostat = _thermostat!.copyWith(targetTemperature: temperature);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateMode(String mode) async {
    if (_thermostat == null) return;

    try {
      await _database.child('devices/${_thermostat!.id}/mode').set(mode);
      _thermostat = _thermostat!.copyWith(mode: mode);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to update mode: $e';
      notifyListeners();
    }
  }

  void startListening() {
    if (_thermostat == null) return;
    _database.child('devices/${_thermostat!.id}').onValue.listen((event) {
      if (event.snapshot.exists && event.snapshot.value is Map) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        data['id'] = _thermostat!.id;
        _thermostat = Thermostat.fromJson(data);
        notifyListeners();
      }
    });
  }

  void stopListening() {
    // No-op for now
  }
} 