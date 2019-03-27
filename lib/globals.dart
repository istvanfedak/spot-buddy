import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Color appColor = Colors.red;
String appName = "SpotBuddy";
String uid = "";
String interest1 = "";
String interest2 = "";
String interest3 = "";

void set_interests(String i1,String i2,String i3)
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

void set_userID(String u)
{
  uid = u;
}
String get_userID()
{
  return uid;
}
bool cOut = true;
bool logOut = true;
FirebaseAnalytics analytics = FirebaseAnalytics();