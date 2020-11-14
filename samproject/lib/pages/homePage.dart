import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:samproject/Layout/BottomNavigator.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/ClassesListPage/LoginPersonPage/LoginOrSignup.dart';
import 'package:samproject/widgets/drawerWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ClassesListPage/ShowClassesListPage/ClassesList.dart';

class HomePage extends StatefulWidget {
  static Person user = Person();
  static final PageController homePageController = PageController(
    initialPage: 2,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
      ),
      endDrawer: DrawerWidget(toggleCoinCallback: stopLoading,),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: Container(
        child: Center(
          child: FloatingActionButton(
            child: Center(
              child: Icon(
                FontAwesomeIcons.home,
              ),
            ),
            backgroundColor: BottomNavigator.customIcon == 2
                ?Color(0xFF3D5A80)
                :Colors.black,
            onPressed: _pressHomeButton,
          ),
        ),
        width: 60 / responsiveDivision,
        height: 60 / responsiveDivision,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            else if (i == 3) {
              setState(() {
                BottomNavigator.customIcon = 3;
              });
            }
            else if (i == 4) {
              setState(() {
                BottomNavigator.customIcon = 4;
              });
            }
          },
          children: [
            Container(color: Colors.red,),
            Container(color: Colors.deepPurple,),
            HomePage.user.username != null?ClassesList():LoginOrSignup(toggleCoinCallback: stopLoading,),
            Container(color: Colors.yellow,),
            Container(color: Colors.black,),

          ],
        ),
        isLoading: _isLoading,
      ),
    );
  }

  void _pressHomeButton() {
    HomePage.homePageController.animateToPage(2,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
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
