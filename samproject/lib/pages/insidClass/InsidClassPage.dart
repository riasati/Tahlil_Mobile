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

import 'ClassExams.dart';
import 'ClassNotification.dart';
import 'EditAndCreateExamButtons.dart';

class InsidClassPage extends StatefulWidget {
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
  }

  @override
  Widget build(BuildContext context) {
    var editAndCreateExamButtons;
    if(InsidClassPage.isAdmin)
      editAndCreateExamButtons = Expanded(child: EditAndCreateExamButtons(toggleCoinCallback: insideClassSetState,));
    else
      editAndCreateExamButtons = Container();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoadingOverlay(
          child: Container(
            color: Colors.black45.withOpacity(0.3),
            child: Column(
              children: [
                Expanded(child: ClassInfoCard(toggleCoinCallback: navigatorPop,), flex: 4,),
                editAndCreateExamButtons,
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(child: ClassMembers(toggleCoinCallback: insideClassSetState,)),
                      Expanded(child: ClassExams(toggleCoinCallback: insideClassSetState,)),
                    ],
                  ),
                ),
                Expanded(child: ClassNotification(toggleCoinCallback: insideClassSetState,), flex: 3,),
              ],
            ),
          ),
          isLoading: InsidClassPage.isLoading,
        ),
        ),
      );
  }

  void _getClassInformation() async{
    setState(() {
      InsidClassPage.isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        // var queryParam = {
        //   'classId': classId,
        // };
        // var url = Uri.http(_getClassInfoURL, "/class", queryParam);
        // print(url);
        var url = _getClassInfoURL  + classId;
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        print(classId);
        var userClassesInfo = json.decode(utf8.decode(response.bodyBytes))["Class"];
        InsidClassPage.currentClass = Class(userClassesInfo["name"], "", userClassesInfo["classId"] , false);
        InsidClassPage.currentClass.classDescription = userClassesInfo["description"];
        if(InsidClassPage.currentClass.classDescription == null)
          InsidClassPage.currentClass.classDescription = "";
        var adminInfo = userClassesInfo["admin"];
        InsidClassPage.admin.firstname = adminInfo["firstname"];
        InsidClassPage.admin.lastname = adminInfo["lastname"];
        InsidClassPage.currentClass.ownerFullName = adminInfo["firstname"] + " " + adminInfo["lastname"];
        InsidClassPage.admin.avatarUrl = adminInfo["avatar"];
        InsidClassPage.admin.email = adminInfo["email"];
        if(HomePage.user.email == InsidClassPage.admin.email)
          InsidClassPage.isAdmin = true;
        else
          InsidClassPage.isAdmin = false;
        print(InsidClassPage.currentClass);
        print(userClassesInfo);
      }
    }on Exception catch(e){
      print(e.toString());
    }
    setState(() {
      InsidClassPage.isLoading = false;
    });
  }

  void insideClassSetState(){
    setState(() {
    });
  }

  void navigatorPop(){
    Navigator.pop(context);
  }
}