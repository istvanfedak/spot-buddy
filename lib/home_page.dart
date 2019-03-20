import 'package:flutter/material.dart';
import 'AuthProvider.dart';
import 'feed.dart';
import 'auth.dart';
import 'update_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomePage extends StatefulWidget {
  HomePage({this.onSignOut,this.auth});
  final BaseAuth auth;
  final VoidCallback onSignOut;

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


  @override
  void initState(){
    feed = Feed();
    updateProf = updateProfile();
    currentPage = feed;
    currentTab = 0;
    pages = [feed,updateProf];

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

  void _signOut() async
  {
    try{
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
          title: new Text('Welcome', style: new TextStyle(fontSize: 20.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Logout', style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () => _signOut,
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
              icon: new Icon(Icons.calendar_today),
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
                onPressed: null
            ),
            title: Text('Matched Users'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.pink,
      ),
    );
  }
}