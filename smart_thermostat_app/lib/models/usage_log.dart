class UsageLog {
  final int on;
  final int off;
  final int duration;

  UsageLog({required this.on, required this.off, required this.duration});

  factory UsageLog.fromMap(Map data) => UsageLog(
    on: data['on'] ?? 0,
    off: data['off'] ?? 0,
    duration: data['duration'] ?? 0,
  );
} 