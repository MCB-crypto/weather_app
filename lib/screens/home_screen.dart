import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_model.dart';
import 'package:weather_app/utilities/helpers.dart';
import 'package:weather_app/widgets/add_to_favorites.dart';
import 'package:weather_app/widgets/favorite_dropdown.dart';
import 'package:weather_app/widgets/gradient_background.dart';
import 'package:weather_app/widgets/show_weather.dart';
import 'package:weather_app/widgets/status_bar.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = true;
  bool gpsButtonPressed=false;
  static const String prefKey = 'previousWeather';
  WeatherResponse? _selectedValue;
  WeatherResponse? _weatherRes;


  void _getFromSharedPrefs() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(prefKey)!=null) {
      _weatherRes =
          WeatherResponse.fromPrefJson(json.decode(pref.getString(prefKey)!));
    }
  }


  void _getPosition() async {
    final gpsPosition= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _weatherRes=WeatherResponse.empty();
    _selectedValue=null;
    gpsButtonPressed=true;
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
    return Consumer<WeatherModel>(builder:(context ,provider,__){
      return Stack(
        children: [
          const GradientBackground(),
          Column(children: [
            StatusBar(
              isConnected: isConnected,
            ),
            ((){
              return const  FavoriteDropdown();
            }()),
            SizedBox(
              height: Helpers(context).getScreenHeight()/7,
            ),
            (() {
              developer.log("reBuild");
              if (provider.selected!=null && gpsButtonPressed==false){
                _selectedValue=provider.selected;
              }
              if (_selectedValue != null) {
                return ShowWeather(
                    city: _selectedValue!.cityName!,
                    key: ObjectKey(_selectedValue)
                );
              } else if(_weatherRes != null){
                if(gpsButtonPressed==true) {
                  gpsButtonPressed=false;
                }
                return ShowWeather(
                    coord: (_weatherRes!.cityName ==null && _weatherRes!.coord !=null)?_weatherRes!.coord:null,
                    weatherRes: (_weatherRes!.cityName !=null && _weatherRes!.coord !=null)?_weatherRes!:null,
                    key: ObjectKey(_weatherRes)
                );
              }else{
                return Container();
              }
            }()),
            const AddToFavorites(),
            IconButton(onPressed: (){
              _getPosition();
            },
                icon: const Icon(Icons.gps_fixed)
            ),

          ]),
        ],
      );
    });
  }
}



