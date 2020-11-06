import 'package:flutter/material.dart';
import 'file:///E:/Courses/Term7/Tahlil_Mobile/samproject/lib/pages/CreateNewClassPage/ClassForm.dart';


class CreateClassPage extends StatefulWidget {
  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/classroom.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
        ),
        flex: 1,
      ),
      Expanded(child: ClassForm(),flex: 2,)
    ]);
  }
}
