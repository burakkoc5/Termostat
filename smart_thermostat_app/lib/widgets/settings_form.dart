import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final hysteresisController = TextEditingController(text: provider.hysteresis.toString());
    final timeoutController = TextEditingController(text: provider.overrideTimeout.toString());
    final pathController = TextEditingController(text: provider.firebasePath);

    return ListView(
      children: [
        TextField(
          controller: hysteresisController,
          decoration: const InputDecoration(labelText: 'Hysteresis (°C)'),
          keyboardType: TextInputType.number,
          onSubmitted: (val) => provider.setHysteresis(double.tryParse(val) ?? 0.5),
        ),
        TextField(
          controller: timeoutController,
          decoration: const InputDecoration(labelText: 'Override Timeout (min)'),
          keyboardType: TextInputType.number,
          onSubmitted: (val) => provider.setOverrideTimeout(int.tryParse(val) ?? 60),
        ),
        TextField(
          controller: pathController,
          decoration: const InputDecoration(labelText: 'Firebase Path'),
          onSubmitted: (val) => provider.setFirebasePath(val),
        ),
      ],
    );
  }
} 