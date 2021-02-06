import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswer.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/question.dart';

class LongAnswerQuestion extends StatefulWidget {
  Question question;

  LongAnswerQuestion(this.question);

  @override
  _LongAnswerQuestionState createState() => _LongAnswerQuestionState();
}

class _LongAnswerQuestionState extends State<LongAnswerQuestion> {
  bool userAnswer = false;
  final PageController pageController = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    userAnswer = (index == 0);
                  });
                },
                controller: pageController,
                children: [
                  userAnswerView(),
                  questionAnswerView(),
                ],
              ),
              padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            ),
            flex: 8,
          ),
          Expanded(child: buttonBar())
        ],
      ),
      padding: EdgeInsets.only(bottom: 10),
    );
  }

  Widget questionAnswerView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Text(
        widget.question.answerString,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget userAnswerView() {
    UserAnswerLong userAnswerLong = widget.question.userAnswer;
    if(userAnswerLong.answerFile != null && userAnswerLong.answerFile.isNotEmpty)
    return Padding(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                userAnswerLong.answerText,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            flex: 4,
          ),
          Expanded(
              child: Container(
                child: FlatButton(
                    onPressed: () {},
                    child: Text("دانلود فایل", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xFF3D5A80),
                ),
                width: 150,
              ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      padding: EdgeInsets.only(bottom: 70),
    );
    else
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          userAnswerLong.answerText,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.right,
        ),
      );
  }

  Widget buttonBar() {
    return ButtonBar(
      children: [
        Container(
          child: FlatButton(
            onPressed: () {
              setState(() {
                userAnswer = true;
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              });
            },
            child: Text(
              "پاسخ شما",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: userAnswer ? Colors.white : Colors.black),
            ),
          ),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            color: userAnswer ? Colors.black : Colors.black26,
          ),
        ),
        Container(
          child: FlatButton(
              onPressed: () {
                setState(() {
                  userAnswer = false;
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                });
              },
              child: Text(
                "پاسخ سوال",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: userAnswer ? Colors.black : Colors.white),
              )),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: userAnswer ? Colors.black26 : Colors.black,
          ),
        ),
      ],
      buttonPadding: EdgeInsets.all(0),
      alignment: MainAxisAlignment.center,
    );
  }
}
