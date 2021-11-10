import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_fav_model.dart';
import 'package:weather_app/utilities/helpers.dart';
import 'package:weather_app/widgets/add_to_favorites.dart';
import 'package:weather_app/widgets/favorite_dropdown.dart';
import 'package:weather_app/widgets/gradient_background.dart';
import 'package:weather_app/widgets/remove_from_favorites.dart';
import 'package:weather_app/widgets/show_weather.dart';
import 'package:weather_app/widgets/status_bar.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/weather_for_current_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = true;
  static const String prefKey = 'previousWeather';
  WeatherResponse? _selectedValue;
  //WeatherResponse? _weatherRes;


  void _getFromSharedPrefs() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(prefKey)!=null) {
      WeatherResponse _weatherRes =WeatherResponse.fromPrefJson(json.decode(pref.getString(prefKey)!));
      Provider.of<WeatherFavModel>(context, listen: false).setWeatherRes(_weatherRes);
    }
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
    return Consumer<WeatherFavModel>(builder:(context ,provider,__){
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
              height: Helpers(context).getScreenHeight()/10,
            ),
            SizedBox(
              height: Helpers(context).getScreenHeight() / 3,
              child:(() {
                developer.log("reBuild");

                WeatherResponse? _providerSelected=provider.selected;
                bool gpsButtonPressed=provider.gpsPressed;
                _selectedValue=_providerSelected;

                if (_selectedValue != null) {
                  developer.log('show weather of '+_selectedValue!.cityName!);
                  return ShowWeather(
                      city: _selectedValue!.cityName!,
                      key: ObjectKey(_selectedValue)
                  );
                } else if(provider.weatherRes != null){

                  if(gpsButtonPressed==true) {
                    gpsButtonPressed=false;
                  }

                  return ShowWeather(
                      coord: (provider.weatherRes!.cityName ==null && provider.weatherRes!.coord !=null)?provider.weatherRes!.coord:null,
                      weatherRes: (provider.weatherRes!.cityName !=null && provider.weatherRes!.coord !=null)?provider.weatherRes!:null,
                      key: ObjectKey(provider.weatherRes)
                  );
                }else{
                  return Container();
                }
              }()),
            ),
            const AddToFavorites(),
            const RemoveFromFavorites(),
            const WeatherForCurrentLocation(),
          ]),
        ],
      );
    });
  }
}





