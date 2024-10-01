
import 'package:weather_flutter_application_15/model/weather.dart';

class WeatherData {
  final WeatherModel currentWeather;
  final List<WeatherModel> weeklyForecast;

  WeatherData({required this.currentWeather, required this.weeklyForecast});
}