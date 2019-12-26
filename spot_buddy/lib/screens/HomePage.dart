
import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/HomePageController.dart';
import 'LoginPage.dart';

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
        centerTitle: true,
        
      ),
      body: Center(
        child: FlatButton(
          child: Text("Logout"),
          onPressed: widget.homePageController.signOut,
        ),
      ),
    );
  }
}
