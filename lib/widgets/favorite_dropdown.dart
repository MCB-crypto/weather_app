import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/weather_model.dart';
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
    favList=Provider.of<WeatherModel>(context, listen: false).items;
    if(favList!.isEmpty)
    {Provider.of<WeatherModel>(context, listen: false).loadWeatherFavorites();}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherModel>(builder: (context,provider,__){
      return Column(
        children: [
          Text("Favoriten:",style: const AppTextStyle().headline,),
          const SizedBox(
            height: 10,
          ),
          DropdownButton<WeatherResponse>(
            value: _selectedValue,
            onChanged: (WeatherResponse? newValue) {
              //Provider.of<WeatherModel>(context, listen: false).setSelectedItem(newValue!);
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


