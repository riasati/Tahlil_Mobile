import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/domain/Class.dart';

class ClassCard extends StatefulWidget {
  Class classCard;

  ClassCard(this.classCard);

  @override
  _ClassCardState createState() => _ClassCardState(classCard);
}

class _ClassCardState extends State<ClassCard> {
  Class classCard;

  _ClassCardState(this.classCard);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      //color: Colors.black45,
      child: FlatButton(
        onPressed: () {},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  FontAwesomeIcons.atom,
                  size: 50,
                  color: Color(0xFF3D5A80),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  classCard.className,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
