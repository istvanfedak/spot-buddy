import 'package:flutter/material.dart';
import 'globals.dart';
import 'AuthProvider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});
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

  String _email;
  String _password;
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

  void validateAndSubmit() async{
    if(validateAndSave()) {
      try {
        var auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          String userId =
            await auth.signInWithEmailANdPassword(_email, _password);
          print('Signed in: $userId');
          analytics.logLogin();
          //log that the user logged in
          analytics.logLogin();
        } else {
          String userId =
            await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
          // log that the user signed up
          analytics.logSignUp(
              signUpMethod:
                'FirebaseAuth.instance.createUserWithEmailAndPassword'
          );
        }
        widget.onSignedIn();
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
  List<Widget> buildInputs(){
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value)=> _email = value , // save email
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        obscureText: true,
        onSaved: (value) => _password = value ,
      ),
    ];
  }
  List<Widget> buildSubmitButtons(){
    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
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
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Have an account? Login', style: new TextStyle(fontSize: 20)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}

