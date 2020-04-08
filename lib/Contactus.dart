import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Contact Us", style: TextStyle(color: Colors.white)),
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
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.only(top: 20)),
                        Text("""Hello!! This app is made by Abhishek Doshi.\n\nYou can contact me at:\n\nEmail: adoshi26.ad@gmail.com\n\nTwitter: @AbhishekDoshi26""",
                          softWrap: true,
                          style: TextStyle(fontSize: 20.0,color: Colors.white),
                          textAlign: TextAlign.justify,),
                        Padding(padding: const EdgeInsets.only(top: 20)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}