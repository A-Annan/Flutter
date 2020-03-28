import 'dart:developer';
import 'weather.dart';

import 'package:flutter/material.dart';

  class weather_form extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => home();

}

class home extends State<weather_form> {
    String city;
    TextEditingController cityTEditC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
          appBar: AppBar(backgroundColor: Colors.amber),
          body:   Column(
            children: <Widget>[
              Container(
                child: Padding (
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Entrer une ville'),
                    controller: cityTEditC,
                    onChanged: (String str){
                      setState(() {
                        city = str;
                      });
                    },
                    onSubmitted: (String str){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> weather(city)));
                      cityTEditC.text = "";

                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  child: Text('Get Weather'),
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute( builder: (context) => weather(city)));
                    cityTEditC.text="";
                  },
                ),
              )
            ],
          )
      );;
  }

}
