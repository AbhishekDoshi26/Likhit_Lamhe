import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:likhit_lamhe/main.dart';
import 'package:likhit_lamhe/register.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'register.dart';
String name="";
// ignore: camel_case_types
class grievance extends StatefulWidget {
  grievance({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _grievancestate createState() => new _grievancestate();
}

// ignore: camel_case_types
class _grievancestate extends State<grievance> {
  final db=Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  String emailAddress;
  String pass;
  String doc;
  File _imageFile;
  var download;
  StorageReference reference;
  TextEditingController quote = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();



  @override
  initState() {
    super.initState();
    auth.onAuthStateChanged.listen((u) {
      setState(() => user = u);
    });
  }



  Future getimage() async{
    File image;
    image=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile=image;
    });
  }

  Future submit() async{
    name = quote.text;
    emailAddress = phone.text;
    if(_imageFile!=null) {
      Toast.show(
          "Uploading Image. Please wait. Don't press back button.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      reference = FirebaseStorage.instance.ref().child('Quotes/$emailAddress/$name');
      StorageUploadTask uploadTask = reference.putFile(_imageFile);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadAddress = await reference.getDownloadURL();
      download = downloadAddress;
      print(download);
    }
    else
      download=null;
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map<String,dynamic> data = <String,dynamic>{
        "Email ID": emailAddress,
        "Quote": quote.text,
        "DownloadURL": download,
        "TimeStamp": Timestamp.now(),
      };
      final docId= await db.collection("Quotes").document(quote.text).setData(data).whenComplete(() {
        print("Form Added"+emailAddress);
      }).catchError((e) => print(e));
      Toast.show("Quote Submitted Successfully", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
        title: new Text("Submit Quotes", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
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
                  icon: const Icon(Icons.border_color), alignLabelWithHint: true,
                  labelText: 'Quote',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter quote';
                  return null;
                },
                controller: quote,
                textCapitalization: TextCapitalization.sentences,
              ),

              new Container(
                  padding: const EdgeInsets.only(top: 20, left: 110, right: 110),
                  child: new MaterialButton(
                    color: Colors.white,
                    textColor: Colors.blueAccent,
                    child: Text('Select Image', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.black,
                    onPressed: getimage
                  )
              ),
              _imageFile == null ? Container() : Image.file(_imageFile,height: 300.0,width: 300.0,),
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