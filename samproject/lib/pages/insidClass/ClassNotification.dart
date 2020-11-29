import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samproject/domain/Notification.dart';

import 'InsidClassPage.dart';

class ClassNotification extends StatefulWidget {

  final insidClassPageSetState;

  ClassNotification( {@required void toggleCoinCallback() }):
        insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassNotificationState createState() => _ClassNotificationState();
}

class _ClassNotificationState extends State<ClassNotification> {
  bool isLoading = false;
  String _getNotificationsOfClassInfoURL = "http://parham-backend.herokuapp.com/class/";
  String _removeNotificationURL = "http://parham-backend.herokuapp.com/class/";
  String _createNewNotificationURL = "http://parham-backend.herokuapp.com/class/";
  List<SumNotification> classNotifications = [];

  final RoundedLoadingButtonController btnCreateController =
  new RoundedLoadingButtonController();
  final TextEditingController notificationTitleController = TextEditingController();
  final TextEditingController notificationDescriptionController =
  TextEditingController();
  final TextEditingController editNotificationTitleController = TextEditingController();
  final TextEditingController editNotificationDescriptionController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Container(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          //color: Colors.black45,
          child: FlatButton(
            onPressed: () {
              _getNotificationsListFromServer();
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.bell,
                      size: 50,
                      color: Color(0xFF3D5A80),
                    ),
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: AutoSizeText(
                      "لیست اعلان ها",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 8),
                  //   child: Container(
                  //     alignment: Alignment.centerRight,
                  //     child: AutoSizeText(
                  //       "تعداد: 10",
                  //       maxLines: 1,
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // )

                ],
              ),
            ),
          ),
        ),
      ),
      widthFactor: 0.5,
    );
  }

  void _getNotificationsListFromServer() async {
    InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _getNotificationsOfClassInfoURL  + InsidClassPage.currentClass.classId + "/notes";
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        classNotifications = [];
        if(response.statusCode == 200) {
          var notificationsInfo = json.decode(
              utf8.decode(response.bodyBytes))["classNotes"];
          for (var notificationInfo in notificationsInfo) {
            SumNotification notification = SumNotification(notificationInfo["classNoteId"],
                notificationInfo["title"], notificationInfo["body"]);
            classNotifications.add(notification);
          }
          notificationsListBottomSheet();
        }else{
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: "عملیات ناموفق بود",
              buttons: [
              ],
            ).show();
          });
        }
      }
    }on Exception catch(e){
      print(e.toString());
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "عملیات ناموفق بود",
          buttons: [
          ],
        ).show();
      });
    }
    InsidClassPage.isLoading = false;
    widget?.insidClassPageSetState();
  }

  void notificationsListBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )
      ),
      barrierColor: Colors.black45.withOpacity(0.8),
      builder: (context) => Padding(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Icon(FontAwesomeIcons.gripLines),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                ),
              ),
            ),
            Expanded(child: notificationList(), flex: 8,),
            Expanded(
              child: FlatButton(
                onPressed: (){
                  Navigator.pop(context, );
                  _createNewNotificationBottomSheet();
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
            )

          ],
        ),
        padding: EdgeInsets.only(bottom: 20),
      ));

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
      return Container(
        height: 550,
        child: Column(
          children: [
            Container(
              child: Icon(FontAwesomeIcons.gripLines),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child:
                  Image.asset("assets/img/login_logo.png")),
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
                                  FontAwesomeIcons.bell,
                                  color: Colors.black,
                                ),
                                labelText: 'عنوان اعلان',
                                labelStyle: TextStyle(
                                    color: Color(0xFF3D5A80))),
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
                                    color: Color(0xFF3D5A80),
                                    fontSize: 25
                                )),
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
                          "ساخت",
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
      );
    },
  );

  Widget notificationList(){
    return ListView.builder(
        itemCount: classNotifications.length,
        itemBuilder: (BuildContext context, int index) {
          return eachNotificationCard(classNotifications[index]);
        }
    );
  }

  Widget eachNotificationCard(SumNotification notification){
    return Card(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        minWidth: double.infinity,
        onPressed: () {
          if(InsidClassPage.isAdmin)
            _showBodyOfNotification(notification);
        },
        child: Row(
          children: [
            InsidClassPage.isAdmin?adminActions(notification):Icon(Icons.expand_more_outlined),
            Padding(child: AutoSizeText('تاریخ اعلان', textAlign: TextAlign.right,), padding: EdgeInsets.only(left: 10),),
            Container(
              child: Padding(
                child: FittedBox(
                  child: Text(notification.title , textAlign: TextAlign.right, style: TextStyle(fontSize: 5),),
                  fit:BoxFit.fitWidth, ),
                padding: EdgeInsets.only(right: 10),),
              width: 70,

            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }

  Widget adminActions(SumNotification notification) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
      },
      child: Icon(
        Icons.more_vert,
        size: 35,
        color: Colors.red,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: FlatButton(
            child: Center(child: Text('حذف اعلان', style: TextStyle(color: Colors.red),)),
            padding: EdgeInsets.all(0),
            onPressed: () {
              _checkRemoveNotification(notification);
            },
          ),
        ),
        PopupMenuItem<String>(
          child: FlatButton(
            child: Center(child: Text('ویرایش اعلان', style: TextStyle(color: Colors.red),)),
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              editNotificationTitleController.text = notification.title;
              editNotificationDescriptionController.text = notification.body;
              _editNotificationBottomSheet(notification);
            },
          ),
        ),
      ],
    );
  }

  void _editNotificationBottomSheet(SumNotification notification) => showModalBottomSheet(
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
                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child:
                  Image.asset("assets/img/login_logo.png")),
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
                                  FontAwesomeIcons.bell,
                                  color: Colors.black,
                                ),
                                labelText: 'عنوان اعلان',
                                labelStyle: TextStyle(
                                    color: Color(0xFF3D5A80))),
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
                            controller: editNotificationDescriptionController,
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
                                    color: Color(0xFF3D5A80),
                                    fontSize: 25
                                )),
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
          title: Text("متن اعلان", textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AutoSizeText(notification.body, style: TextStyle(), textAlign: TextAlign.right, maxLines: 7,),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     style: ButtonStyle(
          //
          //     ),
          //     child: Text('Approve'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  void _checkRemoveNotification( SumNotification notification){
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
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop();
                _pressRemoveNotification(notification);
              },
              color: Colors.amber,
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),

          ]
      ).show();
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
        var url = _removeNotificationURL  + InsidClassPage.currentClass.classId + "/notes/" + notification.id;
        print(url);
        final response = await delete(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        if(response.statusCode == 200){
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [
              ],
            ).show();
          });
        }
        else{
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: "عملیات ناموفق بود",
              buttons: [
              ],
            ).show();
          });
        }
      }
    }on Exception catch(e){
      print(e.toString());
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "عملیات ناموفق بود",
          buttons: [
          ],
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
        final response = await post(_createNewNotificationURL + InsidClassPage.currentClass.classId + "/notes",
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
          SumNotification newNotification = SumNotification(notificationInfo["classNoteId"],
              notificationInfo["title"], notificationInfo["body"]);
          classNotifications.add(newNotification);
          print(newNotification);
          btnCreateController.success();
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [
              ],
            ).show();
          });
        } else {
          var errorMsg = json.decode(utf8.decode(response.bodyBytes))['error'];
          if(errorMsg == null)
            errorMsg = "";
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
        final response = await put(_createNewNotificationURL +
            InsidClassPage.currentClass.classId + "/notes/" + notification.id,
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
          notification = SumNotification(notificationInfo["classNoteId"],
              notificationInfo["title"], notificationInfo["body"]);
          print(notification);
          btnCreateController.success();
          Navigator.pop(context);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [
              ],
            ).show();
          });
        } else {
          var errorMsg = json.decode(utf8.decode(response.bodyBytes))['error'];
          if(errorMsg == null)
            errorMsg = "";
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
}
