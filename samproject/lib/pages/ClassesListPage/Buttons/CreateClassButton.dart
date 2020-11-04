import 'package:flutter/material.dart';

class CreateClassButton extends StatefulWidget {
  @override
  _CreateClassButtonState createState() => _CreateClassButtonState();
}

class _CreateClassButtonState extends State<CreateClassButton> {
  @override
  Widget build(BuildContext context) {
    Gradient _gradient =
    LinearGradient(colors: [Colors.green, Colors.green]);
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
                child: Center(
                  child: Text(
                    "ساخت کلاس جدید",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
