import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: showAnswer(),
    ),
    width: double.infinity,
    //  height: 500,
    );
  }

  List<Widget> showAnswer(){
    UserAnswerTest userAnswerTest = widget.question.userAnswer;
    _radioGroupValue = userAnswerTest.userChoice;
    List<Widget> options =[];
    options.add(
      option(1, widget.question.optionOne, userAnswerTest.userChoice == 1 ,
          widget.question.numberOne == 1)
    );
    options.add(
        option(2, widget.question.optionTwo, userAnswerTest.userChoice == 2 ,
            widget.question.numberOne == 2)
    );
    options.add(
        option(3, widget.question.optionThree, userAnswerTest.userChoice == 3 ,
            widget.question.numberOne == 3)
    );
    options.add(
        option(4, widget.question.optionFour, userAnswerTest.userChoice == 4 ,
            widget.question.numberOne == 4)
    );
    return options;
  }

  Widget option(int index, String content, bool userAnswer, bool isQuestionAnswer){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              content,
              textDirection: TextDirection.rtl,
              style: textStyle(userAnswer, isQuestionAnswer)
            ),
            trailing: Radio(visualDensity: VisualDensity.compact,value: index, groupValue: _radioGroupValue, onChanged: null),
            leading: leading(userAnswer, isQuestionAnswer),
          ),
        )
      ],
    );
  }

  TextStyle textStyle(bool userAnswer, bool isQuestionAnswer){
    if(userAnswer && isQuestionAnswer)
      return TextStyle(
          color: Colors.green
      );
    else if(userAnswer && !isQuestionAnswer)
      return TextStyle(
          color: Colors.red
      );
    else if(!userAnswer && isQuestionAnswer)
      return TextStyle(
          color: Colors.black
      );
    else
      return TextStyle(
          color: Colors.black26
      );
  }

  Text leading(bool userAnswer, bool isQuestionAnswer){
    if(userAnswer && isQuestionAnswer)
      return Text("");
    else if(userAnswer && !isQuestionAnswer)
      return Text("");
    else if(!userAnswer && isQuestionAnswer)
      return Text("(پاسخ صحیح)");
    else
      return Text("");
  }
}
