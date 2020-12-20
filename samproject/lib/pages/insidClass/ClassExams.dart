import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/UserAnswer.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/ReviewExamPage.dart';
import 'package:samproject/pages/TakeExamPage/TakeExamPage.dart';
import 'package:samproject/pages/editExamPage.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InsidClassPage.dart';

class ClassExams extends StatefulWidget {
  final insidClassPageSetState;

  ClassExams({@required void toggleCoinCallback()})
      : insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassExamsState createState() => _ClassExamsState();
}

class _ClassExamsState extends State<ClassExams> {
  String _getExamsOfClassInfoURL = "http://parham-backend.herokuapp.com/class/";
  String _removeExamURL = "http://parham-backend.herokuapp.com/exam/";
  List<Exam> classExams = [];

  @override
  Widget build(BuildContext context) {
    return eachExamCard();
    // return Container(
    //   child: Card(
    //     elevation: 4,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(30))),
    //     //color: Colors.black45,
    //     child: FlatButton(
    //       onPressed: () {
    //         _getExamsListFromServer();
    //       },
    //       child: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Container(
    //               child: Icon(
    //                 FontAwesomeIcons.questionCircle,
    //                 size: 50,
    //                 color: Color(0xFF3D5A80),
    //               ),
    //               alignment: Alignment.center,
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(top: 15),
    //               child: AutoSizeText(
    //                 "لیست آزمون ها",
    //                 maxLines: 1,
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.w900,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  void _getExamsListFromServer() async {
    InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    print(token);
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _getExamsOfClassInfoURL +
            InsidClassPage.currentClass.classId +
            "/exams";
        final response = await get(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        classExams = [];
        if (response.statusCode == 200) {
          var examsInfo = json.decode(utf8.decode(response.bodyBytes))["exams"];
          for (var examInfo in examsInfo) {
            Exam exam = Exam(
                examInfo["_id"],
                examInfo["name"],
                DateTime.parse(examInfo["startDate"]),
                DateTime.parse(examInfo["endDate"]),
                examInfo['examLength']);
            classExams.add(exam);
            DateTime d = DateTime.parse(examInfo["startDate"]);
            Jalali j = Jalali.fromDateTime(d);
          }
          classExams.sort((t1, t2) => t1.startDate.compareTo(t2.startDate));
          classExams = classExams.reversed.toList();
          examsListBottomSheet();
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

  void examsListBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      )),
      barrierColor: Colors.black45.withOpacity(0.8),
      builder: (context) => Column(
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
              Expanded(child: examsList()),
            ],
          ));

  Widget examsList() {
    return ListView.builder(
        itemCount: classExams.length,
        itemBuilder: (BuildContext context, int index) {
          return eachExamCard();
        });
  }

