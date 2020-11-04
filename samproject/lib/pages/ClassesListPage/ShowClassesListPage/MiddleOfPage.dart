import 'package:flutter/material.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/CreateClassButton.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/JoinClassButton.dart';

class CreateOrJoinClass extends StatefulWidget {
  @override
  _CreateOrJoinClassState createState() => _CreateOrJoinClassState();
}

class _CreateOrJoinClassState extends State<CreateOrJoinClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: JoinButton(),
          ),
          Expanded(
            child: CreateClassButton(),
          ),

        ],
      ),
    );
  }
}
