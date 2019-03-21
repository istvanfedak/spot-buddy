import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'auth.dart';
import 'AuthProvider.dart';

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

  // alternative to initState when you are inheriting and
  // did change dependencies
  /*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((userId){
      setState(() {
         if(userId == null)
         authStatus = AuthStatus.notSignedIn;
         else
         authStatus = AuthStatus.signedIn;
      });
    });
  }
*/
  // gets called every time a stateful widget it created
  // before the build method is called
  // opportunity to configure initial state of widget

  @override
  void initState() {
    super.initState();
    try {
      widget.auth.currentUser().then((userId) { //I've removed the 'widget.'
        setState(() {
          authStatus =
          userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
      });
    } catch (e) {}
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth:widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth:widget.auth,
          onSignOut: _signedOut,
        );
    }
  }
}
