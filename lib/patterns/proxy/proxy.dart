import 'package:design_patterns/patterns/proxy/real_subject.dart';
import 'package:design_patterns/patterns/proxy/subject_interface.dart';

class WeatherServiceProxy implements IWeatherService {
  final WeatherApiService _weatherApiService = WeatherApiService();
  String? _cachedData;

  @override
  Future<String?> getWeatherData() async {
    if (_cachedData == null) {
      print('Fetching data from API...');
      _cachedData = await _weatherApiService.getWeatherData();
    } else {
      print('Returning cached data...');
    }
    return _cachedData;
  }
}
