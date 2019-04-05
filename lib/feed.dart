import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'crud.dart';
import 'dart:async';

class Feed extends StatefulWidget{
  @override
  _Feed createState() => new _Feed();
}

class _Feed extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Pool Feed')
      // ),
        child: ListPage()
      //);
    );
  }
}
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  List<DocumentSnapshot> data; //DONT FORGET TO INITIALIZE WITH NEW, OR ELSE YOU ARE REFERRING TO NULL (CANT ACCESS), NEED TO ALLOCATE FOR OBJECT
  var firestore;

  @override
  initState() {
    super.initState();
    firestore = Firestore.instance;
    //data = new List();
  }

  _g(DocumentSnapshot d) {
    if( !(globals.remove.contains(d.documentID)) && d.documentID != globals.uid) {
      data.add(d);
    }
  }

  setup() async {
    data = await new List();
  }

  getPosts() async {
    await setup();
    QuerySnapshot qn = await firestore.collection("users").getDocuments();
    var list = qn.documents;

    for(DocumentSnapshot d in list) {
      await _g(d);
    }

  }

  navigateToDetail(DocumentSnapshot user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(user: user,)));
  }

  @override
  Widget build(BuildContext context) {
    getPosts();
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('\nEmail: ' + data.elementAt(index).data["email"] + '\n'),
                Text('Interest 1: ' + data.elementAt(index).data["interest1"]),
                Text('Interest 2: ' + data.elementAt(index).data["interest2"]),
                Text('Interest 3: ' + data.elementAt(index).data["interest3"]),
                ButtonTheme
                    .bar( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('View'),
                        onPressed: () => navigateToDetail(data.elementAt(index)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot user;
  DetailPage({this.user});
  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold (
      appBar: AppBar(
        title: Text(widget.user.data["email"]),
      ),
      body: Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('\nEmail: '+ widget.user.data["email"] + '\n'),
              Text('Interest 1: ' + widget.user.data["interest1"]),
              Text('Interest 2: '+ widget.user.data["interest2"]),
              Text('Interest 3: ' + widget.user.data["interest3"]),
              ButtonTheme.bar( // make buttons use the appropriate styles for cards
               child: ButtonBar(
               children: <Widget>[
                FlatButton(
                  child: const Text('Request Match'),
                  onPressed: () => null
                ),
                ],
                ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}