
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

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
            RaisedButton(
              child: SizedBox(
                width: 300,
                child: Text(
                  "Submit",
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () { },
            ),
          ],
        ),
      ),
    );
  }
}
