import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClassCard extends StatefulWidget {
  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: FlatButton(
        onPressed: (){},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(FontAwesomeIcons.school,size: 50,color:Color(0xFF3D5A80)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "اسم کلاس",

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
