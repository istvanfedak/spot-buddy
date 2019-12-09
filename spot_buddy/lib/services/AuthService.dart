
import 'package:firebase_auth/firebase_auth.dart';


// concrete class, specifically referring to firebase being our authentication service
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword({
      String email, String password}) async {
    FirebaseUser user =  (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    )).user;
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    /*
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    */
    return "NULL"; //user.uid;
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