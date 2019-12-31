
import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/HomePageController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  final HomePageController homePageController;
  HomePage({Key key, this.homePageController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontSize: 30.0),
        ),
        // centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: widget.homePageController.signOut,
          ),
        ],
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        onMapCreated: widget.homePageController.onMapCreated,
        initialCameraPosition: CameraPosition(
          target:  widget.homePageController.center,
          zoom: 11.0,
        ),
      ),
      
    );
  }
}
