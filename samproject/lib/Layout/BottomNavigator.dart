import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _customIcon = -1;

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
                  MaterialButton(
                    child: Icon(
                      Icons.supervised_user_circle_outlined ,
                      size: 40,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Icon(Icons.supervised_user_circle_outlined , size: 40, color: Colors.deepPurple,),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.supervised_user_circle_outlined),
                  Icon(Icons.supervised_user_circle_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
