import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailANdPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
}

// generic auth component
class Auth implements BaseAuth {
  Future<String> signInWithEmailANdPassword(String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  // returns NULL if user didn't sign in, else returns userId
  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}