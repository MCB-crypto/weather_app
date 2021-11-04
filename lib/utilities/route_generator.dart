import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_now.dart';
import 'package:weather_app/screens/weather_sixteen_days.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WeatherNow());
      case '/16days':
        return MaterialPageRoute(builder: (_) => WeatherSixteenDays());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}



// case '/devices':
// // Validation of correct data type
//   if (args is String) {
//     return MaterialPageRoute(builder: (_) => Devices(),
//
//);
//}
// If args is not of the correct type, return an error page.
// You can also throw an exception while in development.
//return _errorRoute();