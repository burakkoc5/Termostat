import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';
import '../widgets/schedule_card.dart';

class ScheduleListScreen extends StatelessWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
      ),
      body: Consumer<ScheduleProvider>(
        builder: (context, scheduleProvider, _) {
          if (scheduleProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (scheduleProvider.error != null) {
            return Center(child: Text('Error: ${scheduleProvider.error}'));
          }

          if (scheduleProvider.schedules.isEmpty) {
            return const Center(
              child: Text('No schedules available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: scheduleProvider.schedules.length,
            itemBuilder: (context, index) {
              final schedule = scheduleProvider.schedules[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ScheduleCard(
                  schedule: schedule,
                  onToggle: (enabled) {
                    scheduleProvider.toggleSchedule(schedule.id, enabled);
                  },
                  onAdd: () {
                    // TODO: Implement add entry functionality
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add schedule functionality
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 