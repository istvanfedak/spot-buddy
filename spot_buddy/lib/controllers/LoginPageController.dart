import 'package:flutter/material.dart';
import 'package:spot_buddy/services/AuthService.dart';
import 'package:spot_buddy/services/ValidatorService.dart';
import 'package:spot_buddy/model/Model.dart';
import 'package:spot_buddy/screens/SignUpPage.dart';
import 'package:spot_buddy/screens/ForgotPasswordPage.dart';


class LoginPageController {
  String _email;
  String _password;
  AuthService authService;
  ValidatorService validatorService;
  final loginFormKey = GlobalKey<FormState>();
  final BuildContext context;
  final VoidCallback onSignedIn;

  LoginPageController({this.context, this.onSignedIn}) {
    _email = null;
    _password = null;
    authService = Model.of(context).authService;
    validatorService = Model.of(context).validatorService;
  }

  void setEmail(String email) => this._email = email;
  void setPassword(String password) => this._password = password;

  void pushSignUpPage() => 
    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
    );

  void pushForgotPasswordPage() => 
    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  
  Future<void> validateAndLogin() async {
    if (loginFormKey.currentState.validate()) {
      // If all data are correct then save data to out variables
      loginFormKey.currentState.save();
      try {
        String userID = await authService.signInWithEmailAndPassword(
          email: _email,
          password: _password
        );
        onSignedIn();
      }
      catch (error) {
        debugPrint('error: $error');
      }
    }
  }
}
