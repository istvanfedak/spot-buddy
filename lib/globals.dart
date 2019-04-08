import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

Color appColor = Colors.red;
String appName = "SpotBuddy";
String uid = "";
String interest1 = "";
String interest2 = "";
String interest3 = "";
String name = "";
String email = "";
List<String> remove;

Email sendEmail(String r1) {
  List<String> r = [r1];
  Email email = Email(
    body: 'Looks like we got something in common, want to chat?',
    subject: 'Hey Buddy, its $name',
    recipients: r,
    cc: null,
    bcc: null,
    attachmentPath: null,
  );
  return email;
}

void set_interests(String i1,String i2,String i3)
{
  interest1 = i1;
  interest2 = i2;
  interest3 = i3;
}

void set_Email(String e1)
{
  email = e1;
}

void set_Name(String n1)
{
  name = n1;
}

String getName()
{
  return name;
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
String get_email()
{
  return email;
}

bool cOut = true;
bool logOut = true;
FirebaseAnalytics analytics = FirebaseAnalytics();