import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum classGrades { Ten, Eleven, Twelve }

class GradeForm extends StatefulWidget {
  @override
  _GradeFormState createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  classGrades _grade = classGrades.Ten;
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {

  }
}
