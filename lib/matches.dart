import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:permission/permission.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rxdart/rxdart.dart';


//GOOGLE MAPS NOT CONFIGURED FOR ANDROID YET

class Matches extends StatefulWidget{
  @override
  _Matches createState() => new _Matches();
}

class _Matches extends State<Matches> {

  List<Position> positions = [];
  StreamSubscription<Position> streamSubscription;
  //bool trackLocation;


  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  //Position _position;

  Location location = new Location();

  GoogleMapController mapController;


  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  BehaviorSubject<double> radius = BehaviorSubject(seedValue: 100.0);
  Stream<dynamic> query;
  StreamSubscription subscription;


  @override
  initState() {
    super.initState();
    checkGps();

    //trackLocation = true;
    //positions = [];

    //getLocations();
  }

  checkGps() async {
    GeolocationStatus geolocationStatus  = await geolocator.checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted) {
      print("Success, user permission granted");
    } else {
      while (geolocationStatus != GeolocationStatus.granted) {
        print("Failed, will ask user for permission");
        PermissionStatus permissionStatus = await Permission
            .requestSinglePermission(PermissionName.Location);
      }
    }
  }

  _animateToUser() async {
    var pos = await location.getLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude,pos.longitude),
          zoom: 17.0,
        )
    )
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }



Future<DocumentReference> _addGeoPoint() async {
  var pos = await location.getLocation();
  GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
  return firestore.collection('locations').add({
    'position': point.data,
    'name': 'Yay I can be queried!'
  });
}

  _addMarker() {
    var marker = MarkerOptions(
        position: mapController.cameraPosition.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText: InfoWindowText('Magic Marker', '🍄🍄🍄')
    );

    mapController.addMarker(marker);
  }


  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print(documentList);
    mapController.clearMarkers();
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['position']['geopoint'];
      double distance = document.data['distance'];
      var marker = MarkerOptions(
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindowText: InfoWindowText('Magic Marker', '$distance kilometers from query center')
      );


      mapController.addMarker(marker);
    });
  }



  _startQuery() async {
    // Get users location
    var pos = await location.getLocation();
    double lat = pos.latitude;
    double lng = pos.longitude;


    // Make a referece to firestore
    var ref = firestore.collection('locations');
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);

    // subscribe to query
    subscription = radius.switchMap((rad) {
      return geo.collection(collectionRef: ref).within(
          center: center,
          radius: rad,
          field: 'position',
          strictMode: true
      );
    }).listen(_updateMarkers);
  }

  _updateQuery(value) {
    setState(() {
      radius.add(value);
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

/*
  getLocations() {

    streamSubscription = geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          positions.add(position);
        });

  }

  getLatLng() {
    if (positions.isNotEmpty) {
      LatLng result = LatLng(positions.last.latitude, positions.last.longitude);
      return result;
    }
    else {
      getLocations();
      LatLng result = LatLng(positions.first.latitude, positions.first.longitude);
      return result;
    }
  }
*/


    /*
  getLocations() {
    if (trackLocation) {
      setState(() => trackLocation = false);
      streamSubscription.cancel();
      streamSubscription = null;
    } else {
      setState(() => trackLocation = true);

      streamSubscription = geolocator.getPositionStream(locationOptions).listen(
              (Position position) {
            print(position == null ? 'Unknown' : position.latitude.toString() +
                ', ' + position.longitude.toString());
            setState(() {
              positions.add(position);
            });
          });

      streamSubscription.onDone(() => setState(() {
        trackLocation = false;

      }));
    }
  }
*/


    Completer<GoogleMapController> _controller = Completer();

    static const LatLng _center = const LatLng(45.521563, -122.677433);
    //need to pull this geolocation from the user, and hopefully show buddies around him

  /*
    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }
*/


  /*
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Temporary Map'),
          actions: <Widget>[
            FlatButton(
              child: Text("Get Location"),
              //onPressed: 
            )

          ],
        ),
        //child: ListPage()
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 10),
            myLocationEnabled: true,
            trackCameraPosition: true,
            mapType: MapType.normal
        ),




      );

    }
    */

  build(context) {
    return Stack(children: [

      GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(24.142, -110.321),
            zoom: 15
        ),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        mapType: MapType.normal,
        compassEnabled: true,
        trackCameraPosition: true,
      ),
      Positioned(
          bottom: 50,
          right: 10,
          child:
          FlatButton(
              child: Icon(Icons.pin_drop, color: Colors.white),
              color: Colors.green,
              onPressed: _addGeoPoint
          )
      ),
      Positioned(
          bottom: 50,
          left: 10,
          child: Slider(
            min: 100.0,
            max: 500.0,
            divisions: 4,
            value: radius.value,
            label: 'Radius ${radius.value}km',
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.2),
            onChanged: _updateQuery,
          )
      )
    ]);
  }
  }
