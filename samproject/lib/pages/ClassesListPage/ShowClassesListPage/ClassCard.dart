import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/domain/Class.dart';
import 'package:samproject/pages/homePage.dart';

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
    var customIcon;
    var classOwnerName;
    if(classCard.className.contains("ریاضی"))
      customIcon = Padding(
        child: Icon(
          FontAwesomeIcons.infinity,
          size: 50,
          color: Color(0xFF3D5A80),
        ),
        padding: EdgeInsets.only(right: 10),
      );
    else if(classCard.className.contains("فیزیک"))
      customIcon = Icon(
        FontAwesomeIcons.atom,
        size: 50,
        color: Color(0xFF3D5A80),
      );
    else if(classCard.className.contains("شیمی"))
      customIcon = Icon(
        FontAwesomeIcons.flask,
        size: 50,
        color: Color(0xFF3D5A80),
      );
    else
      customIcon = Padding(
        child: Icon(
          FontAwesomeIcons.chalkboard,
          size: 50,
          color: Color(0xFF3D5A80),
        ),
        padding: EdgeInsets.only(right: 10),
      );

    if(!(classCard.ownerFullName == null || classCard.ownerFullName == "**** ****"))
      classOwnerName = Padding(
        padding: EdgeInsets.only(top: 8),
        child: Container(
          alignment: Alignment.centerRight,
          child: AutoSizeText(
            "استاد:" + classCard.ownerFullName,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    else
      classOwnerName = Container();

    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      //color: Colors.black45,
      child: FlatButton(
        onPressed: () {},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: customIcon,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, bottom: 30),
                      child: Container(
                        child: Icon(FontAwesomeIcons.medal, color: Colors.yellow,),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: AutoSizeText(
                  classCard.className,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              classOwnerName,
            ],
          ),
        ),
      ),
    );
  }
}
