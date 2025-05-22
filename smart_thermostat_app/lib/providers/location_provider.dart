import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class LocationProvider extends ChangeNotifier {
  bool gpsEnabled = false;
  Position? currentPosition;
  double? homeLat;
  double? homeLng;
  bool isAway = false;
  static const double radiusM = 300;

  LocationProvider() {
    _loadHomeLocation();
  }

  Future<void> setGpsEnabled(bool value) async {
    gpsEnabled = value;
    notifyListeners();
    if (value) {
      _startLocationUpdates();
    }
  }

  Future<void> setHomeLocation(Position pos) async {
    homeLat = pos.latitude;
    homeLng = pos.longitude;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('homeLat', homeLat!);
    await prefs.setDouble('homeLng', homeLng!);
    notifyListeners();
  }

  Future<void> _loadHomeLocation() async {
    final prefs = await SharedPreferences.getInstance();
    homeLat = prefs.getDouble('homeLat');
    homeLng = prefs.getDouble('homeLng');
    notifyListeners();
  }

  void _startLocationUpdates() async {
    await Geolocator.requestPermission();
    Geolocator.getPositionStream().listen((pos) {
      currentPosition = pos;
      if (homeLat != null && homeLng != null) {
        final dist = _distance(pos.latitude, pos.longitude, homeLat!, homeLng!);
        isAway = dist > radiusM;
        notifyListeners();
      }
    });
  }

  double _distance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000;
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _deg2rad(double deg) => deg * pi / 180;
} 