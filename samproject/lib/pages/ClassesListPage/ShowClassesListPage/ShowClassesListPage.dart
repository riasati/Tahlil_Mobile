import 'package:flutter/material.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/TopOfPage.dart';

import 'MiddleOfPage.dart';

class ClassesList extends StatefulWidget {
  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0 ),
            child: PersonInfo()
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: CreateOrJoinClass(),
          ),
          Container(color: Colors.white,),
        ],
      ),
    );
  }
}
