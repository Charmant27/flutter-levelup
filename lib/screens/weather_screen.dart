import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          final currentWeather = data['list'][0];

          // getting the current temperature
          final temperature = currentWeather['main']['temp'];
          final sky = currentWeather['weather'][0]['main'];

          final humidity = currentWeather['main']['humidity'];
          final windSpeed = currentWeather['wind']['speed'];
          final pressure = currentWeather['main']['pressure'];

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
                              Icon(
                                sky == 'Clouds' || sky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
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
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final hourlyWeather = data['list'][index + 1];
                      final sky = data['list'][index + 1]['weather'][0]['main'];
                      final temp = data['list'][index + 1]['main']['temp'];

                      final date = DateTime.parse(hourlyWeather['dt_txt']);

                      return ForecastCards(
                        time: DateFormat.Hm().format(date),
                        icon: sky == 'Clouds' || sky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                        temp: temp.toString(),
                      );
                    },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                      icon: Icons.water_drop,
                      tempState: 'Humidity',
                      measure: humidity.toString(),
                    ),
                    AdditionalInfo(
                      icon: Icons.air,
                      tempState: 'Wind speed',
                      measure: windSpeed.toString(),
                    ),
                    AdditionalInfo(
                      icon: Icons.umbrella,
                      tempState: 'Pressure',
                      measure: pressure.toString(),
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
