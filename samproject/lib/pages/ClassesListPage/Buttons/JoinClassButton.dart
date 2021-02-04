import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/Class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../editProfilePage.dart';
import '../../homePage.dart';

class JoinButton extends StatefulWidget {
  final classListWidgetSetState;
  List<Class> userClasses;

  JoinButton( {@required void classListWidgetSetState() , @required this.userClasses}):
        classListWidgetSetState = classListWidgetSetState;

  @override
  _JoinButtonState createState() => _JoinButtonState(classListWidgetSetState: classListWidgetSetState, userClasses: userClasses);
}

class _JoinButtonState extends State<JoinButton> {

  final RoundedLoadingButtonController btnJoinController = new RoundedLoadingButtonController();
  String _joinClassURL = "http://parham-backend.herokuapp.com/class/join";
  final TextEditingController classCodeController = TextEditingController();

  final classListWidgetSetState;
  List<Class> userClasses;

  _JoinButtonState( {@required void classListWidgetSetState() , @required this.userClasses}):
        classListWidgetSetState = classListWidgetSetState;

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
                onPressed: goEditProfile,
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

  void goEditProfile(){
    if(HomePage.user.firstname == "****" || HomePage.user.lastname == "****"){
      setState(() {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "ابتدا باید نام خود را اصلاح کنید",
          buttons: [
            DialogButton(
              child: Text(
                "حله",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()))
              },
              color: Colors.yellow,
            ),
          ],
        ).show();
      });
    }else{
      joinBottomSheet();
    }

  }

  void joinBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      isScrollControlled: true,
      barrierColor: Colors.black45.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 350,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Icon(FontAwesomeIcons.gripLines),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                        BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                      ),
                    ),
                  ),
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
                      color: Color.fromRGBO(14, 145, 140, 1),
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
              ),
        ),
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
        print("hie");
        if(response.statusCode == 200 && response.body != null){
          var joinedClassInfo = json.decode(utf8.decode(response.bodyBytes))["joinedClass"];
          var joinedClass = Class(joinedClassInfo['name'], joinedClassInfo['ownerFullname'], joinedClassInfo['classId'], joinedClassInfo['isOwned']);
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "به کلاس اضافه شدید",
              buttons: [
              ],
            ).show();
          });
          this.userClasses.add(joinedClass);
          widget?.classListWidgetSetState();
        }
        else{
          var errorMsg = json.decode(utf8.decode(response.bodyBytes))['error'];
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: errorMsg,
              buttons: [
              ],
            ).show();
          });
        }
      }
      else{
        Navigator.pop(context);
        setState(() {
          Alert(
            context: context,
            type: AlertType.error,
            title: "ابتدا به حساب خود وارد شوید",
            buttons: [
            ],
          ).show();
        });
      }
    }on Exception catch(e){
      print(e.toString());
      Navigator.pop(context);
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "به کلاس اضافه نشدید",
          buttons: [
          ],
        ).show();
      });
    }

  }
}
