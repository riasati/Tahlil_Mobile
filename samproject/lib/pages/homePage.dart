import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:samproject/Layout/BottomNavigator.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/ClassesListPage/LoginPersonPage/LoginOrSignup.dart';
import 'package:samproject/pages/searchQuestionPage.dart';
import 'package:samproject/widgets/drawerWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ClassesListPage/ShowClassesListPage/ClassesList.dart';
import 'addQuestionPage.dart';

class HomePage extends StatefulWidget {
  static Person user = Person();
  static final PageController homePageController = PageController(
    initialPage: 1,
  );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _signInURL = "https://parham-backend.herokuapp.com/user";
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveDivision = MediaQuery.of(context).devicePixelRatio / 1.2;
    String appBarTitle;
    if( BottomNavigator.customIcon == 0){
      appBarTitle = "ایجاد سوال";
    }else if( BottomNavigator.customIcon == 1 ){
      appBarTitle = "کلاس ها";
    }else{
      appBarTitle = "بانک سوالات";
    }
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Padding(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              appBarTitle,
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
      ),
      endDrawer: DrawerWidget(toggleCoinCallback: stopLoading,),
      bottomNavigationBar: BottomNavigator(),
      body: LoadingOverlay(
        child: PageView(
          controller: HomePage.homePageController,
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
          },
          children: [
            AddQuestionPage(),
            HomePage.user.username != null?ClassesList():LoginOrSignup(toggleCoinCallback: stopLoading,),
            SearchQuestionPage(),

          ],
        ),
        isLoading: _isLoading,
      ),
    );
  }

  void _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        final response = await get(_signInURL,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        if (response.statusCode == 200) {
          final personInfo = jsonDecode(response.body);
          print(personInfo.toString());
          HomePage.user.firstname = personInfo['user']['firstname'];
          HomePage.user.lastname = personInfo['user']['lastname'];
          HomePage.user.username = personInfo['user']['username'];
          HomePage.user.email = personInfo['user']['email'];
          HomePage.user.avatarUrl = personInfo['user']['avatar'];
          setState(() {
            stopLoading();
          });
        }
        else{
          setState(() {
            stopLoading();
          });
        }
      }
      else{
        stopLoading();
      }
    }on Exception catch(e){
      print(e.toString());
      stopLoading();
    }
  }

  stopLoading(){
    setState(() {
      _isLoading = false;
    });
  }

  startLoading(){
    setState(() {
      _isLoading = true;
    });
  }

}
