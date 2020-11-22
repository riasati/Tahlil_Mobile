import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/editProfilePage.dart';
import 'package:samproject/pages/insidClass/ClassMembers.dart';
import 'package:samproject/pages/insidClass/classInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ClassExams.dart';
import 'ClassNotification.dart';
import 'EditAndCreateExamButtons.dart';

class InsidClassPage extends StatefulWidget {
  final String classId;


  InsidClassPage(this.classId);

  @override
  _InsidClassPageState createState() => _InsidClassPageState(classId);
}

class _InsidClassPageState extends State<InsidClassPage> {
  bool isLoading = true;
  String _getClassInfoURL = "parham-backend.herokuapp.com";
  String classId;
  Class currentClass;
  Person admin;

  _InsidClassPageState(this.classId);

  @override
  void initState() {
    super.initState();
    _getClassInformation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoadingOverlay(
          child: Container(
            color: Colors.black45.withOpacity(0.3),
            child: Column(
              children: [
                Expanded(child: ClassInfoCard(), flex: 3,),
                Expanded(
                    child: EditAndCreateExamButtons(),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(child: ClassMembers()),
                      Expanded(child: ClassExams()),
                    ],
                  ),
                ),
                Expanded(child: ClassNotification(), flex: 3,),
              ],
            ),
          ),
          isLoading: isLoading,
        ),
        appBar: AppBar(
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

  void _getClassInformation() async{
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var queryParam = {
          'classId': classId,
        };
        var url = Uri.http(_getClassInfoURL, "/class", queryParam);
        print(url);
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        print(response.statusCode);
        var userClassesInfo = json.decode(utf8.decode(response.bodyBytes));
        print(userClassesInfo);
        currentClass = Class(userClassesInfo["name"], "", userClassesInfo["classId"]);
        currentClass.classDescription = userClassesInfo["description"];
        var adminInfo = userClassesInfo["admin"];
        admin.firstname = adminInfo["firstname"];
        admin.lastname = adminInfo["lastname"];
        admin.avatarUrl = adminInfo["avatar"];
        admin.email = adminInfo["email"];
        ClassInfoCard.className = currentClass.className;
        ClassInfoCard.adminFullName = admin.firstname + " " + admin.lastname;
        print(ClassInfoCard.className + " " + ClassInfoCard.adminFullName);
        print(currentClass);
        print(admin);

      }
    }on Exception catch(e){
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
}
