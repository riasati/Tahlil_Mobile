import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ClassInfoCard extends StatefulWidget {
  @override
  _ClassInfoCardState createState() => _ClassInfoCardState();
}

class _ClassInfoCardState extends State<ClassInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: AutoSizeText(
              "شیمی دهم",
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
                "استاد: حمیدرضا آذرباد",
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
    );
  }
}
