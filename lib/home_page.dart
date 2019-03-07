import 'package:flutter/material.dart';
import 'auth.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  void _signedOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.white
              ),
            ),
            onPressed: _signedOut,
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            'Welcome',
            style: TextStyle(
              fontSize: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}