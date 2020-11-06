import 'package:flutter/material.dart';

class TitleButton extends StatefulWidget {
  @override
  _TitleButtonState createState() => _TitleButtonState();
}

class _TitleButtonState extends State<TitleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: C(5),
          // ),
          child: TextField(
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.black),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              hintText: "عنوان کلاس",
              hintStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
              // icon: GestureDetector(
              //   onTap: _toggleLogin,
              //   child: Icon(
              //     _obscureTextLogin
              //         ? FontAwesomeIcons.eye
              //         : FontAwesomeIcons.eyeSlash,
              //     size: MediaQuery.of(context).size.width * 0.03,
              //     color: Colors.black,
              //   ),
              // ),
            ),

            //cursorColor: Colors.red,
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
