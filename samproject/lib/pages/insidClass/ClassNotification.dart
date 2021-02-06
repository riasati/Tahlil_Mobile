import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samproject/domain/Notification.dart';

import 'InsidClassPage.dart';

class ClassNotification extends StatefulWidget {
  final insidClassPageSetState;

  ClassNotification({@required void toggleCoinCallback()})
      : insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassNotificationState createState() => _ClassNotificationState();
}

class _ClassNotificationState extends State<ClassNotification> {
  bool isLoading = true;
  String _getNotificationsOfClassInfoURL =
      "http://parham-backend.herokuapp.com/class/";
  String _removeNotificationURL = "http://parham-backend.herokuapp.com/class/";
  String _createNewNotificationURL =
      "http://parham-backend.herokuapp.com/class/";
  List<SumNotification> classNotifications = [];
  List<bool> notificationIsOpen = [];
  List<bool> notificationMoreText = [];

  bool _editNotificationTitleError = false;
  bool _createNotificationTitleError = false;
  bool _editNotificationDescriptionError = false;
  bool _createNotificationDescriptionError = false;

  final RoundedLoadingButtonController btnCreateController =
      new RoundedLoadingButtonController();
  final TextEditingController notificationTitleController =
      TextEditingController();
  final TextEditingController notificationDescriptionController =
      TextEditingController();
  final TextEditingController editNotificationTitleController =
      TextEditingController();
  final TextEditingController editNotificationDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _getNotificationsListFromServer();
  }

  void _getNotificationsListFromServer() async {
    setState(() {
      isLoading = true;
    });
    while (InsidClassPage.currentClass.classId == null ||
        InsidClassPage.currentClass.classId == "") {
      Future.delayed(Duration(milliseconds: 500));
    }
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _getNotificationsOfClassInfoURL +
            InsidClassPage.currentClass.classId +
            "/notes";
        final response = await get(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        classNotifications = [];
        if (response.statusCode == 200) {
          var notificationsInfo =
              json.decode(utf8.decode(response.bodyBytes))["classNotes"];
          for (var notificationInfo in notificationsInfo) {
            SumNotification notification = SumNotification(
                notificationInfo["classNoteId"],
                notificationInfo["title"],
                notificationInfo["body"],
                DateTime.parse(notificationInfo["createdAt"]).toUtc());
            classNotifications.add(notification);
            notificationIsOpen.add(false);
            notificationMoreText.add(false);
          }
          classNotifications
              .sort((t1, t2) => t1.createTime.compareTo(t2.createTime));
          classNotifications = classNotifications.reversed.toList();
        } else {
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
      print(e.toString());
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "عملیات ناموفق بود",
          buttons: [],
        ).show();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: isLoading,
        child: Column(children: [
          Expanded(
            child: notificationList(),
            flex: 10,
          ),
          InsidClassPage.isAdmin
              ? Container(
                  //color: Colors.red,
                  height: 60,
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        color: Color.fromRGBO(14, 145, 140, 1),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          // _createNotificationDescriptionError = false;
                          // _createNotificationTitleError = false;
                          _createNewNotificationBottomSheet();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                "ساخت اعلان جدید",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ]));
  }

  Widget notificationList() {
    if(classNotifications.isNotEmpty)
      return ListView.builder(
          itemCount: classNotifications.length,
          itemBuilder: (BuildContext context, int index) {
            return eachNotificationCard(index);
          });
    else
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              child: Icon(
                FontAwesomeIcons.frown,
              ),
              padding: EdgeInsets.only(top: 200, ),
            ),
            Text(
              "اعلانی وجود ندارد",
            )
          ],
        ),
        width: double.infinity,
      );
  }

  Widget eachNotificationCard(int notificationIndex) {
    return Card(
      child: Column(
        children: [
          ListTile(
            tileColor: Color(0xFF3D5A80),
            leading: IconButton(
              icon: Icon(
                notificationIsOpen[notificationIndex]
                    ? FontAwesomeIcons.chevronCircleUp
                    : FontAwesomeIcons.chevronCircleDown,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  notificationIsOpen[notificationIndex] =
                      !notificationIsOpen[notificationIndex];
                });
              },
            ),
            trailing: Text(
              classNotifications[notificationIndex].title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          AnimatedContainer(
            decoration: BoxDecoration(
                border: Border.all(
              color: Color(0xFF3D5A80),
            )),
            child: notificationIsOpen[notificationIndex]
                ? Column(
                    children: [
                      ListTile(
                        trailing: Icon(
                          FontAwesomeIcons.calendarAlt,
                          color: Color.fromRGBO(14, 145, 140, 1),
                        ),
                        title: Text(
                          convertDateToJalaliString(
                              classNotifications[notificationIndex].createTime),
                          style: TextStyle(),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ListTile(
                        trailing: Icon(
                          FontAwesomeIcons.commentDots,
                          color: Color.fromRGBO(14, 145, 140, 1),
                        ),
                        title: Text(
                          "متن پیام:",
                          style: TextStyle(),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      notificationText(notificationIndex),
                      InsidClassPage.isAdmin
                          ? adminActions(notificationIndex,
                              classNotifications[notificationIndex])
                          : Text("")
                    ],
                  )
                : SizedBox(
                    height: 1,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          )
        ],
      ),
    );
  }

  Widget notificationText(int notificationIndex) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Text(
        classNotifications[notificationIndex].body,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget adminActions(int notificationIndex, SumNotification notification) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          Container(
            child: FlatButton(
              onPressed: () {
                _checkRemoveNotification(notificationIndex);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "حذف اعلان",
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
              ),
            ),
            width: 120,
            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              //color: userAnswer ? Colors.black : Colors.black26,
            ),
          ),
          Container(
            child: FlatButton(
                onPressed: () {
                  _editNotificationDescriptionError = false;
                  _editNotificationTitleError = false;
                  editNotificationTitleController.text = notification.title;
                  editNotificationDescriptionController.text =
                      notification.body;
                  _editNotificationBottomSheet(notificationIndex);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "ویرایش اعلان",
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
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              //color: Colors.red,
              //color: userAnswer ? Colors.black26 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _checkRemoveNotification(int notificationIndex) {
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
                _pressRemoveNotification(notificationIndex);
              },
              color: Color.fromRGBO(0, 100, 0, 1),
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),
          ]).show();
    });
  }

  void _pressRemoveNotification(int notificationIndex) async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _removeNotificationURL +
            InsidClassPage.currentClass.classId +
            "/notes/" +
            classNotifications[notificationIndex].id;
        print(url);
        final response = await delete(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
          classNotifications.removeAt(notificationIndex);
          notificationIsOpen.removeAt(notificationIndex);
          notificationMoreText.removeAt(notificationIndex);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [],
            ).show();
          });
        } else {
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
      print(e.toString());
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "عملیات ناموفق بود",
          buttons: [],
        ).show();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _editNotificationBottomSheet(int notificationIndex) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )),
        barrierColor: Colors.black45.withOpacity(0.8),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              height: 500,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  maxLines: 1,
                                  controller: editNotificationTitleController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) => _validateTitle(value),
                                  onChanged: (value) {
                                    if(value.length > 25)
                                      setState(() {
                                        _editNotificationTitleError = true;
                                      });
                                    else
                                      setState(() {
                                        _editNotificationTitleError = false;
                                      });
                                  },
                                  decoration: InputDecoration(
                                    errorText: _editNotificationTitleError?"حداکثر ۲۵ کاراکتر":null,
                                      errorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: _editNotificationTitleError?Colors.red:Color(0xFF3D5A80),
                                              width: 3)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xFF3D5A80)),
                                      ),
                                      suffixIcon: Icon(
                                        FontAwesomeIcons.bell,
                                        color: Colors.black,
                                      ),
                                      labelText: 'عنوان اعلان',
                                      labelStyle:
                                          TextStyle(color: Color(0xFF3D5A80))),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  maxLines: 7,
                                  controller:
                                      editNotificationDescriptionController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    if(value.length > 120)
                                      setState(() {
                                        _editNotificationDescriptionError = true;
                                      });
                                    else
                                      setState(() {
                                        _editNotificationDescriptionError = false;
                                      });
                                  },
                                  decoration: InputDecoration(
                                    errorText: _editNotificationDescriptionError?"حداکثر ۱۲۰ کاراکتر":null,
                                      errorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFF3D5A80),
                                              width: 3)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xFF3D5A80)),
                                      ),
                                      suffixIcon: Icon(
                                        FontAwesomeIcons.fileSignature,
                                        // FontAwesomeIcons.envelope,
                                        color: Colors.black,
                                      ),
                                      labelText: 'توضیحات',
                                      labelStyle: TextStyle(
                                          color: Color(0xFF3D5A80),
                                          fontSize: 25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 7,
                  ),
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
                            "ویرایش اعلان",
                            style: TextStyle(
                              color: Colors.white,
                              // fontSize: MediaQuery.of(context).size.width * 0.045,
                              // fontFamily: "WorkSansBold"
                            ),
                          ),
                        ),
                        onPressed: () {
                          _pressEditNotification(notificationIndex);
                        },
                      )),
                    ),
                    flex: 2,
                  )
                ],
              ),
            ),
          );
        },
      );

  void _pressEditNotification(int notificationIndex) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        var body = jsonEncode(<String, Object>{
          'title': editNotificationTitleController.text,
          'body': editNotificationDescriptionController.text,
        });
        token = "Bearer " + token;
        final response = await put(
            _createNewNotificationURL +
                InsidClassPage.currentClass.classId +
                "/notes/" +
                classNotifications[notificationIndex].id,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            },
            body: body);
        print(response);
        if (response.statusCode == 200 && response.body != null) {
          var notificationInfo =
              json.decode(utf8.decode(response.bodyBytes))["editedClassNote"];
          print(notificationInfo);
          classNotifications[notificationIndex].title =
              notificationInfo["title"];
          classNotifications[notificationIndex].body = notificationInfo["body"];
          classNotifications[notificationIndex].createTime =
              DateTime.parse(notificationInfo["createdAt"]);
          print(classNotifications[notificationIndex]);
          classNotifications
              .sort((t1, t2) => t1.createTime.compareTo(t2.createTime));
          classNotifications = classNotifications.reversed.toList();
          btnCreateController.success();
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [],
            ).show();
          });
        } else {
          var errorMsg = json.decode(utf8.decode(response.bodyBytes))['error'];
          if (errorMsg == null) errorMsg = "";
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

  void _createNewNotificationBottomSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )),
        barrierColor: Colors.black45.withOpacity(0.8),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              height: 450,
              child: Column(
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
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  maxLines: 1,
                                  controller: notificationTitleController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    if(value.length > 25)
                                      setState(() {
                                        _createNotificationTitleError = true;
                                      });
                                    else
                                      setState(() {
                                        _createNotificationTitleError = false;
                                      });
                                  },
                                  decoration: InputDecoration(
                                      errorText: _createNotificationTitleError?"حداکثر ۲۵ کاراکتر":null,
                                      errorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFF3D5A80),
                                              width: 3)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xFF3D5A80)),
                                      ),
                                      suffixIcon: Icon(
                                        FontAwesomeIcons.bell,
                                        color: Colors.black,
                                      ),
                                      labelText: 'عنوان اعلان',
                                      labelStyle:
                                          TextStyle(color: Color(0xFF3D5A80))),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  maxLines: 7,
                                  controller: notificationDescriptionController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    if(value.length > 120)
                                      setState(() {
                                        _createNotificationDescriptionError = true;
                                      });
                                    else
                                      setState(() {
                                        _createNotificationDescriptionError = false;
                                      });
                                  },
                                  decoration: InputDecoration(
                                      errorText: _createNotificationDescriptionError?"حداکثر 120 کاراکتر":null,
                                      errorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(100, 0, 0, 1),
                                              width: 3)),
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFF3D5A80),
                                              width: 3)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xFF3D5A80)),
                                      ),
                                      suffixIcon: Icon(
                                        FontAwesomeIcons.fileSignature,
                                        // FontAwesomeIcons.envelope,
                                        color: Colors.black,
                                      ),
                                      labelText: 'توضیحات',
                                      labelStyle: TextStyle(
                                          color: Color(0xFF3D5A80),
                                          fontSize: 25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 7,
                  ),
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
                            "ساخت اعلان جدید",
                            style: TextStyle(
                              color: Colors.white,
                              // fontSize: MediaQuery.of(context).size.width * 0.045,
                              // fontFamily: "WorkSansBold"
                            ),
                          ),
                        ),
                        onPressed: () {
                          _pressCreateNotification();
                        },
                      )),
                    ),
                    flex: 2,
                  )
                ],
              ),
            ),
          );
        },
      );

  void _pressCreateNotification() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        var body = jsonEncode(<String, Object>{
          'title': notificationTitleController.text,
          'body': notificationDescriptionController.text,
        });
        token = "Bearer " + token;
        final response = await post(
            _createNewNotificationURL +
                InsidClassPage.currentClass.classId +
                "/notes",
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            },
            body: body);
        print(response);
        if (response.statusCode == 201 && response.body != null) {
          var notificationInfo =
              json.decode(utf8.decode(response.bodyBytes))["newClassNote"];
          print(notificationInfo);
          SumNotification newNotification = SumNotification(
              notificationInfo["classNoteId"],
              notificationInfo["title"],
              notificationInfo["body"],
              DateTime.parse(notificationInfo["createdAt"]));
          classNotifications.add(newNotification);
          notificationIsOpen.add(false);
          notificationMoreText.add(false);
          classNotifications
              .sort((t1, t2) => t1.createTime.compareTo(t2.createTime));
          classNotifications = classNotifications.reversed.toList();
          print(newNotification);
          btnCreateController.success();
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [],
            ).show();
          });
        } else {
          var errorMsg = json.decode(utf8.decode(response.bodyBytes))['error'];
          if (errorMsg == null) errorMsg = "";
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
    notificationDescriptionController.text = "";
    notificationTitleController.text = "";
  }

  String convertDateToJalaliString(DateTime time) {
    time = time.add(Duration(hours: 3, minutes: 30));
    Jalali jalaliTime = Jalali.fromDateTime(time);
    int sal = jalaliTime.year;
    int mah = jalaliTime.month;
    int rooz = jalaliTime.day;
    return "$sal/$mah/$rooz";
  }

  String convertDateTimeToString(DateTime inputTime) {
    inputTime = inputTime.add(Duration(hours: 3, minutes: 30));
    int hour = inputTime.hour;
    String minute = inputTime.minute.toString();
    if (inputTime.minute < 10) minute = "0" + minute;
    return " $hour:$minute";
  }

  String _validateTitle(String value) {
    return "حداکثر ۲۵ کاراکتر";
  }
}
