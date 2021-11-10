import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class WeatherFavModel extends ChangeNotifier{
  bool _gpsPressed=false;
  WeatherResponse? _selectedItem;
  WeatherResponse? _shownItem;
  WeatherResponse? _weatherRes;
  List<WeatherResponse> weatherFavs = [];


  //Build Favorites List
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

  //Get Favorites
  List<WeatherResponse> get items => weatherFavs;

  //Remove or add from/to Favorites
  Future<void> addItem(WeatherResponse s) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.getString(s.cityName!)==null)
    {
      weatherFavs.add(s);

      String jsonString =jsonEncode(s.toJson());
      pref.setString(s.cityName!, jsonString);

      notifyListeners();
    }
  }

  Future<void> removeItem(WeatherResponse s) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.getString(s.cityName!)!=null)
    {
      developer.log('remove: '+s.cityName!);

      for(WeatherResponse fav in weatherFavs ){
        if (fav.cityName==s.cityName)
        {
          weatherFavs.remove(fav);
          pref.remove(s.cityName!);
          _selectedItem=null;
          _weatherRes=null;
          notifyListeners();
          return;
        }
      }
    }

  }

  //WeatherRes
  void setWeatherRes(WeatherResponse? s) {
    _weatherRes = s;
    notifyListeners();
  }

  WeatherResponse? get weatherRes => _weatherRes;

  //Shown
  void setShownItem(WeatherResponse? s) {
    _shownItem = s;
  }

  WeatherResponse? get shown => _shownItem;

  //Gps Button pressed
  void setGpsTrue(){
    _gpsPressed=true;
  }

  bool get gpsPressed => _gpsPressed;

  //Selected
  void setSelectedItem(WeatherResponse? s) {
    _selectedItem = s;
    _gpsPressed=false;
    notifyListeners();
  }

  WeatherResponse? get selected => _selectedItem;


}