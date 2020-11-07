import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClassPassword extends StatefulWidget {
  @override
  _ClassPasswordState createState() => _ClassPasswordState();
}

class _ClassPasswordState extends State<ClassPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            textAlign: TextAlign.right,
            maxLines: 1,
            //obscureText: _obscureTextSignupConfirm,
            //controller: loginUsernameController,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
                color: Colors.black),
            decoration: InputDecoration(
                focusedBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Color(0xFF3D5A80) , width: 3)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3D5A80)),
                ),
                suffixIcon: Icon(
                  FontAwesomeIcons.lock,
                  color: Colors.black,
                ),
                helperText: 'Keep it short, this is just a demo.',
                labelText: 'رمز عبور',
                labelStyle: TextStyle(
                    color: Color(0xFF3D5A80)
                )
            ),
          ),
        ),
      ),
    );
  }
}
