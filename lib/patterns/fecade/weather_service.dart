import 'package:design_patterns/patterns/fecade/model/weather.dart';

final class WeatherService {
  Future<Weather> getWeather() {
    return Future.value(Weather());
  }
}
