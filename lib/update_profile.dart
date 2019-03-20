import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class updateProfile extends StatefulWidget{
  @override
  _updateProfile createState() => new _updateProfile();
}

class _updateProfile extends State<updateProfile> {

  @override
  Widget build(BuildContext context) {

      return new Scaffold(
       appBar: new AppBar(
         title: new Text('Update Profile')
       ),
      //child: ListPage()
      );
  }
}