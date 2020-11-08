import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/CreateNewClassPage/ComponentOfClassForm/ClassGrade.dart';
import 'package:samproject/pages/CreateNewClassPage/CreateClassPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectionGrade;
  String _selectionLesson;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starter Template',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3D5A80),
        ),
        body: CreateClassPage(),
      ),
    );
  }
}
