import 'package:flutter/material.dart';
import 'globals.dart';
import 'auth.dart';
import 'auth.dart';
import 'root_page.dart';
import 'AuthProvider.dart';



void main() {
  // logs that the app opened
  analytics.logAppOpen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: appName,
        theme: ThemeData(

          primarySwatch: appColor,
        ),
        home: new RootPage(auth: new Auth()),
      ),
    );
  }
}

