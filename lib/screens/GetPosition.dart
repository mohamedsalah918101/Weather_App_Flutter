import 'dart:convert';

import 'package:api_flutter/controler/WeatherControler.dart';
import 'package:api_flutter/response/weatherModel.dart';
import 'package:api_flutter/screens/MapPage.dart';
import 'package:api_flutter/screens/WeatherPage.dart';
import 'package:api_flutter/services/Reprosatory/WeatherReposatory.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GetPosition extends StatelessWidget{
  final WeatherControler controler = Get.put(WeatherControler());
  @override
  Widget build(BuildContext context) {
    getPosition();
    return GetBuilder<WeatherControler>(
      builder: (val){
        return Column(
          children: [
            Container(
              child: Text(
                val.WeatherModel.value.main!.temp.toString()
              ),
            ),
            TextButton(onPressed: () {
              controler.weatherText.value = 'good';
              controler.WeatherModel.refresh();
            }, child: Text(
              val.WeatherModel.value.weather![0].description.toString(),
            ))
          ],
        );
      },
    ); Column(
      children: [
        Container(
          child: Obx(() {
            return Text(
                controler.WeatherModel.value.toString()
            );
          }),

          // SpinKitDoubleBounce(
          //   color: Colors.white,  // Change the color as needed
          //   size: 80.0,          // Adjust the size as needed
          // ),
        ),

      ],
    );

  }

  getPosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position.latitude.toString() + " --------- "+ position.longitude.toString());
    controler.getWeather(position.latitude, position.longitude);
    // Get.offAll(page)
    // Get.back()
    // Get.off(page)
    await Get.to(MapPage(latLng: LatLng(position.latitude, position.longitude),));

    //Call API

    // var response = await WeatherReposatory().getWeather(position.latitude, position.longitude);
    //
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) =>  WeatherPage(responseModel: response, )),
    // );

    // print(weatherModel.fromJson(decodeData).coord!.lat);
    // print("response ${response.body}");
  }

}