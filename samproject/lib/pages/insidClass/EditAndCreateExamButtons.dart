import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAndCreateExamButtons extends StatefulWidget {
  final insidClassPageSetState;

  EditAndCreateExamButtons( {@required void toggleCoinCallback() }):
        insidClassPageSetState = toggleCoinCallback;
  @override
  _EditAndCreateExamButtonsState createState() =>
      _EditAndCreateExamButtonsState();
}

class _EditAndCreateExamButtonsState extends State<EditAndCreateExamButtons> {
  final RoundedLoadingButtonController btnCreateController =
      new RoundedLoadingButtonController();
  final TextEditingController classTitleController = TextEditingController();
  final TextEditingController classDescriptionController =
      TextEditingController();
  bool applyNewClassId = false;
  String _updateClassUrl = "http://parham-backend.herokuapp.com/class/";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: EditButton(),
          ),
          Expanded(
            child: CreateExamButton(),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget EditButton() {
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
                  classTitleController.text =
                      InsidClassPage.currentClass.className;
                  classDescriptionController.text =
                      InsidClassPage.currentClass.classDescription;
                  editClassBottomSheet();
                },
                child: Text(
                  "ویرایش کلاس",
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

  // ignore: non_constant_identifier_names
  Widget CreateExamButton() {
    Gradient _gradient = LinearGradient(colors: [
      Color.fromRGBO(14, 145, 140, 1),
      Color.fromRGBO(14, 145, 140, 1)
    ]);
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
                //onPressed: ,
                child: Center(
              child: Text(
                "ساخت آزمون",
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

  void editClassBottomSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )),
        barrierColor: Color.fromRGBO(14, 145, 140, 0.8),
        builder: (BuildContext context) {
          return BottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
            onClosing: () {},
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, setState) => Container(
                        height: 400,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child:
                                      Image.asset("assets/img/login_logo.png")),
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
                                            focusedBorder:
                                                new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color:
                                                            Color(0xFF3D5A80),
                                                        width: 3)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF3D5A80)),
                                            ),
                                            suffixIcon: Icon(
                                              FontAwesomeIcons.chalkboard,
                                              color: Colors.black,
                                            ),
                                            labelText: 'عنوان کلاس',
                                            labelStyle: TextStyle(
                                                color: Color(0xFF3D5A80))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 0),
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
                                            focusedBorder:
                                                new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color:
                                                            Color(0xFF3D5A80),
                                                        width: 3)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF3D5A80)),
                                            ),
                                            suffixIcon: Icon(
                                              FontAwesomeIcons.fileSignature,
                                              // FontAwesomeIcons.envelope,
                                              color: Colors.black,
                                            ),
                                            labelText: 'توضیحات',
                                            labelStyle: TextStyle(
                                                color: Color(0xFF3D5A80))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  child: Row(
                                    children: [
                                      Text(
                                        "کد جدید میخواهم",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                                color: applyNewClassId
                                                    ? Color(0xFF3D5A80)
                                                    : Colors.black),
                                      ),
                                      Checkbox(
                                        onChanged: (bool value) {
                                          setState(() {
                                            applyNewClassId = value;
                                          });
                                        },
                                        value: applyNewClassId,
                                        activeColor: Color(0xFF3D5A80),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  ),
                                  padding: EdgeInsets.only(
                                      right: 20, top: 10, bottom: 5),
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
                                      "به روز رسانی",
                                      style: TextStyle(
                                        color: Colors.white,
                                        // fontSize: MediaQuery.of(context).size.width * 0.045,
                                        // fontFamily: "WorkSansBold"
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    _pressUpdateClass();
                                  },
                                )),
                              ),
                              flex: 2,
                            )
                          ],
                        ),
                      ));
            },
          );
        },
      );

  void _pressUpdateClass() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        var body = jsonEncode(<String, Object>{
          'name': classTitleController.text,
          'description': classDescriptionController.text,
          "generateNewClassId": applyNewClassId,
        });
        token = "Bearer " + token;
        final response = await put(_updateClassUrl + InsidClassPage.currentClass.classId,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            },
            body: body);
        if (response.statusCode == 200 && response.body != null) {
          var editedClassInfo =
              json.decode(utf8.decode(response.bodyBytes))["editedClass"];
          InsidClassPage.currentClass.className = editedClassInfo["name"];
          InsidClassPage.currentClass.classDescription = editedClassInfo["description"];
          InsidClassPage.currentClass.classId = editedClassInfo["classId"];
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
                  Text(editedClassInfo['classId']),
                ],
              ),
              buttons: [
                DialogButton(
                  child: Text(
                    "کپی",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => {
                    Clipboard.setData(
                        ClipboardData(text: editedClassInfo['classId'])),
                      widget?.insidClassPageSetState(),
                  },
                  color: Color(0xFF3D5A80),
                ),
              ],
            ).show();
          });
        } else {
          var errorMsg = json.decode(utf8.decode(response.bodyBytes))['error'];
          btnCreateController.error();
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: errorMsg,
              buttons: []
            ).show();
          });
        }
      } else {
        btnCreateController.error();
        Navigator.pop(context);
        setState(() {
          Alert(
            context: context,
            type: AlertType.error,
            title: "ابتدا به حساب خود وارد شوید",
            buttons: []
          ).show();
        });
      }
    } on Exception catch (e) {
      print(e.toString());
      btnCreateController.error();
      Navigator.pop(context);
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "عملیات ناموفق بود",
          buttons: []
        ).show();
      });
    }
  }

  void editSetState(){
    setState(() {

    });
  }
}
