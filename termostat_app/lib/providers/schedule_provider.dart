import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Schedule> _schedules = [];
  bool _isLoading = false;
  String? _error;

  List<Schedule> get schedules => _schedules;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadSchedules() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final snapshot = await _database.child('schedules').get();
      if (snapshot.exists && snapshot.value is Map) {
        final raw = snapshot.value as Map;
        _schedules = raw.entries
            .where((entry) => entry.value is Map)
            .map((entry) {
              final scheduleData = Map<String, dynamic>.from(entry.value as Map);
              scheduleData['id'] = entry.key;
              return Schedule.fromJson(scheduleData);
            }).toList();
      } else {
        _schedules = [];
      }
    } catch (e) {
      _error = 'Failed to load schedules: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addSchedule(Schedule schedule) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final newRef = _database.child('schedules').push();
      await newRef.set(schedule.toJson());
      final newSchedule = schedule.copyWith(id: newRef.key!);
      _schedules.add(newSchedule);
    } catch (e) {
      _error = 'Failed to add schedule: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateSchedule(Schedule schedule) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _database.child('schedules/${schedule.id}').update(schedule.toJson());
      final index = _schedules.indexWhere((s) => s.id == schedule.id);
      if (index != -1) {
        _schedules[index] = schedule;
      }
    } catch (e) {
      _error = 'Failed to update schedule: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _database.child('schedules/$scheduleId').remove();
      _schedules.removeWhere((s) => s.id == scheduleId);
    } catch (e) {
      _error = 'Failed to delete schedule: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleSchedule(String scheduleId, bool enabled) async {
    try {
      final schedule = _schedules.firstWhere((s) => s.id == scheduleId);
      final updatedSchedule = schedule.copyWith(isEnabled: enabled);
      await updateSchedule(updatedSchedule);
    } catch (e) {
      _error = 'Failed to toggle schedule: $e';
      notifyListeners();
    }
  }

  Future<void> addEntryToSchedule(String scheduleId, ScheduleEntry entry) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final scheduleIndex = _schedules.indexWhere((s) => s.id == scheduleId);
      if (scheduleIndex != -1) {
        final updatedEntries = List<ScheduleEntry>.from(_schedules[scheduleIndex].entries);
        updatedEntries.add(entry);
        final updatedSchedule = _schedules[scheduleIndex].copyWith(entries: updatedEntries);

        await _database.child('schedules/$scheduleId/entries').set(updatedEntries.map((e) => e.toJson()).toList());

        _schedules[scheduleIndex] = updatedSchedule;
      } else {
        _error = 'Schedule not found';
      }
    } catch (e) {
      _error = 'Failed to add schedule entry: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 