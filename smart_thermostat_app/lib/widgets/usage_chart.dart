import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/usage_log.dart';
import 'package:intl/intl.dart';

class UsageChart extends StatelessWidget {
  final List<UsageLog> logs;
  const UsageChart({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    // Group logs by day
    final Map<String, int> usagePerDay = {};
    for (var log in logs) {
      final day = DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(log.on * 1000));
      usagePerDay[day] = (usagePerDay[day] ?? 0) + log.duration;
    }
    final days = usagePerDay.keys.toList()..sort();
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                return Text(DateFormat.Md().format(DateTime.parse(days[idx])));
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: [
          for (int i = 0; i < days.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(toY: usagePerDay[days[i]]! / 60, color: Colors.blue),
            ]),
        ],
      ),
    );
  }
} 