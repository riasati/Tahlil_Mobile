import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassMembers extends StatefulWidget {
  final insidClassPageSetState;

  ClassMembers({@required void toggleCoinCallback()})
      : insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassMembersState createState() => _ClassMembersState();
}

class _ClassMembersState extends State<ClassMembers> {
  String _getMembersOfClassInfoURL =
      "http://parham-backend.herokuapp.com/class/";
  String _removeMemberURL = "http://parham-backend.herokuapp.com/class/";
  List<Person> classMembers = [];
  List<bool> memberIsOpen = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getMembersListFromServer();
  }

  void _getMembersListFromServer() async {
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
        var url = _getMembersOfClassInfoURL +
            InsidClassPage.currentClass.classId +
            "/members";
        final response = await get(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        classMembers = [];
        if (response.statusCode == 200) {
          var membersInfo =
          json.decode(utf8.decode(response.bodyBytes))["members"];
          for (var memberInfo in membersInfo) {
            Person member = Person();
            member.firstname = memberInfo["firstname"];
            member.lastname = memberInfo["lastname"];
            member.avatarUrl = memberInfo["avatar"];
            member.username = memberInfo["username"];
            member.email = memberInfo["email"];
            classMembers.add(member);
            memberIsOpen.add(false);
          }
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
    return LoadingOverlay(child: Container(child: memberList(),), isLoading: isLoading,);
  }

  Widget memberList() {
    if(classMembers.isNotEmpty)
      return ListView.builder(
          itemCount: classMembers.length,
          itemBuilder: (BuildContext context, int index) {
            return eachMemberCard(index);
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
              padding: EdgeInsets.only(top: 200, left: 20),
            ),
            Text(
              "کلاس خالی است",
            )
          ],
        ),
        width: double.infinity,
      );
  }

  Widget eachMemberCard(int memberIndex) {
    return Card(
      child: Column(
        children: [
          ListTile(
            tileColor: Color(0xFF3D5A80),
            leading: InsidClassPage.isAdmin
                ? IconButton(
                    icon: Icon(
                      memberIsOpen[memberIndex]
                          ? FontAwesomeIcons.chevronCircleUp
                          : FontAwesomeIcons.chevronCircleDown,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        memberIsOpen[memberIndex] = !memberIsOpen[memberIndex];
                      });
                    },
                  )
                : Text(""),
            title: Text(
                  classMembers[memberIndex].lastname,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            //trailing: FlutterLogo(size: 45,),
            trailing: eachMemberCardAvatar(classMembers[memberIndex].avatarUrl),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF3D5A80),
                )),
            // color: Colors.black.withOpacity(0.3),
            child: memberIsOpen[memberIndex]
                ? Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SelectableText(
                                classMembers[memberIndex].username,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(FontAwesomeIcons.userAlt, color: Color.fromRGBO(14, 145, 140, 1),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SelectableText(
                                classMembers[memberIndex].email,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(FontAwesomeIcons.solidEnvelope, color: Color.fromRGBO(14, 145, 140, 1),),
                              )
                            ],
                          ),
                        ),
                        adminActions(memberIndex, classMembers[memberIndex]),
                      ],
                    ),
                )
                : SizedBox(
                    height: 1,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget eachMemberCardAvatar(String avatarUrl) {
    if (avatarUrl == null) {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage("assets/img/unnamed.png"),
        backgroundColor: Colors.white,

      );
    }
    try {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(avatarUrl),
        backgroundColor: Colors.white,
        //onBackgroundImageError: ,
      );
    } on Exception catch (e) {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage("assets/img/unnamed.png"),
        backgroundColor: Colors.white,
      );
    }
  }

  Widget adminActions(int memberIndex, Person member) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          Container(
            child: FlatButton(
              onPressed: () {
                _checkRemoveMember(memberIndex);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "حذف کاربر",
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
        ],
      ),
    );
  }

  void _checkRemoveMember(int memberIndex) {
    setState(() {
      Alert(
          context: context,
          title: "مایل به ادامه کار هستید؟",
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
                _removeMember(memberIndex);
              },
              color: Color.fromRGBO(0, 100, 0, 1),
            ),
          ]).show();
    });
  }

  void _removeMember(int memberIndex) async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _removeMemberURL +
            InsidClassPage.currentClass.classId +
            "/members/" +
            classMembers[memberIndex].username;
        print(url);
        final response = await delete(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
          classMembers.removeAt(memberIndex);
          memberIsOpen.removeAt(memberIndex);
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
}
