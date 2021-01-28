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
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Person> examStudents = [];

  @override
  void initState() {
    super.initState();
    // _getStudentListFromServer();
    Person person = new Person();
    person.lastname = "Azarbad";
    person.avatarUrl = null;
    examStudents.add(person);
    examStudents.add(person);
    examStudents.add(person);
    examStudents.add(person);
    examStudents.add(person);
  }

  // void _getStudentListFromServer() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   while (InsidClassPage.currentClass.classId == null ||
  //       InsidClassPage.currentClass.classId == "") {
  //     Future.delayed(Duration(milliseconds: 500));
  //   }
  //   final prefs = await SharedPreferences.getInstance();
  //   print(prefs.getString("token"));
  //   String token = prefs.getString("token");
  //   try {
  //     if (token != null) {
  //       token = "Bearer " + token;
  //       var url = _getMembersOfClassInfoURL +
  //           InsidClassPage.currentClass.classId +
  //           "/members";
  //       final response = await get(url, headers: {
  //         'accept': 'application/json',
  //         'Authorization': token,
  //         'Content-Type': 'application/json',
  //       });
  //       examStudents = [];
  //       if (response.statusCode == 200) {
  //         var membersInfo =
  //             json.decode(utf8.decode(response.bodyBytes))["members"];
  //         for (var memberInfo in membersInfo) {
  //           Person member = Person();
  //           member.firstname = memberInfo["firstname"];
  //           member.lastname = memberInfo["lastname"];
  //           member.avatarUrl = memberInfo["avatar"];
  //           member.username = memberInfo["username"];
  //           member.email = memberInfo["email"];
  //           examStudents.add(member);
  //         }
  //       } else {
  //         setState(() {
  //           Alert(
  //             context: context,
  //             type: AlertType.error,
  //             title: "عملیات ناموفق بود",
  //             buttons: [],
  //           ).show();
  //         });
  //       }
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     setState(() {
  //       Alert(
  //         context: context,
  //         type: AlertType.error,
  //         title: "عملیات ناموفق بود",
  //         buttons: [],
  //       ).show();
  //     });
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        child: Container(
          child: memberList(),
        ),
        isLoading: false,
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
          FlatButton(
            onPressed: (){},
            child: ListTile(
              tileColor: Color(0xFF3D5A80),
              leading: Icon(
                FontAwesomeIcons.penSquare,
                color: Colors.white,
              ),
              title: Text(
                examStudents[memberIndex].lastname,
                textAlign: TextAlign.right,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              trailing: eachMemberCardAvatar(examStudents[memberIndex].avatarUrl),
            ),
            padding: EdgeInsets.all(0),
          ),
          // Container(
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //       color: Color(0xFF3D5A80),
          //     )),
          //     // color: Colors.black.withOpacity(0.3),
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 5),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Container(
          //             child: FlatButton(
          //               onPressed: () {},
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.only(right: 5),
          //                     child: Text(
          //                       "حذف کاربر",
          //                       textAlign: TextAlign.center,
          //                       style: TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                         color: Color.fromRGBO(14, 145, 140, 1),
          //                       ),
          //                     ),
          //                   ),
          //                   Icon(
          //                     Icons.remove_circle,
          //                     color: Color.fromRGBO(14, 145, 140, 1),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             width: double.infinity,
          //             decoration: BoxDecoration(
          //               //color: Colors.red,
          //               borderRadius: BorderRadius.all(Radius.circular(30)),
          //               //color: userAnswer ? Colors.black : Colors.black26,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ))
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
