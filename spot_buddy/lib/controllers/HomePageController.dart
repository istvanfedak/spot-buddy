import 'package:flutter/material.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/model/Model.dart';



class HomePageController {
  AuthService authService;
  final BuildContext context;
  final VoidCallback onSignedOut;

  HomePageController({this.context, this.onSignedOut}) {
    authService = Model.of(context).authService;
  }

  void signOut() async
  {
    try {
      await authService.signOut();
      onSignedOut();
    }
    catch (error) {
      print(error);
    }
  }
}