import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final _db = FirebaseDatabase.instance.ref();

  Future<Map<String, dynamic>> getThermostatData() async {
    final snapshot = await _db.child('thermostat').get();
    return Map<String, dynamic>.from(snapshot.value as Map);
  }

  Future<void> setTargetTemp(double temp) async {
    await _db.child('thermostat/target_temp').set(temp);
  }

  Future<void> setManualOverride(bool value) async {
    await _db.child('thermostat/manual_override').set(value);
  }

  Future<void> setBoilerStatus(String status) async {
    await _db.child('thermostat/boiler_status').set(status);
  }

  Stream<DatabaseEvent> thermostatStream() {
    return _db.child('thermostat').onValue;
  }

  Stream<DatabaseEvent> usageLogsStream() {
    return _db.child('usage_logs').onValue;
  }
} 