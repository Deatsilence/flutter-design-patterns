import 'package:design_patterns/patterns/proxy/proxy.dart';
import 'package:design_patterns/patterns/proxy/subject_interface.dart';
import 'package:flutter/material.dart';

final class ProxyView extends StatelessWidget {
  final IWeatherService _weatherService = WeatherServiceProxy();

  ProxyView({super.key});

  Future<String> getWeatherFiveTimes() async {
    var results = [];

    for (var i = 0; i < 5; i++) {
      var data = await _weatherService.getWeatherData();
      results.add(data);
    }
    return results.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: getWeatherFiveTimes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
