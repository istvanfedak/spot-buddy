import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/UserPageController.dart';

class UserPage extends StatefulWidget {
  final UserPageController userPageController;
  UserPage({Key key, this.userPageController}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: widget.userPageController.signOut,
          ),
        ],
      ),
      body: Center(
        child:Text('User Info')
      ),
    );
  }
}