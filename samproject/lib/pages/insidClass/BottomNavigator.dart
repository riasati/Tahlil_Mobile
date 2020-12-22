import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';

class BottomNavigator extends StatefulWidget {
  static int customIcon = 3;

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    double responsiveDivision = MediaQuery.of(context).devicePixelRatio / 1.2;
    return BottomAppBar(
      elevation: 50,
      child: Container(
        height: 100 / responsiveDivision,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Icon(
                      Icons.question_answer,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 0
                          ? Color(0xFF3D5A80)
                          : Colors.black,
                    ),
                    onPressed: _pressClassExamList,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Icon(
                      FontAwesomeIcons.bell,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 1
                          ? Color(0xFF3D5A80)
                          : Colors.black,
                    ),
                    onPressed: _pressClassNotification,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Icon(
                      FontAwesomeIcons.users,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 2
                          ? Color(0xFF3D5A80)
                          : Colors.black,
                    ),
                    onPressed: _pressClassMembers,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Icon(
                      FontAwesomeIcons.infoCircle,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 3
                          ? Color(0xFF3D5A80)
                          : Colors.black,
                    ),
                    onPressed: _pressClassInfo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pressClassExamList() {
    InsidClassPage.insideClassPageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _pressClassNotification() {
    InsidClassPage.insideClassPageController.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _pressClassMembers() {
    InsidClassPage.insideClassPageController.animateToPage(2,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _pressClassInfo() {
    InsidClassPage.insideClassPageController.animateToPage(3,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
