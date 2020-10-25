import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _signInURL = "http://parham-backend.herokuapp.com/user/login";

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  final TextEditingController loginUsernameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  bool _obscureTextLogin = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          textAlign: TextAlign.right,
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginUsernameController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              FontAwesomeIcons.userGraduate,
                              // FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                            hintText: "ایمیل یا نام کاربری",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 1.0,
                        color: Colors.grey[900],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          textAlign: TextAlign.right,
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              FontAwesomeIcons.lock,
                              // FontAwesomeIcons.lock,
                              size: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                            hintText: "رمز عبور",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                            ),
                            icon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: MediaQuery.of(context).size.width * 0.03,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 1.0,
                        color: Colors.grey[900],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.only(top: 200.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        // color: Theme.Colors.loginGradientStart,
                        color: Colors.limeAccent,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        // color: Theme.Colors.loginGradientEnd,
                        color: Colors.blue,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          // Theme.Colors.loginGradientEnd,
                          // Theme.Colors.loginGradientStart
                          Colors.red,
                          Colors.blue,
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                    // highlightColor: Colors.transparent,
                    // splashColor: Theme.Colors.loginGradientEnd,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "ورود",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: _pressLogin,
                  )
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "فراموشی رمز عبور؟",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontFamily: "WorkSansMedium"),
                )),
          ),
        ],
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _pressLogin() async{
    var body = jsonEncode(<String,String>{
      'username' : loginUsernameController.text,
      'password':loginPasswordController.text,
    });
    Response response = await post(_signInURL,
        headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: body);
    if(response == null || response.statusCode != 200){
        setState(() {
          Alert(
            context: context,
            type: AlertType.error,
            title: "خطا",
            desc: "نام کاربری یا رمز عبور اشتباه است",
            buttons: [
              DialogButton(
                child: Text(
                  "حله",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                color: Colors.deepPurple,
              ),
            ],
          ).show();
        });
      }
    else{
      print(response.body);
    }

  }
}
