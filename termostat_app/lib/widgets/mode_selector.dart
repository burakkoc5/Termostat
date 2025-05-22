import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ModeSelector extends StatelessWidget {
  final String mode;
  final Function(String) onModeChanged;

  const ModeSelector({
    super.key,
    required this.mode,
    required this.onModeChanged,
  });

  void _showModeChangeMessage(BuildContext context, String newMode) {
    String message;
    switch (newMode) {
      case 'on':
        message = 'Heating system activated - Relay is ON';
        break;
      case 'off':
        message = 'Heating system deactivated - Relay is OFF';
        break;
      case 'manual':
        message = 'Manual mode activated - System control disabled';
        break;
      default:
        message = 'Mode changed to $newMode';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'System Mode',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _ModeButton(
                        icon: Icons.power,
                        label: 'ON',
                        isSelected: mode == 'on',
                        onTap: () {
                          onModeChanged('on');
                          _showModeChangeMessage(context, 'on');
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Heating is active',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      _ModeButton(
                        icon: Icons.power_off,
                        label: 'OFF',
                        isSelected: mode == 'off',
                        onTap: () {
                          onModeChanged('off');
                          _showModeChangeMessage(context, 'off');
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Heating is off',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      _ModeButton(
                        icon: Icons.handyman,
                        label: 'Manual',
                        isSelected: mode == 'manual',
                        onTap: () {
                          onModeChanged('manual');
                          _showModeChangeMessage(context, 'manual');
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Manual control mode',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .scale(delay: 200.ms);
  }
} 