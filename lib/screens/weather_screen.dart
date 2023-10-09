import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/cards/forecast.dart';
import 'package:weather/cards/info.dart';
import 'package:http/http.dart' as http;
import 'package:weather/secret_key/secret_key.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future getCurrentWeather() async {
    const cityName = 'London';

    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$apiKey'));

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'OOPS!!! Something went wrong';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text(
          'Weather prediction',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const LinearProgressIndicator();
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.data!;

          // get the current weather
          final currentWeather = data['list'];

          // getting the current temperature
          final temperature = currentWeather[0]['main']['temp'];

          return Padding(
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$temperature°K',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              const Icon(
                                Icons.cloud,
                                size: 64,
                              ),
                              const Text(
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
                        time: '01:20',
                        icon: Icons.cloud,
                        temp: '300.0',
                      ),
                      ForecastCards(
                        time: '12:00',
                        icon: Icons.cloud,
                        temp: '35.0',
                      ),
                      ForecastCards(
                        time: '03:00',
                        icon: Icons.cloud,
                        temp: '36.8',
                      ),
                      ForecastCards(
                        time: '14:00',
                        icon: Icons.cloud,
                        temp: '39.0',
                      ),
                      ForecastCards(
                        time: '03:00',
                        icon: Icons.cloud,
                        temp: '35.0',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Additional information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                      icon: Icons.water_drop,
                      tempState: 'Humidity',
                      measure: '91',
                    ),
                    AdditionalInfo(
                      icon: Icons.air,
                      tempState: 'Wind speed',
                      measure: '7.67',
                    ),
                    AdditionalInfo(
                      icon: Icons.umbrella,
                      tempState: 'Pressure',
                      measure: '1006',
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
