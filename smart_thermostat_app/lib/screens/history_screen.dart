import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/usage_provider.dart';
import '../widgets/usage_log_list.dart';
import '../widgets/usage_chart.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsageProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Usage History')),
      body: Column(
        children: [
          Expanded(child: UsageLogList(logs: provider.logs)),
          SizedBox(height: 200, child: UsageChart(logs: provider.logs)),
        ],
      ),
    );
  }
} 