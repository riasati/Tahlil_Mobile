import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/UserAnswer.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/CorrectionExam/StudentList.dart';
import 'package:samproject/pages/ReviewExamPage/ReviewExamPage.dart';
import 'package:samproject/pages/TakeExamPage/TakeExamPage.dart';
import 'package:samproject/pages/createExamPage.dart';
import 'package:samproject/pages/editExamAfterStartPage.dart';
import 'package:samproject/pages/editExamPage.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../homePage.dart';
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
  List<bool> examIsOpen = [];
  bool loadingPage = true;

  @override
  void initState() {
    super.initState();
    _getExamsListFromServer();
  }

  void _getExamsListFromServer() async {
    setState(() {
      loadingPage = true;
    });
    while (InsidClassPage.currentClass.classId == null ||
        InsidClassPage.currentClass.classId == "") {
      Future.delayed(Duration(milliseconds: 500));
    }
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
          print(response.body);
          var examsInfo = json.decode(utf8.decode(response.bodyBytes))["exams"];
          for (var examInfo in examsInfo) {
            Exam exam = Exam(
                examInfo["_id"],
                examInfo["name"],
                DateTime.parse(examInfo["startDate"]).toUtc(),
                DateTime.parse(examInfo["endDate"]).toUtc(),
                examInfo['examLength']);
            classExams.add(exam);
            examIsOpen.add(false);
            print(exam);
          }
          classExams.sort((t1, t2) => t1.startDate.compareTo(t2.startDate));
          classExams = classExams.reversed.toList();
          setState(() {});
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
      loadingPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: SafeArea(
        child: Column(children: [

          Expanded(child: examsList()),
          InsidClassPage.isAdmin?Container(
            //color: Colors.red,
            height: 60,
            child: Center(
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30),),
                  color: Color.fromRGBO(14, 145, 140, 1),
                ),
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateExamPage(
                              classId: InsidClassPage.currentClass.classId,
                            )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text("ساخت آزمون جدید", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
          ):Container(),
        ]),
      ),
      isLoading: loadingPage,
    );
  }

  Widget examsList() {
    if(classExams.isNotEmpty)
      return ListView.builder(
          itemCount: classExams.length,
          itemBuilder: (BuildContext context, int index) {
            return eachExamCard(index);
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
              padding: EdgeInsets.only(top: 200),
            ),
            Text(
              "آزمونی وجود ندارد",
            )
          ],
        ),
        width: double.infinity,
      );
  }

  Widget eachExamCard(int examIndex) {
    return Card(
      child: Column(
        children: [
          ListTile(
            tileColor: Color(0xFF3D5A80),
            leading: IconButton(
              icon: Icon(
                examIsOpen[examIndex]
                    ? FontAwesomeIcons.chevronCircleUp
                    : FontAwesomeIcons.chevronCircleDown,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  examIsOpen[examIndex] = !examIsOpen[examIndex];
                });
              },
            ),
            trailing: Text(
              classExams[examIndex].name,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          AnimatedContainer(
            child: examIsOpen[examIndex]
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Color(0xFF3D5A80),
                    )),
                    child: Column(
                      children: [
                        ListTile(
                          trailing: Icon(
                            FontAwesomeIcons.playCircle,
                            color: Color.fromRGBO(14, 145, 140, 1),
                          ),
                          title: Text(
                            "ساعت شروع آزمون: ",
                            style: TextStyle(),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Text(convertDateTimeToString(
                                          classExams[examIndex].startDate)),
                                    ),
                                    Icon(Icons.alarm),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(convertDateToJalaliString(
                                        classExams[examIndex].startDate)),
                                    Icon(FontAwesomeIcons.calendarCheck),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListTile(
                            trailing: Icon(
                              FontAwesomeIcons.stopCircle,
                              color: Colors.red,
                            ),
                            title: Text(
                              "ساعت پایان آزمون: ",
                              style: TextStyle(),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Text(convertDateTimeToString(
                                          classExams[examIndex].endDate)),
                                    ),
                                    Icon(Icons.alarm),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(convertDateToJalaliString(
                                        classExams[examIndex].endDate)),
                                    Icon(FontAwesomeIcons.calendarCheck),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListTile(
                            trailing: Icon(
                              FontAwesomeIcons.hourglassHalf,
                              color: Color(0xFF3D5A80),
                            ),
                            title: Text(
                              "مدت آزمون:   " + classExams[examIndex].examLength.toString() + " دقیقه" ,
                              style: TextStyle(),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        InsidClassPage.isAdmin
                            ? adminActions(examIndex, classExams[examIndex])
                            : memberActions(classExams[examIndex])
                      ],
                    ),
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

  Widget memberActions(Exam exam) {
    var memberAction;
    if (exam.endDate
        .isAfter(DateTime.now().toUtc().add(HomePage.subDeviceTimeAndServerTime)))
      memberAction = Container(
        child: Center(
          child: FlatButton(
            onPressed: () {
              getQuestionsForTakeExam(exam);
            },
            padding: EdgeInsets.all(0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    "شرکت آزمون",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(100, 0, 0, 1)),
                  ),
                ),
                Icon(
                  Icons.edit,
                  color: Color.fromRGBO(100, 0, 0, 1),
                ),
              ],
            ),
          ),
        ),
        width: 200,
        decoration: BoxDecoration(
          //color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          //color: userAnswer ? Colors.black : Colors.black26,
        ),
      );
    else
      memberAction = Row(
        children: [
          Container(
            child: FlatButton(
              onPressed: _launchURL,
              padding: EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      "مشاهده کارنامه",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.chartLine,
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
                getQuestionAndAnswerForReview(exam);
              },
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "مرور آزمون",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(14, 145, 140, 1),
                      ),
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.search,
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
      );
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        memberAction,
      ],
    );
  }

  _launchURL() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {
      return;
    }
    String url = "https://parham-backend.herokuapp.com/class/" + InsidClassPage.currentClass.classId + "/report?token=" + token;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget adminActions(int examIndex, Exam exam) {
    var correctionButton;
    if (exam.startDate
        .isBefore(DateTime.now().toUtc().add(HomePage.subDeviceTimeAndServerTime)))
      correctionButton = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentList(
                              exam.examId,
                            )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
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
                )),
            //width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              //color: Colors.red,
              //color: userAnswer ? Colors.black26 : Colors.black,
            ),
          ),
        ],
      );
    else
      correctionButton = Text("");
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: FlatButton(
                onPressed: () {
                  _checkRemoveExam(examIndex);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        "حذف آزمون",
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
              //width: 120,
              decoration: BoxDecoration(
                //color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                //color: userAnswer ? Colors.black : Colors.black26,
              ),
            ),
            Container(
              child: FlatButton(
                  onPressed: () {
                    if (exam.startDate
                        .isAfter(DateTime.now().toUtc().add(HomePage.subDeviceTimeAndServerTime)))
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditExamPage(
                                    examId: exam.examId,
                                    classId: InsidClassPage.currentClass.classId,
                                  )));
                    else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditExamAfterStartPage(
                                examId: exam.examId,
                                classId: InsidClassPage.currentClass.classId,
                              )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Text(
                          "ویرایش آزمون",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3D5A80),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: Color(0xFF3D5A80),
                      ),
                    ],
                  )),
              //width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                //color: Colors.red,
                //color: userAnswer ? Colors.black26 : Colors.black,
              ),
            ),
          ],
        ),
        correctionButton
      ],
    );
  }

  void _checkRemoveExam(int examIndex) {
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
                _pressRemoveExam(examIndex);
              },
              color: Color.fromRGBO(0, 100, 0, 1),
            ),
          ]).show();
    });
  }

  void _pressRemoveExam(int examIndex) async {
    setState(() {
      loadingPage = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _removeExamURL + classExams[examIndex].examId;
        print(url);
        final response = await delete(url, headers: {
          'accept': 'application/json',
          'Authorization': token,
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
          classExams.removeAt(examIndex);
          examIsOpen.removeAt(examIndex);
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
            var errorString =
            json.decode(utf8.decode(response.bodyBytes))["error"];
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
      loadingPage = false;
    });
  }

  void getQuestionsForTakeExam(Exam exam) async {
    setState(() {
      loadingPage = true;
    });
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
        print(response.body);
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
    setState(() {
      loadingPage = false;
    });
  }

  void getQuestionAndAnswerForReview(Exam exam) async {
    setState(() {
      loadingPage = true;
    });
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
            question.userAnswer.grade = questionGradeAnswerInfo["answerGrade"].toString();
            exam.questions.add(question);
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReviewExamPage(exam, false)));
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
    setState(() {
      loadingPage = false;
    });
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
