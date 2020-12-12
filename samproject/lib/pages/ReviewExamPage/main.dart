import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/MultipleChoiceQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/ShortAnswerQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/TestQuestion.dart';
import 'package:samproject/pages/addQuestionPage.dart';
import 'package:samproject/pages/createExamPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Question question;


  @override
  void initState() {
    super.initState();
    question = new Question();
    question.numberOne = 2;
    question.numberTwo = 1;
    question.numberThree = 1;
    question.numberFour = 0;
    question.optionOne = "گزینه ۱";
    question.optionTwo = "گزینه ۲";
    question.optionThree = "گزینه ۳";
    question.optionFour = "گزینه ۴";
    question.answerString = "مدار ماه";
    // UserAnswerTest userAnswerTest = new UserAnswerTest();
    // userAnswerTest.userChoice = -1;
    // question.userAnswer = userAnswerTest;
    // UserAnswerMultipleChoice userAnswerMultipleChoice = new UserAnswerMultipleChoice();
    // question.userAnswer = userAnswerMultipleChoice;
    // userAnswerMultipleChoice.userChoices = [1,2];

    UserAnswerShort userAnswerShort = new UserAnswerShort();
    userAnswerShort.answerText = "مدار زمین";
    question.userAnswer = userAnswerShort;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Starter Template",
      home: Scaffold(
        body: Center(child: ShortAnswerQuestion(question)),
      )
    );
  }
}
