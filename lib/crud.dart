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

  Future<void> getInterest1(String uid) async{
    DocumentSnapshot document = await Firestore.instance.collection('users').document(uid).get();
    globals.interest1 = document.data['interest1'];
  }

  Future<void> getInterest2(String uid) async{
    DocumentSnapshot document = await Firestore.instance.collection('users').document(uid).get();
    globals.interest2 = document.data['interest2'];
  }

  Future<void> getInterest3(String uid) async{
    DocumentSnapshot document = await Firestore.instance.collection('users').document(uid).get();
    globals.interest3 = document.data['interest3'];
  }

  updateData(selectedDoc, newValues){
    Firestore.instance.collection('users').document(selectedDoc).updateData(newValues).catchError((e) {
      print(e);
      });
  }
}