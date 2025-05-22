class Thermostat {
  final double currentTemp;
  final double targetTemp;
  final double hysteresis;
  final String boilerStatus;
  final bool manualOverride;

  Thermostat({
    required this.currentTemp,
    required this.targetTemp,
    required this.hysteresis,
    required this.boilerStatus,
    required this.manualOverride,
  });

  factory Thermostat.fromMap(Map data) => Thermostat(
    currentTemp: (data['current_temp'] ?? 0.0).toDouble(),
    targetTemp: (data['target_temp'] ?? 0.0).toDouble(),
    hysteresis: (data['hysteresis'] ?? 0.5).toDouble(),
    boilerStatus: data['boiler_status'] ?? 'OFF',
    manualOverride: data['manual_override'] ?? false,
  );
} 