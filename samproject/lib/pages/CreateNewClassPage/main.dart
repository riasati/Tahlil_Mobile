import 'package:flutter/material.dart';
import 'package:samproject/pages/CreateNewClassPage/CreateClassForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starter Template',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3D5A80),
        ),
        body: CreateClassForm(),
      ),
    );
  }

}