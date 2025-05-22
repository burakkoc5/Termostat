import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weather',
                  style: theme.textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    // TODO: Refresh weather data
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _WeatherInfo(),
          ],
        ),
      ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual weather data from provider
    const temperature = 22.0;
    const humidity = 45;
    const condition = 'Sunny';
    const icon = Icons.wb_sunny;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _WeatherItem(
          icon: icon,
          label: 'Condition',
          value: condition,
        ),
        _WeatherItem(
          icon: Icons.thermostat,
          label: 'Temperature',
          value: '$temperature°C',
        ),
        _WeatherItem(
          icon: Icons.water_drop,
          label: 'Humidity',
          value: '$humidity%',
        ),
      ],
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(delay: 200.ms);
  }
}

class _WeatherItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
} 