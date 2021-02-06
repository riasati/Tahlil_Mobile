import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/question.dart';

class ShortAnswerQuestion extends StatefulWidget {
  Question question;


  ShortAnswerQuestion(this.question);

  @override
  _ShortAnswerQuestionState createState() => _ShortAnswerQuestionState();
}

class _ShortAnswerQuestionState extends State<ShortAnswerQuestion> {
  @override
  Widget build(BuildContext context) {
    UserAnswerShort userAnswerShort = widget.question.userAnswer;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        // height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("پاسخ سوال: " + widget.question.answerString , style: TextStyle(fontWeight: FontWeight.bold),textDirection: TextDirection.rtl),
            Text("پاسخ شما: " + userAnswerShort.answerText, style: TextStyle(fontWeight: FontWeight.bold), textDirection: TextDirection.rtl,),
          ],
        ),
      ),
    );
  }
}
