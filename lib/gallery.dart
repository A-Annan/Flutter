import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';



class gallery extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _galleryState();

}

class _galleryState extends State<gallery> {
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
                  decoration: InputDecoration(hintText: 'Search'),
                  controller: cityTEditC,
                  onChanged: (String str){
                    setState(() {
                      city = str;
                    });
                  },
                  onSubmitted: (String str){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> galleryData(city)));
                    cityTEditC.text = "";

                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                child: Text('Enter'),
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute( builder: (context) => galleryData(city)));
                  cityTEditC.text="";
                },
              ),
            )
          ],
        )
    );;
  }

}


class galleryData extends StatefulWidget{

  String KeyWord;
  galleryData(this.KeyWord);

  @override
  State<StatefulWidget> createState() => _galleryStateData();
}


class _galleryStateData extends State<galleryData> {

  double currentPage = 1;
  double pageSize = 10;
  double totalpages = 0;
  ScrollController _scrollController = ScrollController();
  dynamic dataGallery;
  List<dynamic> hits = List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Gallery',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),),
      body: (dataGallery == null)?(Center(child: CircularProgressIndicator())):
          ListView.builder(
              controller: _scrollController,
              itemCount: hits.length,
              itemBuilder: (context,index){
//                print(index);

                return Column(
                  children: <Widget>[
                Card(
                color: Colors.deepOrange,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(child: Text("${hits[index]['tags']}"))
                    ],
                  ),
                 ),
                   Padding(
                     padding: EdgeInsets.all(10),
                     child:
                (hits[index]['largeImageURL']==null)?Text('no image'):
                   Image(
                     image: NetworkImage(hits[index]['largeImageURL']),
                     )
                   )
                ],
               );
              }
          )
    );

  }
  getData(url){
    http.get(url).then(
        (res){
        setState(() {
          dataGallery = json.decode(res.body);
          hits.addAll(dataGallery['hits']);
          if (dataGallery['totalHits']%pageSize == 0)
          totalpages = dataGallery['totalHits']/pageSize;
          else totalpages = (dataGallery['totalHits']+1)/pageSize;
        });
        }
    ).catchError((err){
      print(err);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
    _scrollController
    ..addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        if(currentPage<totalpages){
          setState(() {
          ++currentPage;
          });
          loadData();
        }
      }
    });

  }


  void loadData(){
    String url = 'https://pixabay.com/api/?q=${widget.KeyWord}&page=$currentPage&per_page=$pageSize&key=15649348-e6d65d6315110b242bc612884';
    getData(url);
  }






}




