import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/providers/data_service.dart';
import 'dart:developer' as developer;


class Favorite extends StatefulWidget {
  final String location;

  const Favorite({Key? key, required this.location}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final _dataService = DataService();

  WeatherResponse? _response;

  void _search() async {
    final response =
        await _dataService.getWeather(widget.location);
    setState(() => _response = response);
    developer.log(widget.location);

  }

  @override
  void initState(){
    _search();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (_response != null) ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 20,
                  children: [
                    Image.network(_response!.iconUrl,height: 70,),
                    Column(
                      children: [
                        Text(
                          '${_response!.temp.temperature}°C',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(_response!.weather.description)
                      ],
                    ),
                    Text(widget.location,
                        style: const TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,

                      ),

                  ],
                )
              ],
            )
          :  const Text("Ups, something went wrong."),
    );
  }
}
