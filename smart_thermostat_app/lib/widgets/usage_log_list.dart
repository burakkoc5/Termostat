import 'package:flutter/material.dart';
import '../models/usage_log.dart';
import 'package:intl/intl.dart';

class UsageLogList extends StatelessWidget {
  final List<UsageLog> logs;
  const UsageLogList({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const Center(child: Text('No usage logs.'));
    }
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        final start = DateTime.fromMillisecondsSinceEpoch(log.on * 1000);
        final end = DateTime.fromMillisecondsSinceEpoch(log.off * 1000);
        final duration = Duration(seconds: log.duration);
        return ListTile(
          title: Text('${DateFormat.yMd().add_jm().format(start)} - ${DateFormat.jm().format(end)}'),
          subtitle: Text('Duration: ${duration.inMinutes} min'),
        );
      },
    );
  }
} 