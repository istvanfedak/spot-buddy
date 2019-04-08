import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission/permission.dart';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'globals.dart' as globals;

//say you/me

//GOOGLE MAPS NOT CONFIGURED FOR ANDROID YET

//COULD EVENTUALLY MAKE IT THAT GOOGLE MAPS INITIAL CAMERA POSITION
//USES USERS LAST KNOWN LOCATION IN DATABASE SO ANIMATE TO USER IS
//NOT SO ABRUPT. (LAT/LON WOULD BE QUERIED FOR IN INITSTATE IF EXISTS)

class Matches extends StatefulWidget {
  @override
  _Matches createState() => new _Matches();
}

class _Matches extends State<Matches> {
  GoogleMapController mapController;
  Location location;

  Firestore firestore;
  Geoflutterfire geo;
  Geolocator geolocator;

  // Stateful Data
  BehaviorSubject<double> radius;
  Stream<dynamic> query;

  // Subscription
  StreamSubscription subscription;

  List<String> iList = new List(3);
  List<String> cList = new List(3);
  var newref;
  var zoom;




  @override
  initState() {
    super.initState();
    globals.remove = new List();
    location = new Location();
    firestore = Firestore.instance;
    geo = Geoflutterfire();
    geolocator = Geolocator();
    radius = BehaviorSubject(seedValue: 100.0);
    _checkGps();
    //_animateToUser(); ... initState was improper place (only once), needed to put in build where it is built(done) every time
    iList[0] = globals.getInterest1();
    iList[1] = globals.getInterest2();
    iList[2] = globals.getInterest3();
    newref = Firestore.instance.collection("locations");
    zoom = 12.0;
  }


  _checkGps() async {
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

  @override
  Widget build(BuildContext context) {
    //globals.remove = new List();
    _animateToUser();
    return Stack(children: [

      GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(24.142, -110.321),
            zoom: zoom
        ),
        onMapCreated: _onMapCreated,
        myLocationEnabled: false,
        mapType: MapType.normal,
        compassEnabled: true,
        trackCameraPosition: true,
      ),
      /*
      Positioned(
          bottom: 30,
          left: 5,
          child:
          FlatButton(
              child: Text('Find your buddies', style: new TextStyle(fontSize: 15.0, color: Colors.black)),
              color: Colors.green,
              onPressed: _animateToUser
          )
      ),
      */
      buildthis()
    ]);
  }

  buildthis() {
    return Positioned(
        top: 50,
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
    );
  }

  // Map Created Lifecycle Hook
  _onMapCreated(GoogleMapController controller) {
    _startQuery();
    setState(() {
      mapController = controller;
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

  _animateToUser() async {
    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: zoom,
        )
    )
    );
    _addGeoPoint(pos);
  }

  // Set GeoLocation Data
  Future<DocumentReference> _addGeoPoint(pos) async {
    //var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    if (Firestore.instance.collection('locations').document(globals.get_userID()).get() == null) {
      return firestore.collection('locations').add({
        'position': point.data,
        'uid': globals.get_userID()
      });
    }
    else {
      Firestore.instance.collection('locations').document(globals.get_userID()).setData({"position":point.data,
        "uid":globals.get_userID()});
    }
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print(globals.remove);
    print(documentList);
    mapController.clearMarkers();
    documentList.forEach((DocumentSnapshot document) async {
      var id = document.documentID;
      DocumentSnapshot doc = await Firestore.instance.collection("users").document(id).get();
      int index = 0;
      String markerPrint = doc.data['username'] + ": ";
      if(iList.contains(doc.data['interest1'])) {
        index++;
        markerPrint = markerPrint + doc.data['interest1'] + " "; //index.toString() + ":" + index.toString() + " ";
      }
      if(iList.contains(doc.data['interest2'])) {
        index++;
        markerPrint = markerPrint + doc.data['interest2'] + " "; //markerPrint + index.toString() + ":" + index.toString() + " ";
      }
      if(iList.contains(doc.data['interest3'])) {
        index++;
        markerPrint = markerPrint + doc.data['interest3']; //markerPrint + index.toString() + ":" + index.toString();
      }
      GeoPoint pos = document.data['position']['geopoint'];
      double distance = document.data['distance'];
      String distancePrint;
      if(document.documentID == globals.get_userID())
        {
          distancePrint = "You are here";
        }
        else {
            distancePrint = "$distance kilometers away from you";
        }
      var marker = MarkerOptions(
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindowText: InfoWindowText(markerPrint, distancePrint)
      );

      //mapController.addMarker(marker);

      if( !(globals.remove.contains(id)) ) {
      mapController.addMarker(marker); }

    });
  }

  _f(DocumentSnapshot d) async {
    String u = d.documentID;
    DocumentSnapshot document = await Firestore.instance.collection("users")
        .document(u)
        .get();

    if (iList.contains(document.data['interest1'])) {
      cList[0] = document.data['interest1'];
    }
    else {
      cList[0] = "none";
    }

    if (iList.contains(document.data['interest2'])) {
      cList[1] = document.data['interest2'];
    }
    else {
      cList[1] = "none";
    }

    if (iList.contains(document.data['interest3'])) {
      cList[2] = document.data['interest3'];
    }
    else {
      cList[2] = "none";
    }

    if (cList[0] == "none" && cList[1] == "none" && cList[2] == "none") {
      //newref.document(u).delete();
      globals.remove.add(u);
      print(globals.remove);
    }
  }


  _startQuery() async {
    // Get users location
    var pos = await location.getLocation();
    double lat = pos.latitude;
    double lng = pos.longitude;

    // Make a referece to firestore
    // NEED TO MAKE REF ONLY REFER TO THE COLLECTION OF LOCATIONS OF USERS WITH MATCHING INTERESTS
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);


    QuerySnapshot querySnapshot = await newref.getDocuments();
    var list = querySnapshot.documents;

    for(DocumentSnapshot d in list) {
     await _f(d);
    }
    _subscription(center);
  }

    _subscription(center) {
    // subscribe to query... will not use ref anymore, rather newref
    subscription = radius.switchMap((rad) {
      return geo.collection(collectionRef: newref).within(
          center: center,
          radius: rad,
          field: 'position',
          strictMode: true
      );
    }).listen(_updateMarkers); }


  _updateQuery(value) {
    final zoomMap = {
      100.0: 12.0,
      200.0: 10.0,
      300.0: 7.0,
      400.0: 6.0,
      500.0: 5.0
    };
    zoom = zoomMap[value];
    //mapController.moveCamera(CameraUpdate.zoomTo(zoom));

    //the setstate is causing a rebuild ...

    setState(() {
      radius.add(value);
    });

  }


  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

}
