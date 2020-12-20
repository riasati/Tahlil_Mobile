import 'package:flutter/material.dart';
import 'package:samproject/pages/insidClass/ClassExams.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Starter Template",
      home: ClassExams(),
    );
  }
}