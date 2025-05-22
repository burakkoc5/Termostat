import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationSelector extends StatelessWidget {
  final double? homeLocationLat;
  final double? homeLocationLng;
  final ValueChanged<Position> onLocationSet;
  const LocationSelector({super.key, required this.homeLocationLat, required this.homeLocationLng, required this.onLocationSet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(homeLocationLat != null && homeLocationLng != null
            ? 'Home Location: ($homeLocationLat, $homeLocationLng)'
            : 'Home Location not set'),
        ElevatedButton(
          onPressed: () async {
            final pos = await Geolocator.getCurrentPosition();
            onLocationSet(pos);
          },
          child: const Text('Set Home Location to Current'),
        ),
      ],
    );
  }
} 