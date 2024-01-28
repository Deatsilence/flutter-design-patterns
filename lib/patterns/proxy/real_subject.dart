// Real Subject
import 'package:design_patterns/patterns/proxy/subject_interface.dart';

class WeatherApiService implements IWeatherService {
  @override
  Future<String> getWeatherData() async {
    // Uzak API'den hava durumu verisi çek
    return 'Sunny, 25°C';
  }
}
