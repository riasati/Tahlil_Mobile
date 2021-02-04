import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/Class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../editProfilePage.dart';
import '../../homePage.dart';

// ignore: must_be_immutable
class CreateClassButton extends StatefulWidget {
  final classListWidgetSetState;
  List<Class> userClasses;

  CreateClassButton( {@required void classListWidgetSetState() , @required this.userClasses}):
    classListWidgetSetState = classListWidgetSetState;

  @override
  _CreateClassButtonState createState() => _CreateClassButtonState(classListWidgetSetState: classListWidgetSetState , userClasses: userClasses);
}

class _CreateClassButtonState extends State<CreateClassButton> {

  final RoundedLoadingButtonController btnCreateController = new RoundedLoadingButtonController();
  String _createClassURL = "http://parham-backend.herokuapp.com/class/";
  final TextEditingController classTitleController = TextEditingController();
  final TextEditingController classDescriptionController =
      TextEditingController();

  final classListWidgetSetState;
  List<Class> userClasses;

  _CreateClassButtonState( {@required void classListWidgetSetState() , @required this.userClasses}):
        classListWidgetSetState = classListWidgetSetState;

  @override
  Widget build(BuildContext context) {
    Gradient _gradient = LinearGradient(colors: [Color.fromRGBO(14, 145, 140, 1), Color.fromRGBO(14, 145, 140, 1)]);
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
      createBottomSheet();
    }

  }

  void createBottomSheet() => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      )),
      barrierColor: Colors.black45.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 450,
          child: Column(
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
                  Expanded(
                    flex: 2,
                    child: Padding(padding: EdgeInsets.only(top: 10),child: Image.asset("assets/img/login_logo.png")),

                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              controller: classTitleController,
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
                                  labelText: 'عنوان کلاس',
                                  labelStyle: TextStyle(color: Color(0xFF3D5A80))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            controller: classDescriptionController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Color(0xFF3D5A80), width: 3)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF3D5A80)),
                                ),
                                suffixIcon: Icon(
                                  FontAwesomeIcons.fileSignature,
                                  // FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                ),
                                labelText: 'توضیحات',
                                labelStyle: TextStyle(color: Color(0xFF3D5A80))),
                          ),
                        ),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                        child: RoundedLoadingButton(
                      color: Color(0xFF3D5A80),
                      controller: btnCreateController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "ساخت کلاس",
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: MediaQuery.of(context).size.width * 0.045,
                            // fontFamily: "WorkSansBold"
                          ),
                        ),
                      ),
                      onPressed: _pressCreate,
                    )),
                  ))
                ],
              ),
        ),
      ));

  void _pressCreate() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        var body = jsonEncode(<String,String>{
          'name' : classTitleController.text,
          'description':classDescriptionController.text,
        });
        token = "Bearer " + token;
        final response = await post(_createClassURL,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            }, body: body);
        if(response.statusCode == 200 && response.body != null){
          var newClassInfo = json.decode(utf8.decode(response.bodyBytes))["newClass"];
          var newClass = Class(newClassInfo['name'], HomePage.user.firstname + " " + HomePage.user.lastname, newClassInfo['classId'] , newClassInfo['isOwned']);
          btnCreateController.success();
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(":کد ورود به کلاس"),
                  Text(newClassInfo['classId']),
                ],
              ),
              buttons: [
                DialogButton(
                  child: Text(
                    "کپی",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => {
                    Clipboard.setData(ClipboardData(text:newClassInfo['classId'])),
                  },
                  color: Color(0xFF3D5A80),
                ),
              ],
            ).show();
          });
          this.userClasses.add(newClass);
          widget?.classListWidgetSetState();
        }
        else{
          var errorMsg = json.decode(utf8.decode(response.bodyBytes))['error'];
          btnCreateController.error();
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
        btnCreateController.error();
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
      btnCreateController.error();
      Navigator.pop(context);
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "ساخت کلاس با موفقیت انجام نشد",
          buttons: [
          ],
        ).show();
      });
    }
  }

}
