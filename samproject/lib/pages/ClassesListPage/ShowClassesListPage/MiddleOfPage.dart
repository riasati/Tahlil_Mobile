import 'package:flutter/material.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/CreateClassButton.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/JoinClassButton.dart';

class CreateOrJoinClass extends StatefulWidget {
  final classListWidgetSetState;
  List<Class> userClasses;

  CreateOrJoinClass( {@required void classListWidgetSetState() , @required this.userClasses}):
        classListWidgetSetState = classListWidgetSetState;

  @override
  _CreateOrJoinClassState createState() => _CreateOrJoinClassState(classListWidgetSetState: classListWidgetSetState, userClasses: userClasses);
}

class _CreateOrJoinClassState extends State<CreateOrJoinClass> {
  final classListWidgetSetState;
  List<Class> userClasses;

  _CreateOrJoinClassState( {@required void classListWidgetSetState() , @required this.userClasses}):
        classListWidgetSetState = classListWidgetSetState;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: JoinButton(classListWidgetSetState: classListWidgetSetState, userClasses: userClasses,),
          ),
          Expanded(
            child: CreateClassButton(classListWidgetSetState: classListWidgetSetState, userClasses: userClasses,),
          ),

        ],
      ),
    );
  }
}
