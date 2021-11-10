import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_fav_model.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utilities/app_colors.dart';
import 'package:weather_app/utilities/app_text_style.dart';


void main() {
  runApp(
      ChangeNotifierProvider(create: (BuildContext context) => WeatherFavModel(),
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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const AppColors().backgroundGrey) ,
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              textStyle: MaterialStateProperty.all(const AppTextStyle().button),
              elevation: MaterialStateProperty.all(0),
              alignment: Alignment.center,
              fixedSize: MaterialStateProperty.all(const Size(200,20)),
            ),
          ),
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



