
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  // gets called every time a stateful widget it created
  // before the build method is called
  // opportunity to configure initial state of widget
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
       // if(userId == null)
          //authStatus = AuthStatus.notSignedIn;
       // else
          //authStatus = AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Scaffold(
          body: Container(
              child: Text('Welcome'),
            ),
        );
    }
  }
}