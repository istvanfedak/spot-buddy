import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'crud.dart';
import 'dart:async';

class updateProfile extends StatefulWidget{
  @override
  _updateProfile createState() => new _updateProfile();
}

class _updateProfile extends State<updateProfile> {

  crudMethods crudObj = new crudMethods();
  final formKey = GlobalKey<FormState>();
  String _interest1;
  String _interest2;
  String _interest3;


  @override
  initState() {
    super.initState();
    crudObj.getInterest(globals.get_userID());

    //_data = getDocument();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('SpotBuddy'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest1'),
        validator: (value) =>
        value.isEmpty
            ? 'Interest1 can\'t be empty'
            : null,
        onSaved: (value) => _interest1 = value,
        initialValue: globals.getInterest1()
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest2'),
        validator: (value) =>
        value.isEmpty
            ? 'Interest1 can\'t be empty'
            : null,
        onSaved: (value) => _interest2 = value,
        initialValue: globals.getInterest2()
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest3'),
        validator: (value) =>
        value.isEmpty
            ? 'Interest1 can\'t be empty'
            : null,
        onSaved: (value) => _interest3 = value,
        initialValue: globals.getInterest3()
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    return [
      new FlatButton(
        child: new Text(
            'Create an account', style: new TextStyle(fontSize: 20)),
        onPressed: null
      ),
    ];
  }
  void updateData() async {
      Map <String, dynamic> userData = {
        'interest1': this._interest1,
        'interest2': this._interest2,
        'interest3': this._interest3,
      };
      crudObj.updateData(globals.get_userID(),userData).catchError((e) {
        print(e);
      });
      //widget.onSignedIn();

  }
}

