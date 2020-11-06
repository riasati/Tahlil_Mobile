import 'package:flutter/material.dart';
import 'package:samproject/pages/CreateNewClassPage/ComponentOfClassForm/ClassDescription.dart';
import 'ComponentOfClassForm/ClassTitle.dart';


class ClassForm extends StatefulWidget {
  @override
  _ClassFormState createState() => _ClassFormState();
}

class _ClassFormState extends State<ClassForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClassTitle(),
            ClassDescription(),
          ],
        ),
      ),
    );
  }
}
