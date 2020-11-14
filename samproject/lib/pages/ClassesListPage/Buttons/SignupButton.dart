import 'package:flutter/material.dart';
import 'package:samproject/pages/LoginSignupPage/LoginPage.dart';

class SignupButton extends StatelessWidget {
  final callHomePageBiuld;

  SignupButton( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;

  @override
  Widget build(BuildContext context) {
    Gradient _gradient =
    LinearGradient(colors: [Color.fromRGBO(14, 145, 140, 1), Color.fromRGBO(14, 145, 140, 1)]);
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
                  LoginPage.pageController =  PageController(initialPage: 1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(toggleCoinCallback: callHomePageBiuld,),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "ثبت نام",
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
