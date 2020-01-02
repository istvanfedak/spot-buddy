import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  MessagingPage({Key key}) : super(key: key);
  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Center(
        child:Text('Messages')
      ),
    );
  }
}