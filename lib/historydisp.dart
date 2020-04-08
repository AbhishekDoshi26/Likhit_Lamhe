import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:likhit_lamhe/history.dart';
import 'package:toast/toast.dart';


class historydisplay extends StatelessWidget {
  historydisplay({@required this.doc, this.quote, this.down,});

  final doc;
  final quote;
  final down;
  final db=Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doc,style: TextStyle(color: Colors.white),),
        iconTheme: new IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(top: 20)),
                      Text(quote,softWrap: true,textAlign: TextAlign.justify,style: TextStyle(fontSize: 14.0),),
                      Padding(padding: const EdgeInsets.only(top: 20)),
                      down!=null?Image.network(down): new Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}