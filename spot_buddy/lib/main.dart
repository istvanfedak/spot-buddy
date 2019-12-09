import 'package:flutter/material.dart';
import 'screens/LoginPage.dart';
import 'package:spot_buddy/model/Model.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/services/ValidatorService.dart';

// flutter emulators --launch Pixel_3_API_29
// flutter run

void main() {
  runApp(Model(
    appName: "SpotBuddy",
    appColor: Colors.blue,
    authService: AuthService(),
    validatorService: ValidatorService(),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Model.of(context).appName,
      theme: ThemeData(
        primarySwatch: Model.of(context).appColor,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}

