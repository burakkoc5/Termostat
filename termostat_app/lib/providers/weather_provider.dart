import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherProvider with ChangeNotifier {
  // !!! IMPORTANT: Replace with your actual weather API key !!!
  final String _apiKey = 'b651e31ee2e0cd1e62be2bbd9c2f999c'; 
  final WeatherFactory _wf;

  Weather? _weatherData;
  bool _isLoading = false;
  String? _error;

  Weather? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  WeatherProvider() : _wf = WeatherFactory('b651e31ee2e0cd1e62be2bbd9c2f999c', language: Language.ENGLISH) { // !!! IMPORTANT: Replace with your actual weather API key here too !!!
    // Optionally fetch weather data when the provider is created
    fetchWeatherForCurrentLocation();
  }

  Future<void> fetchWeatherForCurrentLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Use Ankara's coordinates directly
      const double ankaraLatitude = 39.933363;
      const double ankaraLongitude = 32.859742;
      
      print('Using Ankara location: $ankaraLatitude, $ankaraLongitude');

      // Fetch weather data using Ankara's coordinates
      _weatherData = await _wf.currentWeatherByLocation(
        ankaraLatitude,
        ankaraLongitude,
      );

      _error = null; // Clear previous errors on successful fetch

    } catch (e) {
      print('Error occurred: $e');
      _error = 'Failed to fetch weather data: ${e.toString()}';
      _weatherData = null; // Clear previous data on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 