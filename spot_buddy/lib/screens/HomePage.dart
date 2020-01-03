
import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/HomePageController.dart';
import 'package:spot_buddy/screens/MapPage.dart';


class HomePage extends StatefulWidget {
  final HomePageController homePageController;
  HomePage({Key key, this.homePageController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  void onTabTapped(int index) {
    setState(() {
      if(index == 0)
        widget.homePageController.pushMessagingPage();
      else if(index == 2) 
        widget.homePageController.pushDiscoveryPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 130.0),
        child: FloatingActionButton(
          onPressed: widget.homePageController.pushUserPage,
          tooltip: 'Logout',
          child: Icon(Icons.person), // person account_cirlce
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      
      body: MapPage(),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTabTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Discover'),
          ),
        ],
        currentIndex: widget.homePageController.getIndex(),
        selectedItemColor: Colors.lightBlue,
      ),
    );
  }
}
