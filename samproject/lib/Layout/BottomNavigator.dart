import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/homePage.dart';

class BottomNavigator extends StatefulWidget {
  static int customIcon = 1;

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
                      FontAwesomeIcons.questionCircle,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 0
                          ? Color(0xFF3D5A80)
                          : Colors.black,
                    ),
                    onPressed: _pressCrateQuestionIcon,
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
                      FontAwesomeIcons.chalkboard,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 1
                          ? Color(0xFF3D5A80)
                          : Colors.black,
                    ),
                    onPressed: _pressClassListIcon,
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
                      FontAwesomeIcons.university,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 2
                          ? Color(0xFF3D5A80)
                          : Colors.black,
                    ),
                    onPressed: _pressQuestionBankIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pressCrateQuestionIcon() {
    HomePage.homePageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _pressClassListIcon() {
    HomePage.homePageController.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _pressQuestionBankIcon() {
    HomePage.homePageController.animateToPage(2,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
