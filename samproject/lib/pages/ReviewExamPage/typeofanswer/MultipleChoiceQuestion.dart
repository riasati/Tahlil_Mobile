import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/question.dart';



class MultipleChoiceQuestion extends StatefulWidget {
  Question question;

  MultipleChoiceQuestion(this.question);

  @override
  _MultipleChoiceQuestionState createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: showAnswer(),
    ),
    width: double.infinity,
     // height: 500,
    );
  }

  List<Widget> showAnswer(){
    UserAnswerMultipleChoice userAnswerMultipleChoice = widget.question.userAnswer;
    List<Widget> options =[];
    options.add(
        option(widget.question.optionOne, userAnswerMultipleChoice.userChoices.contains(1),
            widget.question.numberOne == 1)
    );
    options.add(
        option(widget.question.optionTwo, userAnswerMultipleChoice.userChoices.contains(2),
            widget.question.numberTwo == 1)
    );
    options.add(
        option(widget.question.optionThree, userAnswerMultipleChoice.userChoices.contains(3) ,
            widget.question.numberThree == 1)
    );
    options.add(
        option(widget.question.optionFour, userAnswerMultipleChoice.userChoices.contains(4) ,
            widget.question.numberFour == 1)
    );
    return options;
  }

  Widget option(String content, bool userAnswer, bool isQuestionAnswer){
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
            trailing: Checkbox(visualDensity: VisualDensity.compact,value: userAnswer, onChanged: null),
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
    if(isQuestionAnswer)
      return Text("(پاسخ سوال)");
    else
      return Text("");
  }
}
