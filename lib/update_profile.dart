import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'crud.dart';
import 'dart:async';
import 'interests.dart' as _interests;

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
    //crudObj.getInterest(globals.get_userID()); ... moved this to home page, now interests load immediately upon entering update profile
    //_data = getDocument();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Profile Updated"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('SpotBuddy'),
      ),
      body: Container(
        margin: EdgeInsets.all(40.0),
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
      Padding(
        padding: EdgeInsets.all(40.0),
        child: Text("Interest 1: ",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      new DropdownButton<String>(
        items: _interests.interests.map((String dropDownStringItem) {
          return new DropdownMenuItem<String>(
            child: new SizedBox(width: 200.0, child: new Text(dropDownStringItem)),
            value: dropDownStringItem,
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            //this._ = newValueSelected;
            this._interest1 = newValueSelected;
          });
        },
        value: _interest1,
        //hint: new Text("Select mode"),
      ),
      Padding(
        padding: EdgeInsets.all(40.0),
        child: Text("Interest 2: ",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      new DropdownButton<String>(
        items: _interests.interests.map((String dropDownStringItem) {
          return new DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: new SizedBox(width: 200.0, child: new Text(dropDownStringItem)),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            //this._ = newValueSelected;
            this._interest2 = newValueSelected;
          });
        },
        value: _interest2,
        //hint: new Text("Select mode"),
      ),

      Padding(
        padding: EdgeInsets.all(40.0),
        child: Text("Interest 3: ",
            style: TextStyle(fontSize: 18.0)),

      ),
      new DropdownButton<String>(
        items: _interests.interests.map((String dropDownStringItem) {
          return new DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: new SizedBox(width: 200.0, child: new Text(dropDownStringItem)),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            //this._ = newValueSelected;
            this._interest3 = newValueSelected;
          });
        },
        value: _interest3,
        //hint: new Text("Select mode"),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    return [
      new FlatButton(
        child: new Text(
            'Update', style: new TextStyle(fontSize: 20)),
        onPressed: updateData
      ),
    ];
  }
  void updateData() async {
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
      Map <String, dynamic> userData = {
        'interest1': this._interest1,
        'interest2': this._interest2,
        'interest3': this._interest3,
      };
      print(this._interest1);
        crudObj.updateData(globals.get_userID(), userData).catchError((e) {
          print(e);
        });
      }
     _showDialog();

  }
}
