import 'package:flutter/material.dart';
import 'package:samproject/pages/addQuestionPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/insidClass/ClassMembers.dart';
//import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';

import 'InsidClassPage.dart';
import 'classInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Starter Template",
      home: Scaffold(body: InsidClassPage(),appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Padding(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Title",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          padding: EdgeInsets.only(left: 20),
        ),
      ),),
    );
  }
}
