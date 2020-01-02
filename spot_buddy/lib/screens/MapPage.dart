
import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/MapPageController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapPageController _controller = MapPageController();
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomGesturesEnabled: true,
      onMapCreated: _controller.onMapCreated,
      initialCameraPosition: CameraPosition(
        target:  _controller.center,
        zoom: 11.0,
      ),
    );
  }
}
