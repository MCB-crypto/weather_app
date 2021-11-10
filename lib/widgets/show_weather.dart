import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_fav_model.dart';
import 'package:weather_app/utilities/app_text_style.dart';
import 'package:weather_app/utilities/data_service.dart';
import 'dart:developer' as developer;
import 'package:cached_network_image/cached_network_image.dart';

class ShowWeather extends StatefulWidget {
  final String? city;
  final Coordinates? coord;
  final WeatherResponse? weatherRes;
  const ShowWeather({Key? key, this.city, this.weatherRes, this.coord}) : super(key: key);

  @override
  _ShowWeatherState createState() => _ShowWeatherState();
}


class _ShowWeatherState extends State<ShowWeather> {

  final _dataService = DataService();
  static const String prefKey = 'previousWeather';
  WeatherResponse? _response;
  bool isLoading=true;


  void _saveToJson() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonString =jsonEncode(_response!.toJson());

    pref.setString(prefKey, jsonString);

    Provider.of<WeatherFavModel>(context, listen: false).setShownItem(_response!);

    developer.log('Set to shared preferences: ' + pref.getString(prefKey)!);
  }

  void _searchByCity() async {
    setState(()=> isLoading=true);
    final response = await _dataService.getWeatherByCity(widget.city!);
    setState(() => _response = response);
    setState(()=> isLoading=false);
    _saveToJson();
  }

  void _searchByGps() async {
    setState(()=> isLoading=true);
    if (widget.coord !=null) {
      final response = await _dataService.getWeatherByGps(
          widget.coord!.lon.toString(),
          widget.coord!.lat.toString());
      setState(() => _response = response);
      setState(()=> isLoading=false);
      _saveToJson();
    }
  }

  @override
  void initState() {
    if (widget.city != null) {
      _searchByCity();
    } else if (widget.weatherRes != null) {
      _response = widget.weatherRes;
      Provider.of<WeatherFavModel>(context, listen: false).setShownItem(_response!);
      setState(()=> isLoading=false);
    } else if (widget.coord != null){
      _searchByGps();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (_response != null && isLoading==false)?Column(
              children: [
                Text(_response!.cityName!,style: const AppTextStyle().city,),
                CachedNetworkImage(
                  imageUrl: _response!.iconUrl,
                  placeholder: (context, url) => const SizedBox(height: 100,),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  '${_response!.temp!.temperature}°C',
                  style: const TextStyle(fontSize: 40),
                ),
                Text(_response!.weather!.description!)
              ],
            ):const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
