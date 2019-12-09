
import 'package:flutter/material.dart';
import 'package:spot_buddy/controllers/LoginPageController.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSwitched = true;

  LoginPageController _loginPageController;

Widget signUpForm() {
    return SizedBox(
      width: 300,
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Sign up"),
            onPressed: _loginPageController.pushSignUpPage,
          ),
          SizedBox(width: 25.0,),
          FlatButton(
            child: Text("Forgot password?"),
            onPressed: _loginPageController.pushForgotPasswordPage,
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
                validator: (value) { return _loginPageController.validatorService.validateEmail(value); },
                onSaved: _loginPageController.setEmail,
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
                validator: (value) { return _loginPageController.validatorService.validatePassword(value); },
                onSaved: _loginPageController.setPassword,
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
              onPressed: _loginPageController.validateAndLogin,
            ),
            signUpForm()
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loginPageController = LoginPageController(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
        
      ),
      body: Form(
        key: _loginPageController.loginFormKey,
        // autovalidate: _autoValidate,
        child: loginForm(),
      ),
    );     
  }
}
