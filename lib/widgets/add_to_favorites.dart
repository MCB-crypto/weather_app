import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_model.dart';

class AddToFavorites extends StatefulWidget {
  const AddToFavorites({Key? key}) : super(key: key);

  @override
  _AddToFavoritesState createState() => _AddToFavoritesState();
}

class _AddToFavoritesState extends State<AddToFavorites> {
  WeatherResponse? _shownWeather;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      _shownWeather=Provider.of<WeatherModel>(context, listen: false).shown;
      Provider.of<WeatherModel>(context, listen: false).addItem(_shownWeather!);
    }, 
        icon: const Icon(Icons.star),
    splashColor: Colors.amber,);
  }
}
