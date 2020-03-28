import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';



class weather extends StatefulWidget {
  String city;
  weather(this.city);

  @override
  State<StatefulWidget> createState() => home_weather();

}

class home_weather extends State<weather> {

  List<dynamic> weatherData;
  getData(url){
    http.get(
        Uri.encodeFull(url),headers: {'accept':'application/json'}
        ).then(
        (resp){
          setState(() {
            weatherData = json.decode(resp.body)['list'];
            print('resp -> ${resp.body}');
            print('weatherData -> $weatherData');
          });
        }).catchError((err){
          print(err);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.city);
    String
//    url='http://openweathermap.org/data/2.5/forecast?q=${this.widget.city}&appid=39a637ad160a0d1850ea8b6755b16aa4';
    url='https://samples.openweathermap.org/data/2.5/forecast?q=${this.widget.city}&APPID=39a637ad160a0d1850ea8b6755b16aa4';
    this.getData(url);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.city}',style: TextStyle(fontSize: 22),),
        backgroundColor: Colors.deepOrange,
      ),
      body:   (weatherData == null)?Center(child: CircularProgressIndicator(),):
          ListView.builder(
              itemCount: (weatherData==null)?0:weatherData.length,
              itemBuilder: (context,index){
                return Card(
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('images/${weatherData[index]['weather'][0]['main'].toLowerCase()}.png'),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${DateFormat('E dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(weatherData[index]['dt']*1000000))}", style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                              Text("${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(weatherData[index]['dt']*1000000))}|${weatherData[index]['weather'][0]['main']}",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight:FontWeight.bold))

                            ],
                          ),
                        ),
                       Text("${(weatherData[index]['main']['temp'] - 273.15).round()} °C", style: TextStyle(fontSize: 20,color: Colors.white,fontWeight:FontWeight.bold),),
                      ],
                    ),
                  ),
                );
              }
            ),
    );
  }


}