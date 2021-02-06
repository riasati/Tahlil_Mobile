import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/ReviewExamPage.dart';
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
    _getStudentListFromServer();
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
            print(memberInfo['totalGrade']);
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3D5A80),
          title: Center(child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text("لیست دانش آموزان", style: TextStyle(fontWeight: FontWeight.bold),),
          )),
        ),
        body: LoadingOverlay(
          child: Container(
            child: memberList(),
          ),
          isLoading: isLoading,
        ),
      ),
    );
  }

  Widget memberList() {
    if(examStudents.isNotEmpty)
      return ListView.builder(
        itemCount: examStudents.length,
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
              padding: EdgeInsets.only(top: 200, left: 10),
            ),
            Text(
              "کسی در آزمون شرکت نکرده است",
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
                        Text(
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
              onPressed: () {
                _checkRemoveStudent(memberIndex);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "حذف از آزمون",
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

            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              //color: userAnswer ? Colors.black : Colors.black26,
            ),
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                _getStudentExam(member.username);
              },
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

  void _getStudentExam(String username) async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = "http://parham-backend.herokuapp.com/exam/" +
            widget.examId +
            "/attendees/" + username;
        final response = await get(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
          Exam studentExam = new Exam(widget.examId, "", DateTime.now(), DateTime.now(), 0);
          var questionsInfo =
          json.decode(utf8.decode(response.bodyBytes))["questions"];
          print(questionsInfo);
          for(var questionAndAnswerInfo in questionsInfo){
            Question question = new Question();
            var questionInfo = questionAndAnswerInfo["question"];
            question.text = questionInfo["question"];
            question.questionImage = questionInfo["imageQuestion"];
            question.kind = questionInfo["type"];
            question.answerImage = questionInfo["imageAnswer"];
            question.grade = questionAndAnswerInfo["grade"].toDouble();
            if (question.kind == "MULTICHOISE") {
              question.optionOne = questionInfo["options"][0]["option"];
              question.numberOne = 0;
              question.optionTwo = questionInfo["options"][1]["option"];
              question.numberTwo = 0;
              question.optionThree = questionInfo["options"][2]["option"];
              question.numberThree = 0;
              question.optionFour = questionInfo["options"][3]["option"];
              question.numberFour = 0;
              for (var answer in questionInfo["answers"]) {
                if (answer['answer'] == 1)
                  question.numberOne = 1;
                else if (answer['answer'] == 2)
                  question.numberTwo = 1;
                else if (answer['answer'] == 3)
                  question.numberThree = 1;
                else if (answer['answer'] == 4) question.numberFour = 1;
              }
              UserAnswerMultipleChoice userAnswerMultipleChoice =
              new UserAnswerMultipleChoice();
              if (questionAndAnswerInfo["answerText"] != null) {
                String answerText = questionAndAnswerInfo["answerText"];
                userAnswerMultipleChoice.userChoices =
                    answerText.split(",").map(int.parse).toList();
              } else
                userAnswerMultipleChoice.userChoices = [];
              question.userAnswer = userAnswerMultipleChoice;
            } else if (question.kind == "TEST") {
              question.optionOne = questionInfo["options"][0]["option"];
              question.numberOne = questionInfo["answers"][0]["answer"];
              question.optionTwo = questionInfo["options"][1]["option"];
              question.optionThree = questionInfo["options"][2]["option"];
              question.optionFour = questionInfo["options"][3]["option"];
              UserAnswerTest userAnswerTest = new UserAnswerTest();
              if (questionAndAnswerInfo["answerText"] != null)
                userAnswerTest.userChoice =
                    int.parse(questionAndAnswerInfo["answerText"]);
              else
                userAnswerTest.userChoice = -1;
              question.userAnswer = userAnswerTest;
            } else if (question.kind == "SHORTANSWER") {
              question.answerString = questionInfo['answers'][0]['answer'];
              UserAnswerShort userAnswerShort = new UserAnswerShort();
              if (questionAndAnswerInfo["answerText"] != null)
                userAnswerShort.answerText =
                questionAndAnswerInfo["answerText"];
              else
                userAnswerShort.answerText = "";
              question.userAnswer = userAnswerShort;
            } else {
              question.answerString = questionInfo['answers'][0]['answer'];
              UserAnswerLong userAnswerLong = new UserAnswerLong();
              if (questionAndAnswerInfo["answerText"] != null)
                userAnswerLong.answerText =
                questionAndAnswerInfo["answerText"];
              else
                userAnswerLong.answerText = "";
              if (questionAndAnswerInfo["answerFile"] != null)
                userAnswerLong.answerFile =
                questionAndAnswerInfo["answerFile"];
              else
                userAnswerLong.answerFile = "";
              question.userAnswer = userAnswerLong;
            }
            question.userAnswer.grade = questionAndAnswerInfo["answerGrade"].toString();
            studentExam.questions.add(question);
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReviewExamPage(studentExam, true,userName: username,)));
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

  void _checkRemoveStudent(int studentIndex) {
    setState(() {
      Alert(
          context: context,
          //type: AlertType.warning,
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
                _pressRemoveStudent(studentIndex);
              },
              color: Color.fromRGBO(0, 100, 0, 1),
            ),
          ]).show();
    });
  }

  void _pressRemoveStudent(int studentIndex) async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = "http://parham-backend.herokuapp.com/exam/" +
            widget.examId + "/attendees/" + examStudents[studentIndex].username;
        print(url);
        final response = await delete(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
          examStudents.removeAt(studentIndex);
          memberIsOpen.removeAt(studentIndex);
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [],
            ).show();
          });
        } else {
          var errorString =
          json.decode(utf8.decode(response.bodyBytes))["error"];
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: errorString,
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
      isLoading= false;
    });
  }
}
