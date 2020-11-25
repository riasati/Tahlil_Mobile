import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return MaterialApp(
      home: Scaffold(
        body: _ClassGrade(),
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
