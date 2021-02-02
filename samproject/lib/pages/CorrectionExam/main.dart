import 'package:flutter/material.dart';
import 'package:samproject/pages/CorrectionExam/StudentList.dart';
import 'package:samproject/pages/addQuestionPage.dart';
import 'package:samproject/pages/createExamPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Starter Template",
      home: StudentList("string"),
    );
  }
}
