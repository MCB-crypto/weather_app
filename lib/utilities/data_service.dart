import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_response.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:developer' as developer;

import 'package:weather_app/utilities/custom_app_exeptions.dart';



class DataService {
  String appId='528f79055d050cb36c60b103dfc4a2c0';

  Future<dynamic> getWeatherByCity(String city) async {
    final queryParameters={'q':city,'appid':'528f79055d050cb36c60b103dfc4a2c0', 'units': 'metric','lang':'de'};
    final uri=Uri.https('api.openweathermap.org', 'data/2.5/weather', queryParameters);
    var responseJson;
    developer.log("getWeatherByCity: "+city);

    try{
      final response=await http.get(uri);
      responseJson=_returnResponse(response);

      log(response.statusCode.toString());
      log(response.body.toString());

    } on SocketException{
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
    //final json = jsonDecode(response.body);
    //return WeatherResponse.fromJson(json);
  }

  Future<WeatherResponse> getWeatherByGps(String lon,String lat) async {
    final queryParameters={'lat':lat,'lon':lon,'appid':'528f79055d050cb36c60b103dfc4a2c0', 'units': 'metric','lang':'de'};
    final uri=Uri.https('api.openweathermap.org', 'data/2.5/weather', queryParameters);

    var responseJson;

    try{

      final response=await http.get(uri);
      responseJson=_returnResponse(response);

      log(response.statusCode.toString());
      log("try"+response.body);

    } on SocketException{
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
    // final json = jsonDecode(response.body);
    // return WeatherResponse.fromJson(json);
  }


  dynamic _returnResponse(http.Response response) {
    developer.log("ReturnResponse"+response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body);
        return WeatherResponse.fromJson(json);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}