
import 'package:flutter/material.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/ClassCard.dart';

class ListOfClasses extends StatefulWidget {
  @override
  _ListOfClassesState createState() => _ListOfClassesState();
}

class _ListOfClassesState extends State<ListOfClasses> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black45,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.count(
            crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          children: List.generate(10, (int position) =>  ClassCard()),
        ),
      ),
    );
  }
}
