import 'package:flutter/material.dart';

class TempDisplay extends StatelessWidget {
  final double currentTemp;
  const TempDisplay({super.key, required this.currentTemp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Current Temperature', style: TextStyle(fontSize: 18)),
        Text('${currentTemp.toStringAsFixed(1)} °C', style: const TextStyle(fontSize: 48)),
      ],
    );
  }
} 