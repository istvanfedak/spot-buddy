import 'package:flutter/material.dart';
import 'login_page.dart';
import 'globals.dart';



void main() {
  // logs that the app opened
  analytics.logAppOpen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(

        primarySwatch: appColor,
      ),
      home: new LoginPage(),
    );
  }
}

