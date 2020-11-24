import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';


class ClassInfoCard extends StatefulWidget {
  @override
  _ClassInfoCardState createState() => _ClassInfoCardState();
}

class _ClassInfoCardState extends State<ClassInfoCard> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      padding: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: AutoSizeText(
                InsidClassPage.currentClass.className,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Container(
                alignment: Alignment.center,
                child: AutoSizeText(
                  InsidClassPage.currentClass.ownerFullName,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/classroom.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onPressed: (){
        _showCompleteClassInfo();
      },
    );
  }

  Future<void> _showCompleteClassInfo() async {
    var classIcon;
    if(InsidClassPage.currentClass.className.contains("ریاضی"))
      classIcon = Padding(
        child: Icon(
          FontAwesomeIcons.infinity,
          size: 50,
          color: Color(0xFF3D5A80),
        ),
        padding: EdgeInsets.only(right: 10),
      );
    else if(InsidClassPage.currentClass.className.contains("فیزیک"))
      classIcon = Icon(
        FontAwesomeIcons.atom,
        size: 50,
        color: Color(0xFF3D5A80),
      );
    else if(InsidClassPage.currentClass.className.contains("شیمی"))
      classIcon = Icon(
        FontAwesomeIcons.flask,
        size: 50,
        color: Color(0xFF3D5A80),
      );
    else
      classIcon = Padding(
        child: Icon(
          FontAwesomeIcons.chalkboard,
          size: 50,
          color: Color(0xFF3D5A80),
        ),
        padding: EdgeInsets.only(right: 10),
      );

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: classIcon,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AutoSizeText(
                  "ClassInfoCard.classDescription",
                  style: TextStyle(),
                  textAlign: TextAlign.right,
                ),
                AutoSizeText(':ایمیل استاد' + InsidClassPage.admin.email, style: TextStyle(), textAlign: TextAlign.right,),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     style: ButtonStyle(
          //
          //     ),
          //     child: Text('Approve'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
