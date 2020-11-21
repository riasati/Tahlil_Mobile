import 'package:flutter/material.dart';
import 'package:samproject/pages/editProfilePage.dart';
import 'package:samproject/pages/insidClass/ClassMembers.dart';
import 'package:samproject/pages/insidClass/classInfo.dart';

import 'ClassExams.dart';
import 'ClassNotification.dart';
import 'EditAndCreateExamButtons.dart';

class InsidClassPage extends StatefulWidget {
  @override
  _InsidClassPageState createState() => _InsidClassPageState();
}

class _InsidClassPageState extends State<InsidClassPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45.withOpacity(0.3),
      child: Column(
        children: [
          Expanded(child: ClassInfoCard(), flex: 3,),
          Expanded(
              child: EditAndCreateExamButtons(),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(child: ClassMembers()),
                Expanded(child: ClassExams()),
              ],
            ),
          ),
          Expanded(child: ClassNotification(), flex: 3,),
        ],
      ),
    );
  }
}
