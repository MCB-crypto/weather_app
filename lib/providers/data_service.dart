import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_response.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    String appId='528f79055d050cb36c60b103dfc4a2c0';
    final queryParameters={'q':city,'appid':'528f79055d050cb36c60b103dfc4a2c0', 'units': 'metric'};
    final uri=Uri.https('api.openweathermap.org', 'data/2.5/weather', queryParameters);
    //var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=London&appid=528f79055d050cb36c60b103dfc4a2c0');
    final response=await http.get(uri);
    log(response.statusCode.toString());
    log(response.body);


    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}