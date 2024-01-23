
import 'package:api_flutter/response/weatherModel.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '../services/Reprosatory/WeatherReposatory.dart';

class WeatherPage extends StatefulWidget{
  weatherModel responseModel;
  WeatherPage({required this.responseModel});

  @override
  State<WeatherPage> createState() {
    return WeatherPageState();
  }
  // Task E-Commerce App

}
class WeatherPageState extends State<WeatherPage>{

  @override
  void initState() {
    mainIcon();
    getSeason();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/weather.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.dstATop),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              mainIcon()!,
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            SizedBox(height: 10,),
            Text(
              widget.responseModel.main!.temp.toString(),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 10,),
            Text(
              getSeason()!,
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              showCountryPicker(
                context: context,
                countryListTheme: CountryListThemeData(
                  flagSize: 25,
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  bottomSheetHeight: 500, // Optional. Country list modal height
                  //Optional. Sets the border radius for the bottomsheet.
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  //Optional. Styles the search field.
                  inputDecoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Start typing to search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                onSelect: (Country country) async {

                  weatherModel response = await WeatherReposatory().getWeatherByCountryName(country.name);
                  widget.responseModel=response;
                  setState(() {

                  });

                }
              );

            }, child: Text(
              "Choose Country"
            ))

          ]
        ),
      ),
    );
  }

     String? mainIcon()  {
     if(widget.responseModel.weather?[0].main == 'Clear'){
      return "☀️";
    } else if (widget.responseModel.weather?[0].main == 'Clouds'){
       return "☁️";
     } else if(widget.responseModel.weather?[0].main == 'Rain') {
       return "🌨️";
     }
     return null;

  }

  String? getSeason() {
    if(widget.responseModel.main!.temp < 300){
        return "Winter 🧥";
    } else if(widget.responseModel.main!.temp > 300) {
      return "Summer 🏖️";
    }
    return null;
  }

}