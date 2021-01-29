import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/LoginSignupPage/LoginPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  final callHomePageBiuld;

  SignUpPage( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _signUpURL = "http://parham-backend.herokuapp.com/user/signup";

  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();

  final FocusNode myFocusNodePasswordSignup = FocusNode();
  final FocusNode myFocusNodeEmailSignup = FocusNode();
  final FocusNode myFocusNodeUsernameSignup = FocusNode();

  final TextEditingController signupUsernameController = TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPasswordController = TextEditingController();
  final TextEditingController signupConfirmPasswordController = TextEditingController();

  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  bool _usernameAlarmVisible = false;
  bool _emailAlarmVisible = false;
  bool _passwordAlarmVisible = false;
  bool _repeatPasswordAlarmVisible = false;

  @override
  void initState() {
    super.initState();
    signupUsernameController.addListener(_signupUsernameController);
    signupEmailController.addListener(_signupEmailController);
    signupPasswordController.addListener(_signupPasswordController);
    signupConfirmPasswordController.addListener(_signupConfirmPasswordController);
  }

  @override
  Widget build(BuildContext context) {
    double responsiveDivision = MediaQuery.of(context).devicePixelRatio >1.5? 1.3:1;
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
                  height: MediaQuery.of(context).size.height * 0.43 * responsiveDivision,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextField(
                          textAlign: TextAlign.right,
                          focusNode: myFocusNodeUsernameSignup,
                          controller: signupUsernameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              // FontAwesomeIcons.user,
                              FontAwesomeIcons.userGraduate,
                              color: Colors.black,
                            ),
                            hintText: "نام کاربرری",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Visibility(
                          visible: _usernameAlarmVisible,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Text(
                            "نام کاربری باید حداقل ۶ کاراکتر باشد",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: MediaQuery.of(context).size.width * 0.023,
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
                            top: 15.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextField(
                          textAlign: TextAlign.right,
                          focusNode: myFocusNodeEmailSignup,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              //FontAwesomeIcons.envelope,
                              FontAwesomeIcons.solidEnvelope,
                              color: Colors.black,
                            ),
                            hintText: "آدرس ایمیل",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: MediaQuery.of(context).size.width * 0.03),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: _emailAlarmVisible,
                          child: Text(
                            "فرمت ایمیل صحیح نمیباشد",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: MediaQuery.of(context).size.width * 0.023,
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
                            top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextField(
                          textAlign: TextAlign.right,
                          focusNode: myFocusNodePasswordSignup,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "رمز عبور",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: MediaQuery.of(context).size.width * 0.03,),
                            icon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextSignup
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
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: _passwordAlarmVisible,
                          child: Text(
                            "رمز عبور باید حداقل ۶ کاراکتر باشد",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: MediaQuery.of(context).size.width * 0.023,
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
                            top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextField(
                          textAlign: TextAlign.right,
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextSignupConfirm,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              // FontAwesomeIcons.lock,
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "تکرار رمز عبور",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: MediaQuery.of(context).size.width * 0.03,),
                            icon: GestureDetector(
                              onTap: _toggleSignupConfirm,
                              child: Icon(
                                _obscureTextSignupConfirm
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
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: _repeatPasswordAlarmVisible,
                          child: Text(
                            "تکرار رمز عبور صحیح نمیباشد",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: MediaQuery.of(context).size.width * 0.023,
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
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 0,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 450.0 / responsiveDivision),
                width: MediaQuery.of(context).size.width * 0.5,
                // decoration: new BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //   // boxShadow: <BoxShadow>[
                //   //   BoxShadow(
                //   //     color:Colors.red,
                //   //     // color: Theme.Colors.loginGradientStart,
                //   //     offset: Offset(1.0, 6.0),
                //   //     blurRadius: 20.0,
                //   //   ),
                //   //   BoxShadow(
                //   //     color:Colors.blue,
                //   //     // color: Theme.Colors.loginGradientEnd,
                //   //     offset: Offset(1.0, 6.0),
                //   //     blurRadius: 20.0,
                //   //   ),
                //   // ],
                //   gradient: new LinearGradient(
                //       colors: [
                //         // Theme.Colors.loginGradientEnd,
                //         // Theme.Colors.loginGradientStart
                //         Colors.orange[900],
                //         Colors.orange[900],
                //       ],
                //       begin: const FractionalOffset(0.2, 0.2),
                //       end: const FractionalOffset(1.0, 1.0),
                //       stops: [0.0, 1.0],
                //       tileMode: TileMode.clamp),
                // ),
                child: RoundedLoadingButton(
                  // highlightColor: Colors.transparent,
                  // // splashColor: Theme.Colors.loginGradientEnd,
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  borderRadius: 10,
                  color: Color.fromRGBO(238, 108,77 ,1.0),
                  controller: btnController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "ثبت نام",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed:_pressSignUp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signupUsernameController(){
    if(!_checkUsername(signupUsernameController.text)) {
      setState(() {
        _usernameAlarmVisible = true;
      });
    }
    else{
      setState(() {
        _usernameAlarmVisible = false;
      });
    }
  }

  void _signupEmailController() {
    if(!_checkEmail(signupEmailController.text)){
      setState(() {
        _emailAlarmVisible = true;
      });
    }
    else{
      setState(() {
        _emailAlarmVisible = false;
      });
    }
  }

  void _signupPasswordController() {
    if(!_checkPassword(signupPasswordController.text)){
      setState(() {
        _passwordAlarmVisible = true;
      });
    }
    else{
      setState(() {
        _passwordAlarmVisible = false;
      });

    }
  }

  void _signupConfirmPasswordController() {
    if(!_checkConfirmPassword(signupConfirmPasswordController.text)){
      setState(() {
        _repeatPasswordAlarmVisible = true;
      });
    }
    else{
      setState(() {
        _repeatPasswordAlarmVisible = false;
      });

    }
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  void _pressSignUp() async{
    if(!_checkUsername(signupUsernameController.text) || !_checkEmail(signupEmailController.text)
    || !_checkPassword(signupPasswordController.text) || !_checkConfirmPassword(signupConfirmPasswordController.text)){
      setState(() {
        btnController.stop();
        Alert(
          context: context,
          type: AlertType.error,
          title: "ورودی ها را چک کنید",
          buttons: [
            DialogButton(
              child: Text(
                "حله",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color(0xFF3D5A80),
            ),
          ],
        ).show();
      });
    }
    else {
      var body = jsonEncode(<String,String>{
        'username' : signupUsernameController.text,
        'email' : signupEmailController.text,
        'password':signupPasswordController.text,
      });
      Response response = await post(_signUpURL,
          headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: body);
      if(response.statusCode != 201){
        setState(() {
          btnController.stop();
          Alert(
            context: context,
            type: AlertType.error,
            title: "نام کاربری یا ایمیل تکراری است",
            buttons: [
              DialogButton(
                child: Text(
                  "حله",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                color: Color(0xFF3D5A80),
              ),
            ],
          ).show();
        });
      }
      else{
          btnController.success();
          final personInfo = jsonDecode(response.body);
          HomePage.user = Person();
          HomePage.user.firstname = "****";
          HomePage.user.lastname = "****";
          HomePage.user.username = personInfo['user']['username'];
          HomePage.user.email = personInfo['user']['email'];
          HomePage.user.avatarUrl = personInfo['user']['avatar'];
          HomePage.user.password = signupPasswordController.text;
          _saveToken(personInfo['token']);
          Navigator.pop(context);
      }
    }
    widget?.callHomePageBiuld();
  }

  void _saveToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    print(token);
  }

  bool _checkUsername(String username) {
    if (username.length < 6)
      return false;
    else
      return true;
  }

  bool _checkEmail(String text) {
    String emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailRegex);
    return !regExp.hasMatch(text) ? false:true;
  }

  bool _checkPassword(String text) {
    if(text.length < 6)
      return false;
    else
      return true;
  }

  bool _checkConfirmPassword(String text) {
    if(signupPasswordController.text != text)
      return false;
    else
      return true;
  }
}
