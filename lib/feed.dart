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

  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('users').getDocuments(); // move to crud

    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot user){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(user: user,)));
  }

  @override
  initState() {

    super.initState();
    _data = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('\nEmail: '+ snapshot.data[index].data["email"] + '\n'),
                          Text('Interest 1: ' + snapshot.data[index].data["interest1"]),
                          Text('Interest 2: '+ snapshot.data[index].data["interest2"]),
                          Text('Interest 3: ' + snapshot.data[index].data["interest3"]),
                          ButtonTheme.bar( // make buttons use the appropriate styles for cards
                            child: ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text('View'),
                                  onPressed: () => navigateToDetail(snapshot.data[index]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
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