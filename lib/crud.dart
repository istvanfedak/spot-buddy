import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class crudMethods {

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> addData(userData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection("users").document(globals.get_userID()).setData(userData).catchError((e) {
        print(e);
      });
    }
    else {
      print("User not logged in\n");
    }
  }

  Future<void> getName(String uid) async {
    DocumentSnapshot document = await Firestore.instance.collection('users').document(uid).get();
    globals.set_Name(document.data['username']);
  }

  Future<void> getEmail(String uid) async {
    DocumentSnapshot document = await Firestore.instance.collection('users').document(uid).get();
    globals.set_Email(document.data['email']);
  }
  
  Future<void> getInterest(String uid) async{
    DocumentSnapshot document = await Firestore.instance.collection('users').document(uid).get();
    globals.set_interests(document.data['interest1'],document.data['interest2'],document.data['interest3']);
  }

  Future<void> updateData(selectedDoc, newValues) async{
    Firestore.instance.collection('users').document(selectedDoc).updateData(newValues).catchError((e) {
      print(e);
      });
  }
}