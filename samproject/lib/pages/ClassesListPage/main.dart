import 'package:flutter/material.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/LoginButton.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/SignupButton.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/ClassCard.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/TopOfPage.dart';
import 'package:samproject/pages/homePage.dart';

import 'ShowClassesListPage/BottomOfPage.dart';
import 'ShowClassesListPage/ShowClassesListPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starter Template',
      home: Scaffold(
        body: Center(child: ListOfClasses()),
      ),
    );
  }
}
