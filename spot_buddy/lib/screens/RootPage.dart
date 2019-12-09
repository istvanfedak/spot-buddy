
import 'package:flutter/material.dart';


class RootPage extends StatefulWidget {
  RootPage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
            Text("Root"),
          ],
        ),
      ),
    );
  }
}
