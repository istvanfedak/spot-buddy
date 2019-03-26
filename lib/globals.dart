import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Color appColor = Colors.red;
String appName = "SpotBuddy";
String _uid = "";
String interest1 = "";
String interest2 = "";
String interest3 = "";

void set_interest1(String i1,String i2,String i3)
{
  interest1 = i1;
  interest2 = i2;
  interest3 = i3;
}

String getInterest1()
{
  return interest1;
}
String getInterest2()
{
  return interest2;
}
String getInterest3()
{
  return interest3;
}

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