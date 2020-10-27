import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/homePage.dart';

class BottomNavigator extends StatefulWidget {
  static int customIcon = 2;
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 50,
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Icon(
                      FontAwesomeIcons.userAlt,
                      size: 40,
                      color: BottomNavigator.customIcon == 0
                          ?Colors.deepPurple
                          :Colors.white,
                    ),
                    onPressed: _pressProfileIcon,
                  ),
                  MaterialButton(
                    child: Icon(
                      Icons.supervised_user_circle_outlined ,
                      size: 40,
                      color: BottomNavigator.customIcon == 1
                          ?Colors.deepPurple
                          :Colors.white,
                    ),
                    onPressed: _pressProfileIcon,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    child: Icon(
                      Icons.supervised_user_circle_outlined ,
                      size: 40,
                      color: BottomNavigator.customIcon == 3
                          ?Colors.deepPurple
                          :Colors.white,
                    ),
                    onPressed: _pressProfileIcon,
                  ),
                  MaterialButton(
                    child: Icon(
                      Icons.supervised_user_circle_outlined ,
                      size: 40,
                      color: BottomNavigator.customIcon == 4
                          ?Colors.deepPurple
                          :Colors.white,
                    ),
                    onPressed: _pressProfileIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                // Theme.Colors.loginGradientEnd,
                // Theme.Colors.loginGradientStart
                Colors.teal,
                Colors.blue,
              ],
              begin: const FractionalOffset(0.2, 0.2),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
      );
  }

  void _pressProfileIcon() {
    HomePage.homePageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
