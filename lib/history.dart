import 'package:likhit_lamhe/register.dart';
import 'package:toast/toast.dart';

import 'historydisp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Grievance.dart';
import 'main.dart';
bool check=true;
class CustomCard extends StatelessWidget {
  CustomCard({@required this.doc, this.quote, this.down,});

  final doc;
  final quote;
  final down;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
               Text(quote),
                FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text("See More"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => historydisplay(doc: doc,  quote: quote, down: down)));
                      Toast.show("Please wait...Image will be loaded soon.", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    }),
              ],
            )
        )
    );
  }
}

class display extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(
          title: new Text("Quotes", style: TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),

        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Quotes').where('Email ID',isEqualTo: email).orderBy("TimeStamp",descending: true).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                //if(snapshot.data==null) return new Text('No forms are available now!!!\n\nPlease try again later.',style: TextStyle(fontSize: 15));
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Retrieving Forms...',style: TextStyle(fontSize: 20),);
                  default:
                    return new ListView(
                      children: snapshot.data.documents.map((DocumentSnapshot document) {
                        return CustomCard(
                          doc: document.documentID,
                          quote: document['Quote'],
                          down: document['DownloadURL'],
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ),
      );
  }
}