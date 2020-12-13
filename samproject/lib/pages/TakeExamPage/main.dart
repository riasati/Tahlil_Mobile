import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/TakeExamPage/QuestionView.dart';
import 'package:samproject/pages/TakeExamPage/TakeExamPage.dart';
import 'package:samproject/pages/TakeExamPage/timer.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'BottomNavigator.dart';
//TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 40)),EndTimerFunction: (){print("hello");},),
//TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 20)),EndTimerFunction: (){print("hello");},),
//TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 1,EndExam: DateTime.now().add(Duration(minutes: 2)),EndTimerFunction: (){print("hello");},),

void main() {
  runApp(
      TakeExamPage()
  //     MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: Scaffold(
  //     // body: Column(
  //     //   children: [
  //     //     Container(height: 50,child: Text("asdfads"),),
  //     //     TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 40)),EndTimerFunction: (){print("hello");},),
  //     //     TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 20)),EndTimerFunction: (){print("hello");},),
  //     //     TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 1,EndExam: DateTime.now().add(Duration(minutes: 2)),EndTimerFunction: (){print("hello");},),
  //     //   ],
  //     // ),
  //     body: HHH(),
  //     bottomNavigationBar: BottomNavigator(),
  //   ),
  // )

  );
}
class HHH extends StatefulWidget {
  @override
  _HHHState createState() => _HHHState();
}

class _HHHState extends State<HHH> {
  Question newQuestion = new Question();
  Question newQuestion2 = new Question();
  Question newQuestion3 = new Question();
  Question newQuestion4 = new Question();
  @override
  void initState() {
    super.initState();
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

    newQuestion3.text = "شمیسنب شیسنتب شمنیستب منشسیتب شمنیستب شیمنس شنمسی  شمیسنش ";
    newQuestion3.paye = "دهم";
    newQuestion3.book = "ریاضی";
    newQuestion3.chapter = "1";
    newQuestion3.kind = "پاسخ کوتاه";
    newQuestion3.difficulty = "سخت";
    newQuestion3.grade = 1.2;

    newQuestion4.text = "شمیسنب شیسنتب شمنیستب منشسیتب شمنیستب شیمنس شنمسی  شمیسنش ";
    newQuestion4.paye = "دهم";
    newQuestion4.book = "ریاضی";
    newQuestion4.chapter = "1";
    newQuestion4.kind = "تشریحی";
    newQuestion4.difficulty = "سخت";
    newQuestion4.grade = 1.2;

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 50,child: Text("asdfasd"),),
        Card(
          child: SingleChildScrollView(child: QuestionViewInTakeExam(question: newQuestion4,)),
        )

      ],
    );
  }
}