  Widget eachExamCard() {
    // String date = convertDateToJalaliString(exam.startDate);
    // String dateAndTime = addTimeToDate(date, exam.startDate);
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.expand_more_sharp),
              onPressed: () {},
            ),
            trailing: Text("Title of exam"),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        trailing: Icon(Icons.calendar_today_sharp),
                        title: Text("1399/10/10"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        trailing: Icon(Icons.alarm),
                        title: Text("10:30"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        trailing: Icon(Icons.calendar_today_sharp),
                        title: Text("1399/10/10"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        trailing: Icon(Icons.alarm),
                        title: Text("10:30"),
                      ),
                    ),
                  ],
                ),
                ButtonBar(
                  children: [
                    Container(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "پاسخ شما",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                        //color: userAnswer ? Colors.black : Colors.black26,
                      ),
                    ),
                    Container(
                      child: FlatButton(
                          onPressed: () {
                          },
                          child: Text(
                            "پاسخ سوال",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                            ),
                          )),
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        //color: userAnswer ? Colors.black26 : Colors.black,
                      ),
                    ),
                  ],
                  alignment: MainAxisAlignment.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showInfoOfExam(Exam exam) async {
    String startDate = convertDateToJalaliString(exam.startDate);
    String startDateAndTime = addTimeToDate(startDate, exam.startDate);
    String endDate = convertDateToJalaliString(exam.endDate);
    String endDateAndTime = addTimeToDate(endDate, exam.endDate);
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "اطلاعات آزمون",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AutoSizeText(
                  startDateAndTime + " :شروع آزمون",
                  style: TextStyle(),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
                AutoSizeText(
                  endDateAndTime + " :پایان آزمون",
                  style: TextStyle(),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
                AutoSizeText(
                  exam.examLength.toString() + " :مدت زمان",
                  style: TextStyle(),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget memberActions(Exam exam) {
    return Row(
      children: [
        FlatButton(
          onPressed: () {
            if (endTimeIsAfter(exam))
              getQuestions(exam);
            else
              getQuestionAndAnswerForReview(exam);
          },
          child: Container(
            color: Color.fromRGBO(14, 145, 140, 1),
            child: Padding(
              child: Center(
                child: AutoSizeText(
                  endTimeIsAfter(exam) ? "شرکت در آزمون" : "مرور آزمون",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              padding: EdgeInsets.only(left: 2, right: 7, top: 2, bottom: 2),
            ),
          ),
          padding: EdgeInsets.all(0),
        ),
      ],
    );
  }

  void getQuestions(Exam exam) async {
    Navigator.pop(context);
    InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    print(exam.examId);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = "http://parham-backend.herokuapp.com/exam/" +
            exam.examId +
            "/questions";
        final response = await get(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        exam.questions = [];
        if (response.statusCode == 200) {
          var questionsInfo =
              json.decode(utf8.decode(response.bodyBytes))["questions"];
          exam.endDate = DateTime.parse(
              json.decode(utf8.decode(response.bodyBytes))['user_examEndTime']);
          //print(response.body);
          for (var questionGradeAnswerInfo in questionsInfo) {
            Question question = new Question();
            var questionInfo = questionGradeAnswerInfo["question"];
            question.index = questionInfo["index"];
            question.text = questionInfo["question"];
            question.questionImage = questionInfo["imageQuestion"];
            question.kind = questionInfo["type"];
            if (question.kind == "MULTICHOISE" || question.kind == "TEST") {
              question.optionOne = questionInfo["options"][0]["option"];
              question.optionTwo = questionInfo["options"][1]["option"];
              question.optionThree = questionInfo["options"][2]["option"];
              question.optionFour = questionInfo["options"][3]["option"];
            }
            if (questionGradeAnswerInfo["answerText"] != null) {
              if (question.kind == "TEST") {
                UserAnswerTest userAnswerTest = new UserAnswerTest();
                userAnswerTest.userChoice =
                    int.parse(questionGradeAnswerInfo["answerText"]);
                question.numberOne = userAnswerTest.userChoice;
                question.userAnswer = userAnswerTest;
              } else if (question.kind == "MULTICHOISE") {
                UserAnswerMultipleChoice userAnswerMultipleChoice =
                    new UserAnswerMultipleChoice();
                String answerText = questionGradeAnswerInfo["answerText"];
                userAnswerMultipleChoice.userChoices =
                    answerText.split(",").map(int.parse).toList();
                question.numberOne = 0;
                question.numberTwo = 0;
                question.numberThree = 0;
                question.numberFour = 0;
                if (userAnswerMultipleChoice.userChoices.contains(1))
                  question.numberOne = 1;
                if (userAnswerMultipleChoice.userChoices.contains(2))
                  question.numberTwo = 1;
                if (userAnswerMultipleChoice.userChoices.contains(3))
                  question.numberThree = 1;
                if (userAnswerMultipleChoice.userChoices.contains(4))
                  question.numberFour = 1;
                question.userAnswer = userAnswerMultipleChoice;
              } else if (question.kind == "SHORTANSWER") {
                UserAnswerShort userAnswerShort = new UserAnswerShort();
                userAnswerShort.answerText =
                    questionGradeAnswerInfo["answerText"];
                question.userAnswer = userAnswerShort;
              } else {
                UserAnswerLong userAnswerLong = new UserAnswerLong();
                if (questionGradeAnswerInfo["answerText"] != null)
                  userAnswerLong.answerText =
                      questionGradeAnswerInfo["answerText"];
                else
                  userAnswerLong.answerText = "";
                if (questionGradeAnswerInfo["answerFile"] != null)
                  userAnswerLong.answerFile =
                      questionGradeAnswerInfo["answerFile"];
                else
                  userAnswerLong.answerFile = "";
                question.userAnswer = userAnswerLong;
              }
            }
            question.grade = questionGradeAnswerInfo["grade"].toDouble();
            //print(question);
            exam.questions.add(question);
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TakeExamPage(exam)));
        } else {
          print(response.body);
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: "زمان آزمون فرانرسیده",
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

  Widget adminActions(Exam exam) {
    return PopupMenuButton<String>(
      onSelected: (String value) {},
      child: Icon(
        Icons.more_vert,
        size: 35,
        color: Colors.red,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: FlatButton(
            child: Center(
                child: Text(
              'حذف ازمون',
              style: TextStyle(color: Colors.red),
            )),
            padding: EdgeInsets.all(0),
            onPressed: () {
              _checkRemoveExam(exam);
            },
          ),
        ),
        PopupMenuItem<String>(
          child: FlatButton(
            child: Center(
                child: Text(
              'ویرایش آزمون',
              style: TextStyle(color: Colors.red),
            )),
            padding: EdgeInsets.all(0),
            onPressed: () {
              print(exam.examId);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditExamPage(
                            classId: InsidClassPage.currentClass.classId,
                            examId: exam.examId,
                          )));
            },
          ),
        ),
      ],
    );
  }

  void _checkRemoveExam(Exam exam) {
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
                _pressRemoveExam(exam);
              },
              color: Colors.amber,
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),
          ]).show();
    });
  }

  void getQuestionAndAnswerForReview(Exam exam) async {
    Navigator.pop(context);
    //InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    print(exam.examId);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = "http://parham-backend.herokuapp.com/exam/" +
            exam.examId +
            "/questions/review";
        final response = await get(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        exam.questions = [];
        if (response.statusCode == 200) {
          var questionsInfo =
              json.decode(utf8.decode(response.bodyBytes))["questions"];
          for (var questionGradeAnswerInfo in questionsInfo) {
            Question question = new Question();
            var questionInfo = questionGradeAnswerInfo["question"];
            question.text = questionInfo["question"];
            question.questionImage = questionInfo["imageQuestion"];
            question.kind = questionInfo["type"];
            question.grade = questionGradeAnswerInfo["grade"].toDouble();
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
              if (questionGradeAnswerInfo["answerText"] != null) {
                String answerText = questionGradeAnswerInfo["answerText"];
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
              if (questionGradeAnswerInfo["answerText"] != null)
                userAnswerTest.userChoice =
                    int.parse(questionGradeAnswerInfo["answerText"]);
              else
                userAnswerTest.userChoice = -1;
              question.userAnswer = userAnswerTest;
            } else if (question.kind == "SHORTANSWER") {
              question.answerString = questionInfo['answers'][0]['answer'];
              UserAnswerShort userAnswerShort = new UserAnswerShort();
              if (questionGradeAnswerInfo["answerText"] != null)
                userAnswerShort.answerText =
                    questionGradeAnswerInfo["answerText"];
              else
                userAnswerShort.answerText = "";
              question.userAnswer = userAnswerShort;
            } else {
              question.answerString = questionInfo['answers'][0]['answer'];
              UserAnswerLong userAnswerLong = new UserAnswerLong();
              if (questionGradeAnswerInfo["answerText"] != null)
                userAnswerLong.answerText =
                    questionGradeAnswerInfo["answerText"];
              else
                userAnswerLong.answerText = "";
              if (questionGradeAnswerInfo["answerFile"] != null)
                userAnswerLong.answerFile =
                    questionGradeAnswerInfo["answerFile"];
              else
                userAnswerLong.answerFile = "";
              question.userAnswer = userAnswerLong;
            }
            print(question);
            exam.questions.add(question);
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReviewExamPage(exam)));
        } else {
          print(response.body);
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: json.decode(utf8.decode(response.bodyBytes))["error"],
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

  void _pressRemoveExam(Exam exam) async {
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
        var url = _removeExamURL + exam.examId;
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

  bool endTimeIsAfter(Exam exam) {
    return exam.endDate.isAfter(DateTime.now());
  }

  String convertDateToJalaliString(DateTime time) {
    time = time.add(Duration(hours: 3, minutes: 30));
    Jalali jalaliTime = Jalali.fromDateTime(time);
    int sal = jalaliTime.year;
    int mah = jalaliTime.month;
    int rooz = jalaliTime.day;
    return "$sal/$mah/$rooz";
  }

  String addTimeToDate(String date, DateTime inputTime) {
    inputTime = inputTime.add(Duration(hours: 3, minutes: 30));
    int hour = inputTime.hour;
    String minute = inputTime.minute.toString();
    if (inputTime.minute < 10) minute = "0" + minute;
    String time = " $hour:$minute";
    return date + time;
  }
}
