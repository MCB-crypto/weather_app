import 'package:weather_app/models/temperature.dart';
import 'package:weather_app/models/weather.dart';

class WeatherResponse{
  Temperature temp=Temperature(0);
  Weather weather=Weather('','');
  String cityName="";

  WeatherResponse(this.temp, this.weather, this.cityName);

  WeatherResponse.fromJson(Map<String, dynamic> json) {
     final tempJson = json['main'];
     temp = Temperature.fromJson(tempJson);

     final weatherJson = json['weather'][0];
     weather = Weather.fromJson(weatherJson);
  }

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weather.icon}@2x.png';
  }
}