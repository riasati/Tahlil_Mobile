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
      //color: Color(0xFF3D5A80),
      child: FractionallySizedBox(
        //heightFactor: 0.5,
        widthFactor: 0.8,
        child: Card(
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
                      FontAwesomeIcons.flask,
                      size: 50,
                      color: Color(0xFF3D5A80),
                    ),
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: AutoSizeText(
                      "شیمی دهم",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Container(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "استاد: حمیدرضا آذرباد",
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Padding(
//   padding: EdgeInsets.only(right: 30),
//   child: Container(
//     decoration: BoxDecoration(
//       borderRadius: new BorderRadius.all(Radius.circular(40.0)),
//       color: Colors.green,
//     ),
//     child: FlatButton(
//       textColor: Colors.white,
//       child: Text(
//         "ویرایش",
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//     ),
//   ),
// )

// FractionallySizedBox(
// widthFactor: 0.5,
// child: Container(
// decoration: BoxDecoration(
// borderRadius: new BorderRadius.all(Radius.circular(50.0)),
// color: Colors.deepPurple,
// ),
// child: Padding(
// child: Icon(
// FontAwesomeIcons.flask,
// size: 50,
// color: Colors.white,
// ),
// padding: EdgeInsets.only(top: 5, bottom: 5),
// ),
// alignment: Alignment.center,
// ),
// ),