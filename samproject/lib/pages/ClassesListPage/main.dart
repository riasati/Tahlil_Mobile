import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/LoginButton.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/SignupButton.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/ClassCard.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/TopOfPage.dart';
import 'package:samproject/pages/homePage.dart';

import 'ShowClassesListPage/BottomOfPage.dart';
import 'ShowClassesListPage/ClassesList.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Starter Template',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF3D5A80),
          ),
          body: FlatButton(
            child: Text(
              "click"
            ),
            onPressed: showAlert,
          )
        )
    );
  }

  void showAlert() {
    setState(() {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ساخت کلاس با موفقیت انجام نشد",
        buttons: [
          DialogButton(
            child: Text(
              "حله",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color(0xFF3D5A80),
          ),
        ],
      ).show();
    });
  }
}
