import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Color appColor = Colors.red;
String appName = "SpotBuddy";
String _uid = "";
String interest1 = "";
String interest2 = "";
String interest3 = "";

void set_userID(String uid)
{
  _uid = uid;
}
String get_userID()
{
  return _uid;
}
bool cOut = true;
bool logOut = true;
FirebaseAnalytics analytics = FirebaseAnalytics();