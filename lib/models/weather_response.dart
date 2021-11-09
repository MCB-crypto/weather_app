import 'package:weather_app/models/coordinates.dart';
import 'temperature.dart';
import 'weather.dart';

class WeatherResponse{
  Temperature? temp;
  Weather? weather;
  String? cityName;
  Coordinates? coord;

  WeatherResponse.favWeather(this.cityName, this.coord);
  WeatherResponse.empty();
  WeatherResponse(this.coord,this.weather, this.temp, this.cityName);

  WeatherResponse.fromJson(Map<String, dynamic> json) {
     final tempJson = json['main'];
     temp = Temperature.fromJson(tempJson);

     final weatherJson = json['weather'][0];
     weather = Weather.fromJson(weatherJson);

     final coordJson=json['coord'];
     coord=Coordinates.fromJson(coordJson);

     cityName=json['name'];
  }

  Map<String, dynamic> toJson() => {
    "coord": coord!.toJson(),
    "weather": weather!.toJson(),
    "main": temp!.toJson(),
    "name": cityName,
  };

  Map<String, dynamic> toFavListJson() => {
    "coord": coord!.toJson(),
    "name": cityName,
  };

  factory WeatherResponse.fromFavListJson(Map<String, dynamic> json) => WeatherResponse.favWeather(
    json["name"],
    Coordinates.fromJson(json["coord"])
  );

  factory WeatherResponse.fromPrefJson(Map<String, dynamic> json) => WeatherResponse(
    Coordinates.fromJson(json["coord"]),
    Weather.fromJson(json['weather']),
    Temperature.fromJson(json["main"]),
    json["name"],
  );

  //temp weather cityname index

  // factory WeatherResponse.fromFavJson(Map<String, dynamic> parsedJson) {
  //   return WeatherResponse.favWeather(
  //       Temperature(parsedJson['temp']?? ""),
  //       Weather(parsedJson['description']?? "", parsedJson['icon']?? ""),
  //       parsedJson['cityName'] ?? "",
  //       parsedJson['index'] ?? "",
  //       Coordinates(parsedJson['lon']?? "", parsedJson['lat']?? ""));
  // }
  //
  // Map<String, dynamic> toFavJson() => {
  //   "index":index,
  //   "cityName": cityName,
  //   "temp": temp!.temperature,
  //   "description": weather!.description,
  //   "icon": weather!.icon,
  // };


  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weather!.icon}@2x.png';
  }
}