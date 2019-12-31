import 'package:flutter/material.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/model/Model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class HomePageController {
  GoogleMapController mapController;
  AuthService authService;
  final BuildContext context;
  final VoidCallback onSignedOut;

  HomePageController({this.context, this.onSignedOut}) {
    authService = Model.of(context).authService;
  }

  void signOut() async
  {
    try {
      await authService.signOut();
      onSignedOut();
    }
    catch (error) {
      print(error);
    }
  }

  final LatLng center = const LatLng(25.7617, -80.1918);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}