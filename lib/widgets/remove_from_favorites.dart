import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_fav_model.dart';
import 'custom_button.dart';


class RemoveFromFavorites extends StatelessWidget {
  const RemoveFromFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherResponse? _shownWeather;
    return  ElevatedButton(
        onPressed: (){
          _shownWeather=Provider.of<WeatherFavModel>(context, listen: false).shown;
          if (_shownWeather!=null) {
            Provider.of<WeatherFavModel>(context, listen: false).removeItem(
                _shownWeather!);
          }
        },
        child:const CustomButton(
          text: "Entfernen",
        icon: Icon(Icons.star_rounded,color: Colors.black),)
    );
  }
}

