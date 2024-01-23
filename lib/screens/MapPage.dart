import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget{
  LatLng? latLng;
  MapPage({this.latLng});
  @override
  State<MapPage> createState() {
    return MapPageState();
  }

}

class MapPageState extends State<MapPage>{

  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: widget.latLng!,
        ),
        myLocationEnabled: true,
      ),
    );
  }
  
}