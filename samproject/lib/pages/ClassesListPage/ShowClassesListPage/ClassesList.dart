import 'package:flutter/material.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/TopOfPage.dart';

import 'BottomOfPage.dart';
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
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 15.0 ),
              child: PersonInfo()
            ),
          ),
          Expanded(
            flex: 1,
            child: CreateOrJoinClass(),
          ),
          Expanded(
            flex: 4,
            child: ListOfClasses(),
          ),
        ],
      ),
      // color: Colors.black45,
    );
  }
}
