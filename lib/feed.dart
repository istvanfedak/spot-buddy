import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class Feed extends StatefulWidget{
  @override
  _Feed createState() => new _Feed();
}

class _Feed extends State<Feed> {
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
      appBar: new AppBar(
          title: new Text('Buddy Feed')
       ),
        //child: ListPage()
      );
  }
}