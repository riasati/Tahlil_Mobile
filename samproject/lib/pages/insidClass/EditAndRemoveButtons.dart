import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/pages/createExamPage.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';
import 'package:samproject/pages/insidClass/classInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAndRemoveButtons extends StatefulWidget {
  final classInfoSetState;

  //String classId;

  EditAndRemoveButtons({@required void toggleCoinCallback()})
      : classInfoSetState = toggleCoinCallback;

  @override
  _EditAndRemoveButtonsState createState() =>
      _EditAndRemoveButtonsState();
}

class _EditAndRemoveButtonsState extends State<EditAndRemoveButtons> {
  final RoundedLoadingButtonController btnCreateController =
      new RoundedLoadingButtonController();
  final TextEditingController classTitleController = TextEditingController();
  final TextEditingController classDescriptionController =
      TextEditingController();
  bool applyNewClassId = false;
  String _removeClassUrl = "http://parham-backend.herokuapp.com/class/";
  String _updateClassUrl = "http://parham-backend.herokuapp.com/class/";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RemoveClassButton(),
            )),
            Expanded(child: EditClassButton()),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget RemoveClassButton() {
    return Container(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          child: FlatButton(
              onPressed: () {
                _checkRemoveClass();
              },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    "حذف کلاس",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ],
            ),),
        ),
      ),
    );
  }

  void _checkRemoveClass() {
    setState(() {
      Alert(context: context, title: "مایل به ادامه کار هستید؟",
          // content: Column(
          //   children: [
          //     Text(member.username),
          //     Text(member.firstname + " " + member.lastname , textAlign: TextAlign.end,)
          //   ],
          // ),
          buttons: [
            DialogButton(
              child: Text(
                "خیر",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              color: Color.fromRGBO(100, 0, 0, 1),
            ),
            DialogButton(
              child: Text(
                "بله",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _pressRemoveClass();
              },
              color: Color.fromRGBO(0, 100, 0, 1),
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),
          ]).show();
    });
  }

  void _pressRemoveClass() async {
    InsidClassPage.isLoading = true;
    widget?.classInfoSetState();
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _removeClassUrl +
            InsidClassPage.currentClass.classId;
        print(url);
        final response = await delete(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
          InsidClassPage.isLoading = false;
          InsidClassPage.removeClass = true;
          widget?.classInfoSetState();
          setState(() {
          });
        } else {
          InsidClassPage.isLoading = false;
          widget?.classInfoSetState();
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: "عملیات ناموفق بود",
              buttons: [],
            ).show();
          });
        }
      }
    } on Exception catch (e) {
      InsidClassPage.isLoading = false;
      widget?.classInfoSetState();
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "عملیات ناموفق بود",
          buttons: [],
        ).show();
      });
    }
    InsidClassPage.isLoading = false;
    widget?.classInfoSetState();
  }

  // ignore: non_constant_identifier_names
  Widget EditClassButton() {
    return Container(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          child: FlatButton(
              onPressed: () {
                classTitleController.text =
                    InsidClassPage.currentClass.className;
                classDescriptionController.text =
                    InsidClassPage.currentClass.classDescription;
                editClassBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "ویرایش کلاس",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(14, 145, 140, 1),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    color: Color.fromRGBO(14, 145, 140, 1),
                  ),

                ],
              )),
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
        barrierColor: Colors.black45.withOpacity(0.8),
        builder: (BuildContext context) {
          return BottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
            onClosing: () {},
            enableDrag: true,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, setState) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                          height: 300,
                          child: Column(
                            children: [
                              Container(
                                child: Icon(FontAwesomeIcons.gripLines),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Color(0xFFFF000000)),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 3,
                              //   child: Padding(
                              //       padding: EdgeInsets.only(top: 10),
                              //       child:
                              //           Image.asset("assets/img/login_logo.png")),
                              // ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10 ),
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
                                  padding: EdgeInsets.only(bottom: 5),
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
                                      _pressEditClass();
                                    },
                                  )),
                                ),
                                flex: 2,
                              )
                            ],
                          ),
                        ),
                  ));
            },
          );
        },
      );

  void _pressEditClass() async {
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
        final response =
            await put(_updateClassUrl + InsidClassPage.currentClass.classId,
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
          InsidClassPage.currentClass.classDescription =
              editedClassInfo["description"];
          if (InsidClassPage.currentClass.classDescription == null)
            InsidClassPage.currentClass.classDescription = "";
          InsidClassPage.currentClass.classId = editedClassInfo["classId"];
          btnCreateController.success();
          Navigator.pop(context);
          widget?.classInfoSetState();
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              content: applyNewClassId?Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(":کد ورود به کلاس"),
                  Text(editedClassInfo['classId']),
                ],
              ):Container(),
              buttons: applyNewClassId?[
                DialogButton(
                  child: Text(
                    "کپی",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => {
                    Clipboard.setData(
                        ClipboardData(text: editedClassInfo['classId'])),
                  },
                  color: Color(0xFF3D5A80),
                ),
              ]:[],
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
                buttons: []).show();
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
              buttons: []).show();
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
            buttons: []).show();
      });
    }
  }

  void editSetState() {
    setState(() {});
  }
}
