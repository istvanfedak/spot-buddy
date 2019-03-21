import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

//GOOGLE MAPS NOT CONFIGURED FOR ANDROID YET

class Feed extends StatefulWidget{
  @override
  _Feed createState() => new _Feed();
}

class _Feed extends State<Feed> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);
  //need to pull this geolocation from the user, and hopefully show buddies around him

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
      appBar: new AppBar(
          title: new Text('Buddy Feed')
       ),
        //child: ListPage()
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      );
  }
}