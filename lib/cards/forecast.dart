import 'package:flutter/material.dart';

class ForecastCards extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const ForecastCards(
      {super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(time),
            const SizedBox(height: 8),
            Icon(icon),
            const SizedBox(height: 8),
            Text(temp),
          ],
        ),
      ),
    );
  }
}
