import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:firebase/firebase.dart';
// flutter emulators --launch Pixel_3_API_29
// flutter run

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}

