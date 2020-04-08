import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:likhit_lamhe/register.dart';
import 'package:toast/toast.dart';
import 'delayed_animation.dart';
import 'home.dart';

TextEditingController phone = TextEditingController();
TextEditingController password = TextEditingController();

bool ot;
String smsOTP;
String verificationId;
String errorMessage = '';
String email="";
String pass;
String fname,lname;
FirebaseAuth _auth = FirebaseAuth.instance;
void main() {
  //SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        //'/homepage': (BuildContext context) => drawer1(),
        '/loginpage': (BuildContext context) => MyApp(),
        '/home': (BuildContext context) => drawer1(),
        '/register': (BuildContext context) => register(),
      },
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.blueAccent
      ),
    );
  }
}
class Login extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Login> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    ot = true;
    phone.text=null;
    password.text=null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          child: Text("This app is developed by Abhishek Doshi",
                      style: TextStyle(color: Colors.red,fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                    color: Colors.black,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage("assets/img.jpg"),
              fit: BoxFit.cover,
              color: Colors.black54,
              colorBlendMode: BlendMode.darken,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
              child: Form(key: _formKey,
                child: Theme(
                  data: ThemeData(
                    brightness: Brightness.dark,
                    accentColor: Colors.lightBlue,
                    primaryColor: Colors.blueAccent,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: color, fontSize: 20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AvatarGlow(
                        endRadius: 90,
                        duration: Duration(seconds: 2),
                        glowColor: color,
                        repeat: true,
                        repeatPauseDuration: Duration(seconds: 2),
                        startDelay: Duration(seconds: 1),
                        child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Image.asset("assets/pen1.png"),
                            radius: 50.0,
                          ),
                        ),
                      ),

                      DelayedAimation(
                        child: Text("Welcome", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: color),
                        ),
                        delay: delayedAmount + 1000,
                      ),
                      SizedBox(height: 30.0),
                      DelayedAimation(
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(prefixIcon: Icon(Icons.email),hintText: 'Email ID',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          validator: (value){
                            if(value.isEmpty)
                              return 'Please enter Email ID';
                            return null;
                          },
                          controller: phone,
                        ),
                        delay: delayedAmount + 2000,
                      ),
                      SizedBox(height: 15.0),
                      DelayedAimation(
                        child: TextFormField(
                          autofocus: false,
                          obscureText: ot,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(prefixIcon: Icon(Icons.lock),hintText: 'Password',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            suffixIcon: GestureDetector(
                              onTap: () { setState(() {ot = !ot;}); },
                              child: Icon(ot ? Icons.visibility : Icons.visibility_off,
                                semanticLabel: ot ? 'show password' : 'hide password',
                              ),
                            ),
                          ),
                          validator: (value){
                            if(value.isEmpty)
                              return 'Please enter Password';
                            return null;
                          },
                          controller: password,
                        ),
                        delay: delayedAmount + 2000,
                      ),
                      SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DelayedAimation(
                        child: GestureDetector(
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          child: Transform.scale(
                            scale: _scale,
                            child: _animatedButtonUI,
                          ),
                        ),
                        delay: delayedAmount + 3000,
                      ),
                      SizedBox(height: 30.0,),
                      DelayedAimation(
                        child: Text("  "),
                        delay: delayedAmount + 3000,
                      ),
                      DelayedAimation(
                        child: GestureDetector(
                          onTapDown: _onTapDown2,
                          onTapUp: _onTapUp2,
                          child: Transform.scale(
                            scale: _scale,
                            child: _animatedButtonUI2,
                          ),
                        ),
                        delay: delayedAmount + 3000,
                      ),
                     ],
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      );
  }

  Widget get _animatedButtonUI => Container(
    height: 50,
    width: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Log In',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    ),
  );
  Widget get _animatedButtonUI2 => Container(
    height: 50,
    width: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Register',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    ),
  );

  void _onTapDown(TapDownDetails details) async {
    _controller.forward();
    email=phone.text;
    pass=password.text;
    if (_formKey.currentState.validate()) {
      DocumentReference documentReference = Firestore.instance.collection("Users").document("$email");
      documentReference.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          pass = datasnapshot.data['Password'].toString();
          if (password.text == pass) {
            fname = datasnapshot.data['First name'].toString();
            lname = datasnapshot.data['Last name'].toString();
            Navigator.of(context).pushReplacementNamed('/home');
            Toast.show("Welcome !!!", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
          else
            Toast.show("Invalid Password!!!", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        }
        else
          Toast.show("User not registered!!!", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
      );
    }
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
  void _onTapDown2(TapDownDetails details) async {
    _controller.forward();
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => register()
      ),
    );
  }

  void _onTapUp2(TapUpDetails details) {
    _controller.reverse();
  }
}