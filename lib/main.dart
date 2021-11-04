import 'package:flutter/material.dart';
import 'package:weather_app/providers/data_service.dart';
import 'package:weather_app/screens/weather_now.dart';
import 'models/weather_response.dart';

void main() {
  runApp(const MyWeatherApp());
}

class MyWeatherApp extends StatefulWidget {
  const MyWeatherApp({Key? key}) : super(key: key);

  @override
  State<MyWeatherApp> createState() => _MyWeatherAppState();
}

class _MyWeatherAppState extends State<MyWeatherApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home:  Scaffold(
            body: WeatherNow()
        )
    );
  }
  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (_response != null)
//                   Column(
//                     children: [
//                       Image.network(_response!.iconUrl),
//                       Text(
//                         '${_response!.temp.temperature}°C',
//                         style:  const TextStyle(fontSize: 40),
//                       ),
//                       Text(_response!.weather.description)
//                     ],
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 50),
//                   child: SizedBox(
//                     width: 150,
//                     child: TextField(
//                         controller: _cityTextController,
//                         decoration: const InputDecoration(labelText: 'City'),
//                         textAlign: TextAlign.center),
//                   ),
//                 ),
//                 ElevatedButton(onPressed: _search, child: const Text('Search'))
//               ],
//             ),
//           ),
//         ));
//   }
//   void _search() async {
//     final response = await _dataService.getWeather(_cityTextController.text);
//     setState(() => _response = response);
//   }
// }
