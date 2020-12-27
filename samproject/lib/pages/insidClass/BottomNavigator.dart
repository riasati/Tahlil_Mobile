import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';

class BottomNavigator extends StatefulWidget {
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
        height: 60,
        child: TabBar(
          labelColor: Color(0xFF3D5A80),
          unselectedLabelColor: Colors.black,
          indicatorColor: Color(0xFF3D5A80),
          labelPadding: EdgeInsets.all(1),
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            Tab(
              icon: Icon(FontAwesomeIcons.solidEdit),
              text: "آزمون",
              iconMargin: EdgeInsets.only(left: 5),
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.bell,),
              text: "اعلان",
              iconMargin: EdgeInsets.only(left: 5),
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.users,),
              text: "اعضا",
              iconMargin: EdgeInsets.only(right: 5),
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.infoCircle,),
              text: "اطلاعات",
              iconMargin: EdgeInsets.only(left: 5),
            ),
          ],
        ),
      ),
    );
  }

}
