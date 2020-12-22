import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/editProfilePage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/insidClass/ClassMembers.dart';
import 'package:samproject/pages/insidClass/classInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNavigator.dart';
import 'ClassExams.dart';
import 'ClassNotification.dart';
import 'EditAndRemoveButtons.dart';

class InsidClassPage extends StatefulWidget {
  static final PageController insideClassPageController = PageController(
    initialPage: 3,
  );
  static Class currentClass = Class("", "", "", false);
  static Person admin = Person();
  static bool isLoading = true;
  static bool isAdmin = false;
  final String classId;


  InsidClassPage(this.classId);

  @override
  _InsidClassPageState createState() => _InsidClassPageState(classId);
}

class _InsidClassPageState extends State<InsidClassPage> {
  String _getClassInfoURL = "http://parham-backend.herokuapp.com/class/";
  String classId;


  _InsidClassPageState(this.classId);

  @override
  void initState() {
    super.initState();
    _getClassInformation();
    BottomNavigator.customIcon = 3;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigator(),
        body: LoadingOverlay(
          child: PageView(
          controller: InsidClassPage.insideClassPageController,
          onPageChanged: (i) {
            if (i == 0) {
              setState(() {
                BottomNavigator.customIcon = 0;
              });
            } else if (i == 1) {
              setState(() {
                BottomNavigator.customIcon = 1;
              });
            }
            else if (i == 2) {
              setState(() {
                BottomNavigator.customIcon = 2;
              });
            }
            else if (i == 3) {
              setState(() {
                BottomNavigator.customIcon = 3;
              });
            }
          },
          children: [
            ClassExams(toggleCoinCallback: insideClassSetState),
            Container(color: Colors.red,),//notification
            ClassMembers(toggleCoinCallback: insideClassSetState),
            ClassInfoCard(toggleCoinCallback: insideClassSetState)

          ],
          ),
          isLoading: InsidClassPage.isLoading,
        ),
    ),);
  }

  void _getClassInformation() async {
    setState(() {
      InsidClassPage.currentClass.classId = "";
      InsidClassPage.isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _getClassInfoURL + classId;
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        print(classId);
        var userClassesInfo = json.decode(
            utf8.decode(response.bodyBytes))["Class"];
        InsidClassPage.currentClass = Class(
            userClassesInfo["name"], "", userClassesInfo["classId"], false);
        InsidClassPage.currentClass.classDescription =
        userClassesInfo["description"];
        if (InsidClassPage.currentClass.classDescription == null)
          InsidClassPage.currentClass.classDescription = "";
        var adminInfo = userClassesInfo["admin"];
        InsidClassPage.admin.firstname = adminInfo["firstname"];
        InsidClassPage.admin.lastname = adminInfo["lastname"];
        InsidClassPage.currentClass.ownerFullName =
            adminInfo["firstname"] + " " + adminInfo["lastname"];
        InsidClassPage.admin.avatarUrl = adminInfo["avatar"];
        InsidClassPage.admin.email = adminInfo["email"];
        if (HomePage.user.email == InsidClassPage.admin.email)
          InsidClassPage.isAdmin = true;
        else
          InsidClassPage.isAdmin = false;
        print(InsidClassPage.currentClass);
        print(userClassesInfo);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    setState(() {
      InsidClassPage.isLoading = false;
    });
  }

  void insideClassSetState() {
    setState(() {});
  }

  void navigatorPop() {
    Navigator.pop(context);
  }


}
