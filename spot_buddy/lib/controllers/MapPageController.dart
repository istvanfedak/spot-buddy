import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageController {
  GoogleMapController mapController;

  final LatLng center = const LatLng(25.7617, -80.1918);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}