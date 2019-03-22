import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      Firestore.instance.collection("users").add(userData).catchError((e) {
        print(e);
      });
    }
    else {
      print("User not logged in\n");
    }
  }

  getData() async{
    return await Firestore.instance.collection('users').getDocuments();
  }

  updateData(selectedDoc, newValues){
    Firestore.instance.collection('users').document(selectedDoc).updateData(newValues).catchError((e) {
      print(e);
      });
  }
}