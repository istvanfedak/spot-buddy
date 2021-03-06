import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailANdPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

// concrete class, specifically referring to firebase being our authentication service
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailANdPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async{
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return user.uid;
  }

  // returns NULL if user didn't sign in, else returns userId
  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}