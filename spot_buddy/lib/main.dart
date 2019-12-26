import 'package:flutter/material.dart';
import 'package:spot_buddy/model/Model.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/services/ValidatorService.dart';
import 'package:spot_buddy/controllers/RootPageController.dart';
// flutter emulators --launch Pixel_3_API_29
// flutter run

// main entry point to the program
void main() {
  runApp(
    // The class that contains the model of the app
    Model(
    appName: "SpotBuddy",
    appColor: Colors.blue,
    authService: AuthService(),
    validatorService: ValidatorService(),
    child: App(),
  ));
}

// Root widget of the application
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Model.of(context).appName,
      theme: ThemeData(
        primarySwatch: Model.of(context).appColor,
      ),
      home: RootPageController(context: context,),
    );
  }
}

