import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/schedule.dart';
import '../screens/schedule_entry_screen.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final void Function(bool)? onToggle;
  final VoidCallback? onAdd;

  const ScheduleCard({
    Key? key,
    required this.schedule,
    this.onToggle,
    this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Switch(
              value: schedule.isEnabled,
              onChanged: onToggle,
            ),
            title: Text(schedule.name),
            subtitle: Text(
              '${schedule.entries.length} ${schedule.entries.length == 1 ? 'entry' : 'entries'}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: onAdd,
              tooltip: 'Add Schedule Entry',
            ),
          ),
          if (schedule.entries.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today\'s Schedule',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...schedule.entries
                      .where((entry) => entry.dayOfWeek == DateTime.now().weekday)
                      .map((entry) => _buildScheduleEntry(context, entry))
                      .toList(),
                ],
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScheduleEntryScreen(schedule: schedule),
                ),
              );
            },
            child: const Text('Manage Schedule'),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleEntry(BuildContext context, ScheduleEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '${_formatTimeOfDay(entry.startTime)} - ${_formatTimeOfDay(entry.endTime)}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 16),
          Text(
            '${entry.mode.toUpperCase()} at ${entry.targetTemperature}°',
          ),
        ],
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _ScheduleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual schedule data from provider
    final schedules = <Schedule>[];

    if (schedules.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.schedule,
                size: 48,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 8),
              Text(
                'No schedules yet',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to schedule creation screen
                },
                child: const Text('Create Schedule'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return _ScheduleItem(schedule: schedule);
      },
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final Schedule schedule;

  const _ScheduleItem({required this.schedule});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Switch(
          value: schedule.isEnabled,
          onChanged: (value) {
            // TODO: Update schedule enabled state
          },
        ),
        title: Text(schedule.name),
        subtitle: Text(
          '${schedule.entries.length} entries',
          style: theme.textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // TODO: Navigate to schedule edit screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // TODO: Show delete confirmation dialog
              },
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideX(delay: 200.ms);
  }
} 