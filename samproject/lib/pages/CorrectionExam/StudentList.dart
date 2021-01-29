import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentList extends StatefulWidget {

  String examId = "";


  StudentList(this.examId);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  String _getStudentListURL = "http://parham-backend.herokuapp.com/exam/";
  List<Person> examStudents = [];
  List<bool> memberIsOpen = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // _getStudentListFromServer();
    Person person = new Person();
    person.firstname = "حمیدرضا";
    person.lastname = "آذرباد";
    person.username = "lsjflskjfl";
    person.email = "ljdlfsjd";
    person.avatarUrl = null;
    examStudents.add(person);
    examStudents.add(person);
    examStudents.add(person);
    examStudents.add(person);
    examStudents.add(person);
    memberIsOpen.add(false);
    memberIsOpen.add(false);
    memberIsOpen.add(false);
    memberIsOpen.add(false);
    memberIsOpen.add(false);
  }

  void _getStudentListFromServer() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _getStudentListURL +
            widget.examId +
            "/attendees";
        print(url);
        final response = await get(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        examStudents = [];
        if (response.statusCode == 200) {
          var membersInfo =
              json.decode(utf8.decode(response.bodyBytes))["attendees"];
          for (var memberInfo in membersInfo) {
            Person student = Person();
            student.firstname = memberInfo["firstname"];
            student.lastname = memberInfo["lastname"];
            student.avatarUrl = memberInfo["avatar"];
            student.username = memberInfo["username"];
            student.email = memberInfo["email"];
            examStudents.add(student);
            memberIsOpen.add(false);
          }
        } else {
          String error = json.decode(utf8.decode(response.bodyBytes))["error"];
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: error,
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
    return Scaffold(
      body: LoadingOverlay(
        child: Container(
          child: memberList(),
        ),
        isLoading: isLoading,
      ),
    );
  }

  Widget memberList() {
    return ListView.builder(
        itemCount: examStudents.length,
        itemBuilder: (BuildContext context, int index) {
          return eachMemberCard(index);
        });
  }

  Widget eachMemberCard(int memberIndex) {
    return Card(
      child: Column(
        children: [
          ListTile(
            tileColor: Color(0xFF3D5A80),
            leading: IconButton(
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
            ),
            title: Text(
              examStudents[memberIndex].lastname,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            //trailing: FlutterLogo(size: 45,),
            trailing: eachMemberCardAvatar(examStudents[memberIndex].avatarUrl),
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
                          examStudents[memberIndex].firstname + " " + examStudents[memberIndex].lastname,
                          textAlign: TextAlign.right,
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
                          examStudents[memberIndex].email,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(FontAwesomeIcons.solidEnvelope, color: Color.fromRGBO(14, 145, 140, 1),),
                        )
                      ],
                    ),
                  ),
                  adminActions(memberIndex, examStudents[memberIndex]),
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

  Widget adminActions(int memberIndex, Person member) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
                      "تصحیح آزمون",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(14, 145, 140, 1),
                      ),
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.check,
                    color: Color.fromRGBO(14, 145, 140, 1),
                  ),
                ],
              ),
            ),
            width: 300,
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
}
