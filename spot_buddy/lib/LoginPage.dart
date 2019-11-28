
import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'ForgotPasswordPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSwitched = true;

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox(
              width: 300.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            SizedBox(
              width: 300.0,
              child: Row(
                children: <Widget>[
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
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
              onPressed: () {},
            ),
            SizedBox(
              width: 300,
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("Sign up"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage(title: "Sign Up",)),
                      );
                    },
                  ),
                  SizedBox(width: 25.0,),
                  FlatButton(
                    child: Text("Forgot password?"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage(title: "Forgot Password?",)),
                      );
                    },
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
