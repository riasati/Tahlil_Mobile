import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/TopOfPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomOfPage.dart';
import 'MiddleOfPage.dart';

class ClassesList extends StatefulWidget {
  final stopHomePageLoading;

  ClassesList( {@required void stopLoading() }):
        stopHomePageLoading = stopLoading;

  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {

  List<Class> userClasses = [];
  String _getClassesURL = "http://parham-backend.herokuapp.com/user/classes";

  @override
  void initState() {
    super.initState();
    _getUserClasses();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 15.0 ),
              child: PersonInfo()
            ),
          ),
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
    );
  }


  void _getUserClasses() async {
    print("hslkhflskhfshfkljha");
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
          userClasses.add(Class(userClass["name"], userClass["ownerFullname"], userClass["classId"]));
        }
        for(var user in userClasses)
          print(user);
      }
    }on Exception catch(e){
      print(e.toString());
    }
    widget?.stopHomePageLoading();
  }

  void resultOfCreateClass(Class newClass, bool status){
    if(!status){
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
    else{
      setState(() {
        userClasses.add(newClass);
        Alert(
          context: context,
          type: AlertType.success,
          title: "کلاس ساخته شد",
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

  void callSetState(){
    setState(() {
    });
  }


}
