import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Schedule {
  final String id;
  final String name;
  final List<ScheduleEntry> entries;
  bool isEnabled;

  Schedule({
    required this.id,
    required this.name,
    required this.entries,
    this.isEnabled = true,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final entriesRaw = json['entries'];
    List<ScheduleEntry> entriesList = [];
    if (entriesRaw is List) {
      entriesList = entriesRaw
          .where((e) => e is Map)
          .map((e) => ScheduleEntry.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } else {
      // Optionally log or handle the unexpected type
      print('Unexpected entries type: \\${entriesRaw}');
    }
    return Schedule(
      id: json['id'] as String,
      name: json['name'] as String,
      entries: entriesList,
      isEnabled: json['isEnabled'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'entries': entries.map((e) => e.toJson()).toList(),
      'isEnabled': isEnabled,
    };
  }

  Schedule copyWith({
    String? id,
    String? name,
    List<ScheduleEntry>? entries,
    bool? isEnabled,
  }) {
    return Schedule(
      id: id ?? this.id,
      name: name ?? this.name,
      entries: entries ?? this.entries,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class ScheduleEntry {
  final String id;
  final int dayOfWeek; // 1-7 (Monday-Sunday)
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final double targetTemperature;
  final String mode; // 'heat', 'cool', 'auto', 'off'

  ScheduleEntry({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.targetTemperature,
    required this.mode,
  });

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      id: json['id'] as String,
      dayOfWeek: json['dayOfWeek'] as int,
      startTime: TimeOfDay(
        hour: json['startTimeHour'] as int,
        minute: json['startTimeMinute'] as int,
      ),
      endTime: TimeOfDay(
        hour: json['endTimeHour'] as int,
        minute: json['endTimeMinute'] as int,
      ),
      targetTemperature: (json['targetTemperature'] as num).toDouble(),
      mode: json['mode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dayOfWeek': dayOfWeek,
      'startTimeHour': startTime.hour,
      'startTimeMinute': startTime.minute,
      'endTimeHour': endTime.hour,
      'endTimeMinute': endTime.minute,
      'targetTemperature': targetTemperature,
      'mode': mode,
    };
  }

  ScheduleEntry copyWith({
    String? id,
    int? dayOfWeek,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    double? targetTemperature,
    String? mode,
  }) {
    return ScheduleEntry(
      id: id ?? this.id,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      targetTemperature: targetTemperature ?? this.targetTemperature,
      mode: mode ?? this.mode,
    );
  }
} 