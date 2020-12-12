import 'package:flutter/material.dart';
import 'package:samproject/domain/question.dart';


class MultipleChoice extends StatefulWidget {
  //TODO fix question
  Question question;


  MultipleChoice(this.question);

  @override
  _MultipleChoiceState createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget option(bool isAnswer, String content, bool userAnswer, bool questionAnswer){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
              content,
              textDirection: TextDirection.rtl,
              style: textStyle(userAnswer, questionAnswer)
          ),
          trailing: Checkbox(visualDensity: VisualDensity.compact,value: isAnswer, onChanged: null),
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
