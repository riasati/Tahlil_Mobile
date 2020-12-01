import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/ClassCard.dart';
import 'package:samproject/pages/addQuestionPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/insidClass/ClassMembers.dart';
//import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';

import 'InsidClassPage.dart';
import 'classInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController classTitleController = TextEditingController();
  String _selectionGrade;

  @override
  Widget build(BuildContext context) {
    Class c = Class("", "" , "" , true);
    return MaterialApp(
      home: Scaffold(
        body: Center(child:
        Marquee(
          text: 'Some sample text that takes some space.',
          style: TextStyle(fontWeight: FontWeight.bold),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 100.0,
          pauseAfterRound: Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        )),
      ),
    );
  }

  Widget _ClassGrade(){
    return PopupMenuButton<String>(
      onSelected: (String value) {
      },
      child: Icon(
        FontAwesomeIcons.angleDown,
        color: Colors.red,
        //size: 1,
        // onPressed: () {
        //   print('Hello world');
        // },
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          child: FlatButton(child: Text('حذف کاربر')),
        ),
      ],
    );
  }
}
