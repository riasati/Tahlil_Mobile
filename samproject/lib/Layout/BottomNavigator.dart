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
    double responsiveDivision = MediaQuery.of(context).devicePixelRatio / 1.2;
    return BottomAppBar(
      elevation: 50,
      child: Container(
        height: 80 / responsiveDivision,
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
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 0
                          ?Color(0xFF3D5A80)
                          :Colors.black,
                    ),
                    onPressed: _pressProfileIcon,
                  ),
                  FlatButton(
                    child: Icon(
                      FontAwesomeIcons.userAlt,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 1
                          ?Color(0xFF3D5A80)
                          :Colors.black,
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
                  FlatButton(
                    child: Icon(
                      FontAwesomeIcons.userAlt,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 3
                          ?Color(0xFF3D5A80)
                          :Colors.black,
                    ),
                    onPressed: _pressProfileIcon,
                  ),
                  FlatButton(
                    child: Icon(
                      FontAwesomeIcons.userAlt,
                      size: 50 / responsiveDivision,
                      color: BottomNavigator.customIcon == 4
                          ?Color(0xFF3D5A80)
                          :Colors.black,
                    ),
                    onPressed: _pressProfileIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
        // decoration: new BoxDecoration(
        //   gradient: new LinearGradient(
        //       colors: [
        //         // Theme.Colors.loginGradientEnd,
        //         // Theme.Colors.loginGradientStart
        //         Colors.teal,
        //         Colors.blue,
        //       ],
        //       begin: const FractionalOffset(0.2, 0.2),
        //       end: const FractionalOffset(1.0, 1.0),
        //       stops: [0.0, 1.0],
        //       tileMode: TileMode.clamp),
        // ),
      ),
      );
  }

  void _pressProfileIcon() {
    HomePage.homePageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
