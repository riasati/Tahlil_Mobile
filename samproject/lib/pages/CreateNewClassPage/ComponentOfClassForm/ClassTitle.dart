import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClassTitle extends StatefulWidget {
  @override
  _ClassTitleState createState() => _ClassTitleState();
}

class _ClassTitleState extends State<ClassTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              textAlign: TextAlign.right,
              maxLines: 1,
              // focusNode: myFocusNodeEmailLogin,
              // controller: loginUsernameController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Color(0xFF3D5A80) , width: 3)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3D5A80)),
                ),
                suffixIcon: Icon(
                  FontAwesomeIcons.chalkboard,
                  color: Colors.black,
                ),
                labelText: 'عنوان کلاس',
                labelStyle: TextStyle(
                  color: Color(0xFF3D5A80)
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
