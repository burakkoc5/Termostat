import 'package:flutter/material.dart';

class BoilerStatusIndicator extends StatelessWidget {
  final String status;
  const BoilerStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Boiler: ', style: TextStyle(fontSize: 18)),
        Text(
          status,
          style: TextStyle(
            fontSize: 18,
            color: status == 'ON' ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 