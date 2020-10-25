import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigator extends StatefulWidget {
  static int customIcon = 2;
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue[200],
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
      ),
    );
  }

  void _pressProfileIcon() {
    setState(() {
      BottomNavigator.customIcon = 0;
    });
  }
}
