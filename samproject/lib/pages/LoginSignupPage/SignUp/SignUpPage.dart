import 'package:flutter/material.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    // myFocusNodeEmailLogin.attach(context,onKey: _testAttach());
  }

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
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
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
                            icon: Icon(
                              // FontAwesomeIcons.user,
                              Icons.access_alarm,
                              color: Colors.black,
                            ),
                            hintText: "Name",
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
                            "Username should be 6 caracter",
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
                            top: 20.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailSignup,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              //FontAwesomeIcons.envelope,
                              Icons.access_alarm,
                              color: Colors.black,
                            ),
                            hintText: "Email Address",
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
                            "Username should be 6 caracter",
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
                            top: 20.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordSignup,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              // FontAwesomeIcons.lock,
                              Icons.alarm,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: MediaQuery.of(context).size.width * 0.03,),
                            // suffixIcon: GestureDetector(
                            //   onTap: _toggleSignup,
                            //   child: Icon(
                            //     _obscureTextSignup
                            //         ? FontAwesomeIcons.eye
                            //         : FontAwesomeIcons.eyeSlash,
                            //     size: 15.0,
                            //     color: Colors.black,
                            //   ),
                            // ),
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
                            "Username should be 6 caracter",
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
                            top: 20.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextSignupConfirm,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              // FontAwesomeIcons.lock,
                              Icons.alarm,
                              color: Colors.black,
                            ),
                            hintText: "Confirmation",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: MediaQuery.of(context).size.width * 0.03,),
                            // suffixIcon: GestureDetector(
                            //   onTap: _toggleSignupConfirm,
                            //   child: Icon(
                            //     _obscureTextSignupConfirm
                            //         ? FontAwesomeIcons.eye
                            //         : FontAwesomeIcons.eyeSlash,
                            //     size: 15.0,
                            //     color: Colors.black,
                            //   ),
                            // ),
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
                            "Username should be 6 caracter",
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
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 400.0),
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:Colors.red,
                      // color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color:Colors.blue,
                      // color: Theme.Colors.loginGradientEnd,
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
                  highlightColor: Colors.transparent,
                  // splashColor: Theme.Colors.loginGradientEnd,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  // onPressed: () =>
                  //     showInSnackBar("SignUp button pressed")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signupUsernameController(){
    if(signupUsernameController.text.length < 6) {
      setState(() {
        _usernameAlarmVisible = true;
      });

    }
  }
}
