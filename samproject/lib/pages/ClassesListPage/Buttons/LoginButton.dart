import 'package:flutter/material.dart';
import 'package:samproject/pages/LoginSignupPage/LoginPage.dart';
import 'package:samproject/pages/editProfilePage.dart';

class LoginButton extends StatelessWidget {
  final callClassesListBuild;

  LoginButton( {@required void toggleCoinCallback() }):
        callClassesListBuild = toggleCoinCallback;

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
                onPressed: () {
                  LoginPage.pageController =  PageController(initialPage: 0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(toggleCoinCallback: callClassesListBuild,),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "ورود به حساب کاربری",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
