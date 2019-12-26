
import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/LoginPageController.dart';

class LoginPage extends StatefulWidget {
  final loginPageController;
  LoginPage({Key key, this.loginPageController}) : super(key: key) {
    title = "Login";
  }

  String title;
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSwitched = true;

Widget signUpForm() {
    return SizedBox(
      width: 300,
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Sign up"),
            onPressed: widget.loginPageController.pushSignUpPage,
          ),
          SizedBox(width: 25.0,),
          FlatButton(
            child: Text("Forgot password?"),
            onPressed: widget.loginPageController.pushForgotPasswordPage,
          ),
        ],
      )
    );
  }

  Widget loginForm() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300.0,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) { return widget.loginPageController.validatorService.validateEmail(value); },
                onSaved: widget.loginPageController.setEmail,
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox(
              width: 300.0,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password'
                ),
                validator: (value) { return widget.loginPageController.validatorService.validatePassword(value); },
                onSaved: widget.loginPageController.setPassword,
              ),
            ),
            SizedBox(height: 30.0,),
            SizedBox(
              width: 300.0,
              child: Row(
                children: <Widget>[
                  Switch(
                    value: _isSwitched,
                    onChanged: (value) {
                      setState(() {
                        _isSwitched = value;
                      });
                    },
                  ),
                  SizedBox(width: 10.0,),
                  Text("Stay signed in"),
                ],
              ),
            ),
            RaisedButton(
              child: SizedBox(
                width: 300,
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: widget.loginPageController.validateAndLogin,
            ),
            signUpForm()
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
        
      ),
      body: Form(
        key: widget.loginPageController.loginFormKey,
        // autovalidate: _autoValidate,
        child: loginForm(),
      ),
    );     
  }
}
