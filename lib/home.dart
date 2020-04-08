//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:likhit_lamhe/Contactus.dart';
import 'package:likhit_lamhe/Grievance.dart';
import 'package:likhit_lamhe/history.dart';
import 'package:likhit_lamhe/main.dart';
import 'package:toast/toast.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//final db=Firestore.instance;
// ignore: camel_case_types
class drawer1 extends StatelessWidget
{
  drawer1();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Home",style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text("This app is developed by Abhishek Doshi",
          style: TextStyle(color: Colors.red,fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
        color: Colors.black,
      ),
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage("assets/img.jpg"),
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
            color: Colors.black54, //lightens the image
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10000000, 10, 0, 0),
              ),
              MaterialButton(
                color: Colors.white,
                textColor: Colors.blueAccent,
                child: Text("Write"),
                minWidth: 100.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                splashColor: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => grievance()
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.lightBlue),
                  accountName: Text("Welcome\n$fname $lname\n",style: TextStyle(fontSize: 18.0),),
                  currentAccountPicture: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      image: DecorationImage(fit: BoxFit.fill,
                          image: AssetImage("assets/pen.png")),
                    ),
                  ),
                  accountEmail: null,
                ),
              ),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home,color: Colors.redAccent),
                onTap: () {
                  drawer1();
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: Text('Write'),
                leading: Icon(Icons.comment,color: Colors.green,),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => grievance()
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('View'),
                leading: Icon(Icons.history,color: Colors.orange,),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => display()
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Contact Us'),
                leading: Icon(Icons.contacts,color: Colors.blueAccent),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => contactus()
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.exit_to_app,color: Colors.black),
                onTap: () {
                  Toast.show("Thank You for using Likhit Lamhe!!", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 500), () {
                    exit(1);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
