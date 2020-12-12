import 'package:flutter/material.dart';
import 'package:samproject/domain/question.dart';

class TestQuestion extends StatefulWidget {
  Question question;
  TestQuestion(this.question);

  @override
  _TestQuestionState createState() => _TestQuestionState();
}

class _TestQuestionState extends State<TestQuestion> {
  int _radioGroupValue;
  @override
  void initState() {
    super.initState();
    _radioGroupValue = widget.question.numberOne;
  }
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [

      ],
    ),);
  }

  Widget showAnswer(){
    //TODO add options of question
    List<Widget> options =[];
  }
  Widget option(int index, String content, bool userAnswer, bool questionAnswer){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            content,
            textDirection: TextDirection.rtl,
            style: textStyle(userAnswer, questionAnswer)
          ),
          trailing: Radio(visualDensity: VisualDensity.compact,value: index, groupValue: _radioGroupValue, onChanged: null),
        )
      ],
    );
  }

  TextStyle textStyle(bool userAnswer, bool questionAnswer){
    var textStyle;
    if(userAnswer == null){
      if(questionAnswer)
        textStyle = TextStyle(
          color: Colors.black,
        );
      else
        textStyle = TextStyle(
          color: Colors.black26,
        );
    }
    else{
      if(questionAnswer)
        textStyle = TextStyle(
          color: Colors.green,
        );
      else{
        if(userAnswer)
          if(questionAnswer)
            textStyle = TextStyle(
              color: Colors.red,
            );
          else
          if(questionAnswer)
            textStyle = TextStyle(
              color: Colors.black45,
            );
      }
    }
    return textStyle;
  }
}
