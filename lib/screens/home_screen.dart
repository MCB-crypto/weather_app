import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/widgets/gradient_background.dart';
import 'package:weather_app/widgets/show_weather.dart';
import 'package:weather_app/widgets/status_bar.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = true;
  static const String prefKey = 'previousWeather';
  WeatherResponse? _selectedValue;
  WeatherResponse? _weatherRes;

  final WeatherResponse weatherFav1 =
  WeatherResponse("Wien", Coordinates(14.3053, 46.6247));
  final WeatherResponse weatherFav2 =
  WeatherResponse("Rom", Coordinates(12.4839, 41.8947));
  final WeatherResponse weatherFav3 =
  WeatherResponse("Berlin", Coordinates(13.4105, 52.5244));
  final WeatherResponse weatherFav4 =
  WeatherResponse("Bern", Coordinates(7.4474, 46.9481));
  List<WeatherResponse> weatherFavs = [];



  void _addFavs() {
    weatherFavs.add(weatherFav1);
    weatherFavs.add(weatherFav2);
    weatherFavs.add(weatherFav3);
    weatherFavs.add(weatherFav4);
  }

  void _getFromSharedPrefs() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(prefKey)!=null) {
      _weatherRes =
          WeatherResponse.fromFavJson(json.decode(pref.getString(prefKey)!));
    }
  }


  void _getPosition() async {
    final gpsPosition= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _weatherRes=WeatherResponse.empty();
    _selectedValue=null;
    setState(() {
      _weatherRes!.coord=Coordinates(gpsPosition.longitude,gpsPosition.latitude);
    });
    developer.log('Current Position '+_weatherRes!.coord.toString());
  }


  void _getConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConnected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    } else if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
    }
    setState(() {
    });
  }

  @override
  void initState() {
    developer.log("initState");
    _getFromSharedPrefs();
    _addFavs();
    _getConnectivity();
    StreamSubscription subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _getConnectivity();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientBackground(),
        Column(children: [
          StatusBar(
            isConnected: isConnected,
          ),
          DropdownButton<WeatherResponse>(
            value: _selectedValue,
            onChanged: (WeatherResponse? newValue) {
              setState(() {
                _selectedValue = newValue;
              });
            },
            items: weatherFavs.map<DropdownMenuItem<WeatherResponse>>(
                    (WeatherResponse value) {
                  return DropdownMenuItem<WeatherResponse>(
                    value: value,
                    child: Text(value.cityName!),
                  );
                }).toList(),
          ),
          (() {
            if (_selectedValue != null) {
              return ShowWeather(
                  city: _selectedValue!.cityName!,
                  key: ObjectKey(_selectedValue)
              );
            } else if(_weatherRes != null){
              return ShowWeather(
                  coord: (_weatherRes!.cityName ==null && _weatherRes!.coord !=null)?_weatherRes!.coord:null,
                  weatherRes: (_weatherRes!.cityName !=null && _weatherRes!.coord !=null)?_weatherRes!:null,
                  key: ObjectKey(_weatherRes)
                  );
            }else{
              return Container();
            }
          }()),
          IconButton(onPressed: (){
            _getPosition();
          },
              icon: const Icon(Icons.gps_fixed)
          ),
        ]),
      ],
    );
  }
}
