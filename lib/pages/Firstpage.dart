import 'dart:ui';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstPage(),
  ));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('lib/images/mcar.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX:1.0, sigmaY: 1.0),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              
              child: Text('Book the best Carparking spot',
              style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,
              fontSize: 40),
              
              ),
            ),
            
          ),
        ),
      ),
    );
  }
}