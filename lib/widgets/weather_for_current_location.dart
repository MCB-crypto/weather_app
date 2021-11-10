import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_fav_model.dart';
import 'custom_button.dart';

class WeatherForCurrentLocation extends StatefulWidget {
  const WeatherForCurrentLocation({Key? key}) : super(key: key);

  @override
  State<WeatherForCurrentLocation> createState() => _WeatherForCurrentLocationState();
}

class _WeatherForCurrentLocationState extends State<WeatherForCurrentLocation> {

  void _getPosition() async {
    final gpsPosition= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    WeatherResponse _weatherRes=WeatherResponse.empty();
    _weatherRes.coord=Coordinates(gpsPosition.longitude,gpsPosition.latitude);
    Provider.of<WeatherFavModel>(context, listen: false).setSelectedItem(null);
    Provider.of<WeatherFavModel>(context, listen: false).setGpsTrue();
    Provider.of<WeatherFavModel>(context, listen: false).setWeatherRes(_weatherRes);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          _getPosition();
        },
        child:const CustomButton(
          text: "Lokales Wetter",
          icon: Icon(Icons.gps_fixed,color: Colors.black),)
    );
  }
}
