import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String tempState;
  final String measure;
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.tempState,
    required this.measure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(height: 8),
        Text(
          tempState,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          measure,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
