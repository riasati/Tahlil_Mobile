import 'package:flutter/material.dart';

import 'Buttons/GetTitleOfClassButton.dart';

class CreateClassForm extends StatefulWidget {
  @override
  _CreateClassFormState createState() => _CreateClassFormState();
}

class _CreateClassFormState extends State<CreateClassForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/classroom.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleButton(),
        ],
      ),
    );
  }
}
