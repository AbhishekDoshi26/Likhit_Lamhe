import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
String name="";
String emailAddress;
// ignore: camel_case_types
class register extends StatefulWidget {
  register({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _registerstate createState() => new _registerstate();
}

// ignore: camel_case_types
class _registerstate extends State<register> {
  final db=Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController cpass = new TextEditingController();

  String password;
  String doc;
  File _imageFile;
  var download;
  StorageReference reference;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();



  @override
  initState() {
    super.initState();
    auth.onAuthStateChanged.listen((u) {
      setState(() => user = u);
    });
  }




  void submit() async{
    emailAddress=email.text;
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map<String,dynamic> data = <String,dynamic>{
        "First name": fname.text,
        "Last name": lname.text,
        "Email ID": email.text,
        "Password": pass.text,
      };
      final docId= await db.collection("Users").document(email.text).setData(data).whenComplete(() {
        print("User Registered");
      }).catchError((e) => print(e));
      Toast.show("User Registered Successfully", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).pop();
      auth.signOut();
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: new Text("Register", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text("This app is developed by Abhishek Doshi",
          style: TextStyle(color: Colors.red,fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
        color: Colors.black,
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person), alignLabelWithHint: true,
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter name';
                  return null;
                },
                controller: fname,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person), alignLabelWithHint: true,
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter last name';
                  return null;
                },
                controller: lname,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email), alignLabelWithHint: true,
                  labelText: 'Email ID',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter email id';
                  return null;
                },
                controller: email,
              ),


              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.lock), alignLabelWithHint: true,
                  labelText: 'Password',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter password';
                  return null;
                },
                controller: pass,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.lock), alignLabelWithHint: true,
                  labelText: 'Confirm Password',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter password';
                  else
                    if(pass.text!=value)
                      return 'Password does not match';
                  return null;
                },
                controller: cpass,
              ),

              new Container(
                  padding: const EdgeInsets.only(top: 20, left: 110, right: 110),
                  child: new MaterialButton(
                    color: Colors.white,
                    textColor: Colors.blueAccent,
                    child: Text('Submit', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.black,
                    onPressed: submit,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}