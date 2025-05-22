import 'package:flutter/material.dart';

class ManualOverrideSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const ManualOverrideSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Manual Override'),
      value: value,
      onChanged: onChanged,
    );
  }
} 