import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../widgets/location_selector.dart';

class AutomationScreen extends StatelessWidget {
  const AutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Automation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LocationSelector(
              homeLocationLat: provider.homeLat,
              homeLocationLng: provider.homeLng,
              onLocationSet: provider.setHomeLocation,
            ),
            SwitchListTile(
              title: const Text('Enable GPS Automation'),
              value: provider.gpsEnabled,
              onChanged: provider.setGpsEnabled,
            ),
            if (provider.isAway)
              const Text('You are away from home. Boiler will be turned off automatically.'),
          ],
        ),
      ),
    );
  }
} 