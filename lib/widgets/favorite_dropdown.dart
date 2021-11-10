import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_fav_model.dart';
import 'package:weather_app/utilities/app_text_style.dart';

class FavoriteDropdown extends StatefulWidget {
  const FavoriteDropdown({Key? key}) : super(key: key);

  @override
  State<FavoriteDropdown> createState() => _FavoriteDropdownState();
}

class _FavoriteDropdownState extends State<FavoriteDropdown> {
  WeatherResponse? _selectedValue;
  List<WeatherResponse>? favList;

  @override
  void initState() {
    favList=Provider.of<WeatherFavModel>(context,listen: false ).items;
    if(favList!.isEmpty)
    {Provider.of<WeatherFavModel>(context, listen: false).loadWeatherFavorites();}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherFavModel>(builder: (context,provider,__){
      return Column(
        children: [
          Text("Favoriten:",style: const AppTextStyle().headline,),
          const SizedBox(
            height: 10,
          ),
          DropdownButton<WeatherResponse>(
             key: ObjectKey(provider.items),
            value: provider.selected,
            onChanged: (WeatherResponse? newValue) {
              provider.setSelectedItem(newValue!);
              setState(() {
                _selectedValue = newValue;
              });
            },
            items: provider.items.map<DropdownMenuItem<WeatherResponse>>(
                    (WeatherResponse value) {
                  return DropdownMenuItem<WeatherResponse>(
                    value: value,
                    child: Text(value.cityName!),
                  );
                }).toList(),
          ),
        ],
      );
    });
  }
}


