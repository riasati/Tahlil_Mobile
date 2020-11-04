import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/LoginButton.dart';
import 'package:samproject/pages/ClassesListPage/Buttons/SignupButton.dart';

class LoginOrSignup extends StatefulWidget {
  @override
  _LoginOrSignupState createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 75.0 ),
            child: new Image(
              // width: 250.0,
              // height: 191.0,
                fit: BoxFit.fill,
                image: new AssetImage('assets/img/login_logo.png')),
          ),
          SizedBox(height: 30,),
          LoginButton(),
          SizedBox(height: 10,),
          SignupButton(),
        ],
      ),
    );
  }
}
