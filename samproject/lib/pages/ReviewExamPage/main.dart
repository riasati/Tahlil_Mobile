import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/QuestionView.dart';
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
  Question newQuestion = new Question();
  Question newQuestion2 = new Question();
  Question newQuestion3 = new Question();
  Question newQuestion4 = new Question();
  UserAnswerShort userAnswerShort;
  UserAnswerTest userAnswerTest;
  UserAnswerMultipleChoice userAnswerMultipleChoice;

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

    question.text = "asdfads";
    question.paye = "دهم";
    question.book = "ریاضی";
    question.chapter = "1";
    question.kind = "پاسخ کوتاه";
    question.difficulty = "سخت";
    question.grade = 1.2;

    newQuestion.text = "asdfads";
    newQuestion.paye = "دهم";
    newQuestion.book = "ریاضی";
    newQuestion.chapter = "1";
    newQuestion.kind = "چند گزینه ای";
    newQuestion.difficulty = "سخت";
    newQuestion.grade = 1.2;
    newQuestion.optionOne = "شیسشس";
    newQuestion.optionTwo = "asdشیسشس";
    newQuestion.optionThree = "شیسشsdsdس";
    newQuestion.optionFour = "شیdsasسشس";
    newQuestion.numberOne = 0;
    newQuestion.numberTwo = 1;
    newQuestion.numberThree = 1;
    newQuestion.numberFour = 0;

    newQuestion2.text = "asdfadsads";
    newQuestion2.paye = "دهم";
    newQuestion2.book = "ریاضی";
    newQuestion2.chapter = "1";
    newQuestion2.kind = "تست";
    newQuestion2.difficulty = "سخت";
    newQuestion2.grade = 1.2;
    newQuestion2.optionOne = "شیسشس";
    newQuestion2.optionTwo = "asdشیسشس";
    newQuestion2.optionThree = "شیسشsdsdس";
    newQuestion2.optionFour = "شیdsasسشس";
    newQuestion2.numberOne = 1;

    newQuestion3.text = "شمیسنب شیسنتب شمنیستب منشسیتب شمنیستب شیمنس شنمسی  شمیسنش ";
    newQuestion3.paye = "دهم";
    newQuestion3.book = "ریاضی";
    newQuestion3.chapter = "1";
    newQuestion3.kind = "پاسخ کوتاه";
    newQuestion3.difficulty = "سخت";
    newQuestion3.grade = 1.2;
    newQuestion3.answerString = "مدار ماه";

    newQuestion4.text = "شمیسنب شیسنتب شمنیستب منشسیتب شمنیستب شیمنس شنمسی  شمیسنش ";
    newQuestion4.paye = "دهم";
    newQuestion4.book = "ریاضی";
    newQuestion4.chapter = "1";
    newQuestion4.kind = "تشریحی";
    newQuestion4.difficulty = "سخت";
    newQuestion4.grade = 1.2;
    newQuestion4.answerString = "مدار ماه";

    // newQuestion.optionOne = "شیسشس";
    // newQuestion.optionTwo = "asdشیسشس";
    // newQuestion.optionThree = "شیسشsdsdس";
    // newQuestion.optionFour = "شیdsasسشس";

    // UserAnswerTest userAnswerTest = new UserAnswerTest();
    // userAnswerTest.userChoice = -1;
    // question.userAnswer = userAnswerTest;
    // UserAnswerMultipleChoice userAnswerMultipleChoice = new UserAnswerMultipleChoice();
    // question.userAnswer = userAnswerMultipleChoice;
    // userAnswerMultipleChoice.userChoices = [1,2];

    userAnswerShort = new UserAnswerShort();
    userAnswerShort.answerText = "مدار زمین";
  //  question.userAnswer = userAnswerShort;

    userAnswerTest = new UserAnswerTest();
   // userAnswerTest.userChoice = 1;

    userAnswerMultipleChoice = new UserAnswerMultipleChoice();
    userAnswerMultipleChoice.userChoices..add(1)..add(2);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Starter Template",
      home: Scaffold(
        body: Center(child: SizedBox(height: 350,child: Card(child: QuestionViewInReviewExam(question: newQuestion3,userAnswer: userAnswerShort,)))),
      )
    );
  }
}
