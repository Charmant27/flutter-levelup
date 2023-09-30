import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/cards/forecast.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Weather'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300°K',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          Text(
                            'Rain',
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Weather forecast',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ForecastCards(
                    time: '03:00',
                    icon: Icons.cloud,
                    temp: '35.0',
                  ),
                  ForecastCards(
                    time: '03:00',
                    icon: Icons.cloud,
                    temp: '35.0',
                  ),
                  ForecastCards(
                    time: '03:00',
                    icon: Icons.cloud,
                    temp: '35.0',
                  ),
                  ForecastCards(
                    time: '03:00',
                    icon: Icons.cloud,
                    temp: '35.0',
                  ),
                  ForecastCards(
                    time: '03:00',
                    icon: Icons.cloud,
                    temp: '35.0',
                  ),
                  ForecastCards(
                    time: '03:00',
                    icon: Icons.cloud,
                    temp: '35.0',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
