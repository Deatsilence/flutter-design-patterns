import 'package:design_patterns/patterns/fecade/model/news.dart';
import 'package:design_patterns/patterns/fecade/model/user_profile.dart';
import 'package:design_patterns/patterns/fecade/model/weather.dart';
import 'package:design_patterns/patterns/fecade/news_service.dart';
import 'package:design_patterns/patterns/fecade/user_profile_service.dart';
import 'package:design_patterns/patterns/fecade/weather_service.dart';

final class ApiFacadeService {
  final WeatherService _weatherService = WeatherService();
  final NewsService _newsService = NewsService();
  final UserProfileService _userProfileService = UserProfileService();

  Future<Weather> getWeather() => _weatherService.getWeather();
  Future<List<News>> getNews() => _newsService.getLatestNews();
  Future<UserProfile> getUserProfile() => _userProfileService.getUserProfile();
}
