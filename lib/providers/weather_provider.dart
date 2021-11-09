import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_response.dart';

class WeatherProvider with ChangeNotifier{
  WeatherResponse? _weatherRes;

  WeatherResponse get weatherRes => _weatherRes!;

  void setSelectedItem(WeatherResponse s) {
    _weatherRes = s;
    notifyListeners();
  }
}