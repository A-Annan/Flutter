import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_test/weather_form.dart';
import 'quiz.dart';
import 'gallery.dart';
import 'weather_form.dart';
import 'camera.dart';
import 'qrCode.dart';


void main(){
  runApp(MaterialApp(home: Home()));
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.amber[800],Colors.white])),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/img.png'),
                    radius: 45,
                  ),
                ),
              ),
              ListTile(
                title: Text('Quiz',style: TextStyle(fontSize: 20),),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>quiz(0  )));
                },
              ),
              Divider(color: Colors.grey,),
              ListTile(
                title: Text('Weather',style: TextStyle(fontSize: 20)),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>weather_form()));
                },
              ),
              Divider(color: Colors.grey,),
              ListTile(
                title: Text('Gallery',style: TextStyle(fontSize: 20)),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>gallery()));
                },
              ),
              Divider(color: Colors.grey,),
              ListTile(
                title: Text('Camera',style: TextStyle(fontSize: 20)),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>camera()));
                },
              ),
              Divider(color: Colors.grey),
              ListTile(
                title: Text('QrCode',style: TextStyle(fontSize: 20),),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>qrCode()));
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("My app"),
          backgroundColor: Colors.amber[600],
        ),
        body: Center(child: Text("Body",style: TextStyle(fontSize: 22,color: Colors.blue),))
    );
  }

}