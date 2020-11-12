import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinButton extends StatefulWidget {
  @override
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {

  final RoundedLoadingButtonController btnJoinController = new RoundedLoadingButtonController();
  String _joinClassURL = "http://parham-backend.herokuapp.com/class/join";
  final TextEditingController classCodeController = TextEditingController();

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
                onPressed: joinBottomSheet,
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

  void joinBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      barrierColor: Color(0xFF3D5A80).withOpacity(0.8),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Image.asset("assets/img/login_logo.png"), flex: 2,),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          controller: classCodeController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color(0xFF3D5A80), width: 3)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF3D5A80)),
                              ),
                              suffixIcon: Icon(
                                FontAwesomeIcons.chalkboard,
                                color: Colors.black,
                              ),
                              labelText: 'کد شش رقمی کلاس',
                              labelStyle: TextStyle(color: Color(0xFF3D5A80))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                    child: RoundedLoadingButton(
                  color: Colors.green,
                  //controller: btnJoin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "اضافه شدن",
                      style: TextStyle(
                        color: Colors.white,
                        // fontSize: MediaQuery.of(context).size.width * 0.045,
                        // fontFamily: "WorkSansBold"
                      ),
                    ),
                  ),
                  onPressed: _pressJoin,
                )),
              ))
            ],
          ));

  void _pressJoin() async{
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        var body = jsonEncode(<String,String>{
          'classId' : classCodeController.text,
        });
        token = "Bearer " + token;
        final response = await post(_joinClassURL,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            }, body: body);
        print(response.body);
      }
    }on Exception catch(e){
      print(e.toString());
    }

  }
}
