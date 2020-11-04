import 'package:flutter/material.dart';

class JoinButton extends StatefulWidget {
  @override
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  @override
  Widget build(BuildContext context) {
    Gradient _gradient =
    LinearGradient(colors: [Color(0xFF3D5A80), Color(0xFF3D5A80)]);
    return Container(
      width: double.infinity,
      height: 40,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(40.0)),
              gradient: _gradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ]),
          child: Material(
            color: Colors.transparent,
            borderRadius: new BorderRadius.all(Radius.circular(40.0)),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "اضافه شدن به کلاس",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
