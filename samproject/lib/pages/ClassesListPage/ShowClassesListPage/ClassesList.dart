import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/TopOfPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomOfPage.dart';
import 'MiddleOfPage.dart';

class ClassesList extends StatefulWidget {


  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {
  bool isLoading = true;
  List<Class> userClasses = [];
  String _getClassesURL = "http://parham-backend.herokuapp.com/user/classes";

  @override
  void initState() {
    super.initState();
    _getUserClasses();
  }
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Container(
        color: Colors.black45.withOpacity(0.1),
        child: Column(
          children: <Widget>[
            // Expanded(
            //   flex: 2,
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 15.0 ),
            //     child: PersonInfo()
            //   ),
            // ),
            Expanded(
              flex: 1,
              child: CreateOrJoinClass(classListWidgetSetState: callSetState, userClasses: userClasses,),
            ),
            Expanded(
              flex: 4,
              child: ListOfClasses(userClasses),
            ),
          ],
        ),
        // color: Colors.black45,
      ),
      isLoading: isLoading,
    );
  }


  void _getUserClasses() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        final response = await get(_getClassesURL,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        var userClassesJson = json.decode(utf8.decode(response.bodyBytes));
        for(var userClass in userClassesJson["classes"]){
          userClasses.add(Class(userClass["name"], userClass["ownerFullname"], userClass["classId"], userClass["isOwned"]));
        }
        for(var userClass in userClasses)
          print(userClass);
      }
    }on Exception catch(e){
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }


  void callSetState(){
    setState(() {
    });
  }


}
