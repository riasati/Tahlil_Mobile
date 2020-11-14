import 'package:auto_size_text/auto_size_text.dart';
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
    var classCardIcon;
    if(classCard.className.contains("ریاضی"))
      classCardIcon = Padding(
        child: Icon(
          FontAwesomeIcons.infinity,
          size: 50,
          color: Color(0xFF3D5A80),
        ),
        padding: EdgeInsets.only(right: 10),
      );
    else if(classCard.className.contains("فیزیک"))
      classCardIcon = Icon(
        FontAwesomeIcons.atom,
        size: 50,
        color: Color(0xFF3D5A80),
      );
    else if(classCard.className.contains("شیمی"))
      classCardIcon = Icon(
        FontAwesomeIcons.flask,
        size: 50,
        color: Color(0xFF3D5A80),
      );
    else
      classCardIcon = Padding(
        child: Icon(
          FontAwesomeIcons.chalkboard,
          size: 50,
          color: Color(0xFF3D5A80),
        ),
        padding: EdgeInsets.only(right: 10),
      );
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
                child: classCardIcon,
                alignment: Alignment.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: AutoSizeText(
                  classCard.className,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    classCard.ownerFullName + " :استاد"  ,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
