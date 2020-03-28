import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class quiz extends StatefulWidget {
  int counter;
  quiz(this.counter);
  @override
  State<StatefulWidget> createState() => _stateQuiz();
}

class _stateQuiz extends State<quiz>{
  int current_question = 0;
  int score = 0;
  final quiz = [
    {
      'title':'Q1',
      'answers': [
        {'answer':'answer 11','correct':false},
        {'answer':'answer 12','correct':false},
        {'answer':'answer 13','correct':true},
      ]
    },
    {
      'title':'Q2',
      'answers': [
        {'answer':'answer 21','correct':false},
        {'answer':'answer 22','correct':true},
        {'answer':'answer 23','correct':false},
      ]
    }
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Quiz',style: TextStyle(fontSize: 22),),),
      body: (this.current_question >= quiz.length)?
          Center(
            child: Column(
              children: <Widget>[
                Text('Score : ${(score/quiz.length*100).round()}%',style: TextStyle(fontSize: 22),),
                RaisedButton(child: Text("Restart",style: TextStyle(fontSize: 22),),color: Colors.blue,onPressed: (){
                  setState(() {
                    this.current_question = 0;
                    this.score = 0;
                  });
                },)
              ],
            ),
          ):
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('${(quiz[current_question]['title'])}',style: TextStyle(fontSize: 22),),),
                ...(quiz[current_question]['answers'] as List<dynamic>).map((answer){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Container(
                      child: Align(
                        child: Text('${answer['answer']}',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                      ),padding: EdgeInsets.all(10),
                    ),
                    color: Colors.amber,
                    onPressed: (){
                      setState(() {
                        if (answer['correct']) ++score;
                        ++current_question;
                      });
                    },

                  ),
                );
                })
            ],
          )
    );
  }

}
