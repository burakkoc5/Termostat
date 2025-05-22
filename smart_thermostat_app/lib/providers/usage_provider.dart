import 'package:flutter/material.dart';
import '../models/usage_log.dart';
import '../services/firebase_service.dart';

class UsageProvider extends ChangeNotifier {
  final FirebaseService _firebase = FirebaseService();
  List<UsageLog> _logs = [];
  List<UsageLog> get logs => _logs;

  UsageProvider() {
    _firebase.usageLogsStream().listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        _logs = [];
        data.forEach((date, sessions) {
          if (sessions is List) {
            for (var session in sessions) {
              if (session is Map) {
                _logs.add(UsageLog.fromMap(session));
              }
            }
          } else if (sessions is Map) {
            sessions.forEach((key, session) {
              if (session is Map) {
                _logs.add(UsageLog.fromMap(session));
              }
            });
          }
        });
      }
      notifyListeners();
    });
  }
} 