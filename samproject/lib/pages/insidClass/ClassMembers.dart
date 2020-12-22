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

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(child: Container(child: memberList(), color: Colors.black26,), isLoading: isLoading,);
  }

  void _getMembersListFromServer() async {
    setState(() {
      isLoading = true;
    });
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

  Widget memberList() {
    return ListView.builder(
        itemCount: classMembers.length,
        itemBuilder: (BuildContext context, int index) {
          return eachMemberCard(index);
        });
  }

  Widget eachMemberCard(int memberIndex) {
    return Card(
      child: Column(
        children: [
          ListTile(
            //tileColor: Color(0xFF3D5A80).withOpacity(0.9),
            leading: InsidClassPage.isAdmin
                ? IconButton(
                    icon: Icon(
                      memberIsOpen[memberIndex]
                          ? FontAwesomeIcons.chevronCircleUp
                          : FontAwesomeIcons.chevronCircleDown,
                      size: 25,
                      color: Colors.black,
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
                color: Colors.black
              ),
            ),
            //trailing: FlutterLogo(size: 45,),
            trailing: eachMemberCardAvatar(classMembers[memberIndex].avatarUrl),
          ),
          Container(
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
                                child: Icon(FontAwesomeIcons.userAlt, color: Color(0xFF3D5A80),),
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
                                child: Icon(FontAwesomeIcons.solidEnvelope, color: Color(0xFF3D5A80),),
                              )
                            ],
                          ),
                        ),
                        adminActions(classMembers[memberIndex]),
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

  Widget adminActions(Person member) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          Container(
            child: FlatButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "حذف کاربر",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
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

  void _checkRemoveMember(Person member) {
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
                _removeMember(member);
              },
              color: Colors.amber,
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),
          ]).show();
    });
  }

  void _removeMember(Person member) async {
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
        var url = _removeMemberURL +
            InsidClassPage.currentClass.classId +
            "/members/" +
            member.username;
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

  Widget eachMemberCardAvatar(String avatarUrl) {
    if (avatarUrl == null) {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage("assets/img/unnamed.png"),
        backgroundColor: Colors.transparent,
      );
    }
    try {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(avatarUrl),
        backgroundColor: Colors.transparent,
      );
    } on Exception catch (e) {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage("assets/img/unnamed.png"),
        backgroundColor: Colors.transparent,
      );
    }
  }
}
