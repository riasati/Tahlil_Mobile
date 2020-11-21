import 'package:flutter/material.dart';


class EditAndCreateExamButtons extends StatefulWidget {
  @override
  _EditAndCreateExamButtonsState createState() => _EditAndCreateExamButtonsState();
}

class _EditAndCreateExamButtonsState extends State<EditAndCreateExamButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: EditButton(),
          ),
          Expanded(
            child: CreateExamButton(),
          ),

        ],
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Widget EditButton() {
    Gradient _gradient =
    LinearGradient(colors: [Color(0xFF3D5A80), Color(0xFF3D5A80)]);
    return Container(
      width: double.infinity,
      height: 40,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(40.0)),
              gradient: _gradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ]),
          child: Material(
            color: Colors.transparent,
            borderRadius: new BorderRadius.all(Radius.circular(40.0)),
            child: FlatButton(
                //
                child: Text(
                  "ویرایش کلاس",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
      ),
    );

  }

  // ignore: non_constant_identifier_names
  Widget CreateExamButton() {
    Gradient _gradient = LinearGradient(colors: [Color.fromRGBO(14, 145, 140, 1), Color.fromRGBO(14, 145, 140, 1)]);
    return Container(
      width: double.infinity,
      height: 40,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(40.0)),
              gradient: _gradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ]),
          child: Material(
            color: Colors.transparent,
            borderRadius: new BorderRadius.all(Radius.circular(40.0)),
            child: FlatButton(
              //onPressed: ,
                child: Center(
                  child: Text(
                    "ساخت آزمون",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
