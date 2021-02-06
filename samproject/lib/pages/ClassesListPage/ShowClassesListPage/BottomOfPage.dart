
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/pages/ClassesListPage/ShowClassesListPage/ClassCard.dart';

class ListOfClasses extends StatefulWidget {
  List<Class> userClasses = [];
  ListOfClasses(this.userClasses);

  @override
  _ListOfClassesState createState() => _ListOfClassesState(userClasses);
}

class _ListOfClassesState extends State<ListOfClasses> {
  List<Class> userClasses = [];
  _ListOfClassesState(this.userClasses);

  @override
  Widget build(BuildContext context) {
    if(userClasses.length == 0){
      return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                child: Icon(
                  FontAwesomeIcons.frown,
                ),
                padding: EdgeInsets.only(top: 100),
              ),
              Text(
                  "شما در کلاسی حضور ندارید",
              )
            ],
          ),
      );
    }
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 15, right: 15, left: 15),
        child: GridView.count(
            crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          children: List.generate(userClasses.length, (int position) =>  ClassCard(userClasses[position])),
        ),
      ),
    );
  }
}
