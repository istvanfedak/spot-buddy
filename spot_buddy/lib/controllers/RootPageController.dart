import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/HomePageController.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/model/Model.dart';
import 'package:spot_buddy/screens/HomePage.dart';
import 'package:spot_buddy/screens/LoginPage.dart';
import 'package:spot_buddy/controllers/LoginPageController.dart';

// This is the root page controller of the application and it decides if
// the user is logged in or not
class RootPageController extends StatefulWidget {
  final BuildContext context;
  RootPageController({Key key, this.context}) : super(key: key);

  @override
  _RootPageControllerState createState() => _RootPageControllerState();
}

class _RootPageControllerState extends State<RootPageController> {
  AuthService _authService;
  bool _loggedIn = false;

  @override
  void initState() {
    _authService = Model.of(widget.context).authService;
    _authService.currentUser().then((uID) {
      setState(() {
        // sets the status to true if its not NULL
        _loggedIn = uID != null;
      });
    });
    super.initState();
  }

  void _signedIn() {
    setState(() {
      _loggedIn = true;
    });
  }

  void _signedOut() {
    setState(() {
      _loggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    // the page's controller decides wether to build the login page or home
    // page depending on what user is signed in 
    if(_loggedIn)
      return HomePage(
        homePageController: HomePageController(
          context: context,
          onSignedOut: _signedOut,
        ),
      );
    else
      return LoginPage(
        loginPageController: LoginPageController(
          context: context,
          onSignedIn: _signedIn,
        ),
      );
  }
}
