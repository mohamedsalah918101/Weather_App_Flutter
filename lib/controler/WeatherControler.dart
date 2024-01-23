import 'dart:convert';

import 'package:api_flutter/response/weatherModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherControler extends GetxController{
  var weatherText = "".obs;
  var WeatherModel = weatherModel().obs;
  var WeatherModelByCountry = weatherModel().obs;

   getWeather(double lat, double lon) async{

    http.Response response = await http.get(Uri.parse
      ('https://samples.openweathermap.org/data/2.5/weather?APPID=3c4c69da6c88fb3a4e020dadf91eb83d&'
        'lat=${lat}&lon=${lon}'));

    WeatherModel.value = weatherModel.fromJson(jsonDecode(response.body));
    print("Weather Text detail ${WeatherModel.value}");
    update();
  }

  getWeatherByCountryName(String q) async{

    http.Response response2 = await http.get(Uri.parse
      ('https://api.openweathermap.org/data/2.5/weather?q=${q}&APPID=3c4c69da6c88fb3a4e020dadf91eb83d'));

    WeatherModelByCountry.value = weatherModel.fromJson(jsonDecode(response2.body));
    update();

  }
}