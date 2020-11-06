import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ClassDescription extends StatefulWidget {
  @override
  _ClassDescriptionState createState() => _ClassDescriptionState();
}

class _ClassDescriptionState extends State<ClassDescription> {
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
              maxLines: 4,
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
                    FontAwesomeIcons.fileSignature,
                    // FontAwesomeIcons.envelope,
                    color: Colors.black,
                  ),
                  labelText: 'توضیحات',
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
