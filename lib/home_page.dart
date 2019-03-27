import 'package:flutter/material.dart';
import 'AuthProvider.dart';
import 'feed.dart';
import 'auth.dart';
import 'update_profile.dart';
import 'matches2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'crud.dart';
import 'globals.dart' as globals;

class HomePage extends StatefulWidget {
  HomePage({this.onSignedOut,this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

/*
  void _signedOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e);
    }
  }*/

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int currentTab = 0;
  List<Widget> pages;
  Widget currentPage;
  Feed feed;
  updateProfile updateProf;
  Matches matches;
  crudMethods crudObj = new crudMethods();


  @override
  void initState(){
    feed = Feed();
    updateProf = updateProfile();
    matches = Matches();
    currentPage = feed;
    currentTab = 0;
    pages = [feed,updateProf,matches];
    if (globals.uid != "") {
    crudObj.getInterest(globals.get_userID()); }
    super.initState();
  }

  void moveToFeed()
  {
    setState(() {
      currentPage = feed;
      currentTab = 0;
    });

  }

  void moveToUpdate()
  {
    setState(() {
      currentPage = updateProf;
      currentTab = 1;
    });

  }
  void moveToMatches()
  {
    setState(() {
      currentPage = matches;
      currentTab = 2;
    });

  }

  void _signOut() async
  {
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
          title: new Text("Welcome", style: new TextStyle(fontSize: 20.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Logout', style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () => _signOut(),
            )
          ]
      ),
      body: currentPage,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index){
          setState(() {
            //print(index);
            currentTab = index;
            currentPage = feed;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new IconButton(
              icon: new Icon(Icons.accessibility),
              iconSize: 40,
              onPressed: moveToFeed,
            ),
            title: Text('Buddy Feed'),
          ),
          BottomNavigationBarItem(
            icon: new IconButton(
                icon: new Icon(Icons.local_taxi),
                iconSize: 40,
                onPressed: moveToUpdate
            ),
            title: Text('Update Profile'),
          ),
          BottomNavigationBarItem(
            icon: new IconButton(
                icon: new Icon(Icons.home),
                iconSize: 40,
                onPressed: moveToMatches
            ),
            title: Text('Matched Users'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
      ),
    );
  }
}