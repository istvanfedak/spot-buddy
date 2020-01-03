import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot_buddy/screens/DiscoveryPage.dart';
import 'package:spot_buddy/screens/MessagingPage.dart';
import 'package:spot_buddy/screens/UserPage.dart';
import 'package:spot_buddy/controllers/UserPageController.dart';

class HomePageController {
  GoogleMapController mapController;
  final BuildContext context;
  final VoidCallback onSignedOut;
  int _index;

  HomePageController({this.context, this.onSignedOut}) {
    _index = 1;
  }

  void pushDiscoveryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiscoveryPage()),
    );
  }

  void pushMessagingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessagingPage()),
    );
  }

  void pushUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserPage(
        userPageController: UserPageController(
          context: context,
          onSignedOut: onSignedOut,
        ),
      )),
    );
  }

  void setIndex(int index) => _index = index;

  int getIndex() => _index;

  final LatLng center = const LatLng(25.7617, -80.1918);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}