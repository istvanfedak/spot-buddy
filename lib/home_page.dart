import 'package:flutter/material.dart';
import 'AuthProvider.dart';

class HomePage extends StatelessWidget {
  HomePage({this.onSignOut});
  final VoidCallback onSignOut;

  void _signedOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
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
            onPressed: () => _signedOut(context),
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