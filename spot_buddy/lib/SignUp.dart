
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

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
                  hintText: 'First Name'
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox(
              width: 300.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Last Name'
                ),
              ),
            ),
            SizedBox(height: 20.0,),
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
            SizedBox(height: 20.0,),
            SizedBox(
              width: 300.0,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm password'
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            RaisedButton(
              child: SizedBox(
                width: 300,
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
