import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/thermostat_provider.dart';
import '../widgets/temp_display.dart';
import '../widgets/target_temp_control.dart';
import '../widgets/boiler_status_indicator.dart';
import '../widgets/manual_override_switch.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThermostatProvider>(context);
    final thermostat = provider.thermostat;

    if (thermostat == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Thermostat Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TempDisplay(currentTemp: thermostat.currentTemp),
            const SizedBox(height: 16),
            TargetTempControl(
              targetTemp: thermostat.targetTemp,
              onChanged: (val) => provider.setTargetTemp(val),
            ),
            const SizedBox(height: 16),
            BoilerStatusIndicator(status: thermostat.boilerStatus),
            const SizedBox(height: 16),
            ManualOverrideSwitch(
              value: thermostat.manualOverride,
              onChanged: (val) => provider.setManualOverride(val),
            ),
            if (thermostat.manualOverride) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => provider.setBoilerStatus('ON'),
                    child: const Text('Turn ON'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => provider.setBoilerStatus('OFF'),
                    child: const Text('Turn OFF'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
} 