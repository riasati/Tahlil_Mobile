import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samproject/pages/TakeExamPage/timer.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'BottomNavigator.dart';
//TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 40)),EndTimerFunction: (){print("hello");},),
//TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 20)),EndTimerFunction: (){print("hello");},),
//TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 1,EndExam: DateTime.now().add(Duration(minutes: 2)),EndTimerFunction: (){print("hello");},),

void main() => runApp(MaterialApp(
  home: Scaffold(
    // body: Column(
    //   children: [
    //     Container(height: 50,child: Text("asdfads"),),
    //     TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 40)),EndTimerFunction: (){print("hello");},),
    //     TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 30,EndExam: DateTime.now().add(Duration(minutes: 20)),EndTimerFunction: (){print("hello");},),
    //     TimerWidget(StartUserExam: new DateTime.now(),ExamLenght: 1,EndExam: DateTime.now().add(Duration(minutes: 2)),EndTimerFunction: (){print("hello");},),
    //   ],
    // ),
    bottomNavigationBar: BottomNavigator(),
  ),
));
