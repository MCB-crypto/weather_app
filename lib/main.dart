import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_model.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utilities/app_colors.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => WeatherModel() ,
      child: const MyWeatherApp())
  );
}

class MyWeatherApp extends StatefulWidget {
  const MyWeatherApp({Key? key}) : super(key: key);

  @override
  State<MyWeatherApp> createState() => _MyWeatherAppState();
}

class _MyWeatherAppState extends State<MyWeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: const AppColors().weatherAppGrey,
          focusColor: const AppColors().weatherAppGrey,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Aktuelles Wetter"),
              backgroundColor: Colors.black38,
            ),
            body: const HomeScreen()
        )
    );
  }
}



