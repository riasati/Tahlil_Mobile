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

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: isLoading,
        child: Column(
            children: [
              Expanded(child: notificationList(), flex: 10,),
              _createNotificationButton()
            ])
    );
  }

  void _getNotificationsListFromServer() async {
    setState(() {
      isLoading = true;
    });
    while(InsidClassPage.currentClass.classId == null || InsidClassPage.currentClass.classId == ""){
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
                DateTime.parse(notificationInfo["createdAt"]));
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

  Widget _createNotificationButton() {
    if (InsidClassPage.isAdmin)
      return Expanded(
        child: FlatButton(
          onPressed: () {
          },
          child: Container(
            width: double.infinity,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(40.0)),
                  color: Color(0xFF3D5A80),
                ),
                child: Center(
                  child: Text(
                    "ساخت اعلان",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    else
      return Expanded(child: Text(""));
  }

  Widget notificationList() {
    return ListView.builder(
        itemCount: classNotifications.length,
        itemBuilder: (BuildContext context, int index) {
          return eachNotificationCard(index);
        });
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
                          ? adminActions(classNotifications[notificationIndex])
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
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        classNotifications[notificationIndex].body,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget adminActions(SumNotification notification) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          Container(
            child: FlatButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
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
                onPressed: () {},
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

  void _editNotificationBottomSheet(SumNotification notification) =>
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
          return Container(
            height: 550,
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
                  flex: 3,
                  child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Image.asset("assets/img/login_logo.png")),
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
                                controller: editNotificationTitleController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
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
                                controller:
                                    editNotificationDescriptionController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
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
                        _pressEditNotification(notification);
                      },
                    )),
                  ),
                  flex: 2,
                )
              ],
            ),
          );
        },
      );

  Future<void> _showBodyOfNotification(SumNotification notification) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "متن اعلان",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AutoSizeText(
                  notification.body,
                  style: TextStyle(),
                  textAlign: TextAlign.right,
                  maxLines: 7,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _checkRemoveNotification(SumNotification notification) {
    setState(() {
      Alert(
          context: context,
          type: AlertType.warning,
          title: "مایل به ادامه کار هستید؟",
          // content: Column(
          //   children: [
          //     Text(member.username),
          //     Text(member.firstname + " " + member.lastname , textAlign: TextAlign.end,)
          //   ],
          // ),
          buttons: [
            DialogButton(
              child: Text("بله"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _pressRemoveNotification(notification);
              },
              color: Colors.amber,
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),
          ]).show();
    });
  }

  void _pressRemoveNotification(SumNotification notification) async {
    Navigator.pop(context);
    Navigator.pop(context);
    InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _removeNotificationURL +
            InsidClassPage.currentClass.classId +
            "/notes/" +
            notification.id;
        print(url);
        final response = await delete(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
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
    InsidClassPage.isLoading = false;
    widget?.insidClassPageSetState();
  }

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

  void _pressEditNotification(SumNotification notification) async {
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
                notification.id,
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
          notification = SumNotification(
              notificationInfo["classNoteId"],
              notificationInfo["title"],
              notificationInfo["body"],
              DateTime.parse(notificationInfo["createdAt"]));
          print(notification);
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
}
