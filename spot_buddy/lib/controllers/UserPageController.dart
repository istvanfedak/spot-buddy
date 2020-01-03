import 'package:flutter/material.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/model/Model.dart';

class UserPageController {
  AuthService authService;
  final BuildContext context;
  final VoidCallback onSignedOut;

  UserPageController({this.context, this.onSignedOut}) {
    authService = Model.of(context).authService;
  }

  void signOut() async
  {
    try {
      await authService.signOut();
      onSignedOut();
      Navigator.pop(context);
    }
    catch (error) {
      print(error);
    }
  }
}