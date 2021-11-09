import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherModel extends ChangeNotifier{
  WeatherResponse? _selectedItem;
  WeatherResponse? _shownItem;
  List<WeatherResponse> weatherFavs = [];


  Future<void> _initFavs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final WeatherResponse weatherFav1 =
    WeatherResponse.favWeather("Wien", Coordinates(14.3053, 46.6247));
    final WeatherResponse weatherFav2 =
    WeatherResponse.favWeather("Rom", Coordinates(12.4839, 41.8947));
    final WeatherResponse weatherFav3 =
    WeatherResponse.favWeather("Berlin", Coordinates(13.4105, 52.5244));
    final WeatherResponse weatherFav4 =
    WeatherResponse.favWeather("Bern", Coordinates(7.4474, 46.9481));

    weatherFavs.add(weatherFav1);
    weatherFavs.add(weatherFav2);
    weatherFavs.add(weatherFav3);
    weatherFavs.add(weatherFav4);

    for(WeatherResponse weatherFav in weatherFavs){
      String jsonString =jsonEncode(weatherFav.toFavListJson());
      pref.setString(weatherFav.cityName!, jsonString);
    }
  }


  List<WeatherResponse> get items => weatherFavs;

  WeatherResponse? get selected => _selectedItem;

  WeatherResponse? get shown => _shownItem;


  Future<void> loadWeatherFavorites() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String prefKey = 'previousWeather';
    Set<String> keys=pref.getKeys();
    if (keys.length<=1){
      _initFavs();
    }else{
      for(var key in keys){
        if (key!=prefKey){
          WeatherResponse weatherRes=WeatherResponse.fromFavListJson(json.decode(pref.getString(key)!));
          weatherFavs.add(weatherRes);
        }
    }
    }

    notifyListeners();
  }

  Future<void> addItem(WeatherResponse s) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.getString(s.cityName!)==null)
      {
        weatherFavs.add(s);

        String jsonString =jsonEncode(s.toJson());
        pref.setString(s.cityName!, jsonString);
      }

  }

  void setShownItem(WeatherResponse? s) {
    _shownItem = s;

  }

  void setSelectedItem(WeatherResponse? s) {
    _selectedItem = s;
    notifyListeners();
  }

}