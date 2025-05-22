import 'package:flutter/material.dart';

class TargetTempControl extends StatelessWidget {
  final double targetTemp;
  final ValueChanged<double> onChanged;
  const TargetTempControl({super.key, required this.targetTemp, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => onChanged(targetTemp - 0.5),
        ),
        Text('${targetTemp.toStringAsFixed(1)} °C', style: const TextStyle(fontSize: 32)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onChanged(targetTemp + 0.5),
        ),
      ],
    );
  }
} 