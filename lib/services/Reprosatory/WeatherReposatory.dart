import 'dart:convert';


import '../../response/weatherModel.dart';
import 'package:http/http.dart' as http;


class WeatherReposatory {

  Future<weatherModel> getWeather(double lat, double lon) async{

    http.Response response = await http.get(Uri.parse
      ('https://samples.openweathermap.org/data/2.5/weather?APPID=3c4c69da6c88fb3a4e020dadf91eb83d&'
        'lat=${lat}&lon=${lon}'));


    return weatherModel.fromJson(jsonDecode(response.body));

  }

  Future<weatherModel> getWeatherByCountryName(String q) async{

    http.Response response2 = await http.get(Uri.parse
      ('https://api.openweathermap.org/data/2.5/weather?q=${q}&APPID=3c4c69da6c88fb3a4e020dadf91eb83d'));

    return weatherModel.fromJson(jsonDecode(response2.body));

  }



}