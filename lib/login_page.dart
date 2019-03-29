import 'package:flutter/material.dart';
import 'globals.dart';
import 'AuthProvider.dart';
import 'auth.dart';
import 'crud.dart';
import 'globals.dart' as globals;
import 'interests.dart' as _interests;

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn,this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  crudMethods crudObj = new crudMethods();

  var _currentItemSelected = 'golf';

  String _email;
  String _password;
  String _interest1 = 'Astronomy';
  String _interest2 = 'Astronomy';
  String _interest3 = 'Astronomy';
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    //log validation of user
    analytics.logEvent(name: 'validateAndSave');
    if(form.validate()) {
      form.save();
      if (cOut)
        print('Form is valid. Email $_email, password $_password');
      //log valid form
      analytics.logEvent(name: 'validForm');
      return true;
    } else {
      if (cOut)
        print('Form not invalid. Email $_email, password $_password');
      //log valid form
      analytics.logEvent(name: 'invalidForm');
      return false;
    }
  }

  Future<void> validateAndSubmit() async{
    if(validateAndSave()) {
      try {
        //var auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          String userId =
            await widget.auth.signInWithEmailANdPassword(_email, _password);
          widget.onSignedIn();
          print('Signed in: $userId');
          globals.set_userID('$userId');
          analytics.logLogin();
          //log that the user logged in
          analytics.logLogin();
        } else {
          String userId =
            await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
          globals.set_userID('$userId');
          // log that the user signed up
          analytics.logSignUp(
              signUpMethod:
                'FirebaseAuth.instance.createUserWithEmailAndPassword'
          );
          addToDatabase(); // after creating user, will add info to database, and inside this
                           // function it also does widget.onSignedIn() so the auth status gets
                           // changed to signed in, taking the user to the home page. So after
                           // creating an account, the user does not have go and login.
        }
      }
      catch(e){
        print('error: $e');
      }

    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      // log transition to register page
      analytics.setCurrentScreen(screenName: 'Register');
      _formType = FormType.register;
    });

  }
  void moveToLogin(){
    formKey.currentState.reset();
    // log transition to login page
    analytics.setCurrentScreen(screenName: 'Login');
    setState(() {
      _formType = FormType.login;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpotBuddy'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
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
    if (_formType == FormType.login) {
      return [
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value, // save email
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Password'),
          validator: (value) =>
          value.isEmpty ? 'Password can\'t be empty' : null,
          obscureText: true,
          onSaved: (value) => _password = value,
        ),
      ];
    }
    else{
      return [
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value, // save email
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Password'),
          validator: (value) =>
          value.isEmpty ? 'Password can\'t be empty' : null,
          obscureText: true,
          onSaved: (value) => _password = value,
        ),

        Padding(
            padding: EdgeInsets.all(40.0),
            child: Text("Interest 1: ",
            style: TextStyle(fontSize: 18.0)),

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
  }
  List<Widget> buildSubmitButtons(){
    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: () {
            validateAndSubmit();
            //widget.onSignedIn(); ... ruined the code, was changing the auth status to
                                       // signed in regardless of whether login was valid or not
                                       // thus taking us to the home page. The fix was to move this
                                       // line into validateAndSubmit() where we only change auth
                                       // status to signed in if it worked via firebase.

          }
        ),
        new FlatButton(
          child: new Text(
              'Create an account', style: new TextStyle(fontSize: 20)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
          onPressed: () {
              validateAndSubmit();
          },
        ),
        new FlatButton(
          child: new Text('Have an account? Login', style: new TextStyle(fontSize: 20)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }

  void addToDatabase() async {
    if(_formType != FormType.login) {
      Map <String, dynamic> userData = {
        'uid': globals.get_userID(),
        'email': _email,
        'interest1': this._interest1,
        'interest2': this._interest2,
        'interest3': this._interest3,
      };
      crudObj.addData(userData).catchError((e) {
        print(e);
      });
      widget.onSignedIn();
    }
  }
}

