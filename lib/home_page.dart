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
  int currentTab;
  Widget currentPage;
  crudMethods crudObj = new crudMethods();

  setup() async {
    await crudObj.getInterest(globals.get_userID()); //this needs to be done again somehow when interests are updated
    await crudObj.getName(globals.get_userID());
    setState(() {
      currentTab = 0;
      currentPage = Matches();
    });
  }

  @override
  void initState(){
    super.initState();

    if (globals.uid != "") {
      setup();
    } //if uid can be found (or else major error trying to query firebase for document without uid key), set these user's interests globally

    else {
      _signOut(); } //else, to avoid error, if in homepage but uid cannot be found (empty), log user out and force to sign in again which will set the uid once again

  }


  void moveToFeed()
  {
    setState(() {
      currentPage = Feed();
      currentTab = 1;
    });

  }

  void moveToUpdate()
  {
    setState(() {
      currentPage = updateProfile();
      currentTab = 2;
    });

  }
  void moveToMatches()
  {
    setState(() {
      currentPage = Matches();
      currentTab = 0;
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
    if(currentPage == null) {
      return new Center(
          child: new CircularProgressIndicator() );
    } else {
      return Scaffold(
        appBar: new AppBar(
            title: new Text("Welcome", style: new TextStyle(fontSize: 20.0)),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: () => _signOut(),
              )
            ]
        ),
        body: currentPage,

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          /*
        onTap: (int index){
          setState(() {
            //print(index);
            //currentTab = index;
            //currentPage = Feed();
          });
        },
        */
          items: <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: new IconButton(
                  icon: new Icon(Icons.home),
                  iconSize: 40,
                  onPressed: moveToMatches
              ),
              title: Text('Find Buddies'),
            ),

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
                  icon: new Icon(Icons.update),
                  iconSize: 40,
                  onPressed: moveToUpdate
              ),
              title: Text('Update Profile'),
            ),

          ],
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
        ),
      );
    }
  }
}