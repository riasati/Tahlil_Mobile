import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

enum classGrades { Ten, Eleven, Twelve }

class ClassGrade extends StatefulWidget {
  @override
  _ClassGradeState createState() => _ClassGradeState();
}

class _ClassGradeState extends State<ClassGrade> {
  classGrades _grade = classGrades.Ten;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('Show Alert Dialog'),
        color: Colors.red,
        onPressed: () => _displayGradeForm()
      ),
    );
  }

  Widget _displayGradeForm() {
    return AlertDialog(
      title: Text('RadioButton'),
      content: Column(children: [
        RadioListTile(
          title: Text("پایه دهم"),
          groupValue: _grade,
          value: classGrades.Ten,
          onChanged: (classGrades val) {
            Navigator.of(context).pop();
            setState(() {
              _grade = val;
            });
          },
        ),
        RadioListTile(
          title: Text("پایه یازدهم"),
          groupValue: _grade,
          value: classGrades.Eleven,
          onChanged: (classGrades val) {
            setState(() {
              _grade = val;
            });
          },
        ),
        RadioListTile(
          title: Text("پایه دوازدهم"),
          groupValue: _grade,
          value: classGrades.Twelve,
          onChanged: (classGrades val) {
            setState(() {
              _grade = val;
            });
          },
        ),
      ]),
      actions: <Widget>[
        new FlatButton(
          child: new Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  //
  // Widget _three(){
  //   return PopupMenuButton(
  //       itemBuilder: (context){
  //         var
  //       }
  //   );
  // }


}
