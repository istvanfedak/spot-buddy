import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crud.dart';
import 'globals.dart' as globals;



class updateProfile extends StatefulWidget{
  @override
  _updateProfile createState() => new _updateProfile();
}

class _updateProfile extends State<updateProfile> {
  final formKey = GlobalKey<FormState>();
  crudMethods crudObj = new crudMethods();

  String _password;
  String _interest1;
  String _interest2;
  String _interest3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My SpotBuddy'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs()+ buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _password = value, // save email
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 1'),
        validator: (value) =>
        value.isEmpty ? 'First interest can\'t be empty' : null,
        obscureText: true,
        onSaved: (value) => _interest1 = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 2'),
        validator: (value) =>
        value.isEmpty ? 'Second interest can\'t be empty' : null,
        obscureText: true,
        onSaved: (value) => _interest2 = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 3'),
        validator: (value) =>
        value.isEmpty ? 'Third interest can\'t be empty' : null,
        obscureText: true,
        onSaved: (value) => _interest3 = value,
      ),
    ];
  }
  List<Widget> buildSubmitButtons(){
      return [
        new RaisedButton(
            child: new Text('Update', style: new TextStyle(fontSize: 20.0)),
            onPressed: () {
              //validateAndSubmit();
            }
        ),
      ];
  }
  void addToDatabase() async {
      Map <String, dynamic> userData = {
        'password': this._password,
        'interest1': this._interest1,
        'interest2': this._interest2,
        'interest3': this._interest3,
      };
      Firestore.instance.collection('users').document(globals.get_userID()).setData({"password":_password,"interest1": _interest1,
        "interest2": _interest2, "interest": _interest3});
      //crudObj.addData(userData).catchError((e) {
        //print(e);
      //});
      //widget.onSignedIn();
  }
}