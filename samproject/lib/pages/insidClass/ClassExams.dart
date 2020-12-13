import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/pages/editExamPage.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InsidClassPage.dart';

class ClassExams extends StatefulWidget {

  final insidClassPageSetState;

  ClassExams( {@required void toggleCoinCallback() }):
        insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassExamsState createState() => _ClassExamsState();
}

class _ClassExamsState extends State<ClassExams> {

  String _getExamsOfClassInfoURL = "http://parham-backend.herokuapp.com/class/";
  String _removeExamURL = "http://parham-backend.herokuapp.com/exam/";
  List<Exam> classExams = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        //color: Colors.black45,
        child: FlatButton(
          onPressed: () {
            _getExamsListFromServer();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    FontAwesomeIcons.questionCircle,
                    size: 50,
                    color: Color(0xFF3D5A80),
                  ),
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: AutoSizeText(
                    "لیست آزمون ها",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
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
        var url = _getExamsOfClassInfoURL  + InsidClassPage.currentClass.classId + "/exams";
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        classExams = [];
        if(response.statusCode == 200) {
          var examsInfo = json.decode(
              utf8.decode(response.bodyBytes))["exams"];
          for (var examInfo in examsInfo) {
            Exam exam = Exam(examInfo["_id"], examInfo["name"],
                DateTime.parse(examInfo["startDate"]), DateTime.parse(examInfo["endDate"]), examInfo['examLength']);
            classExams.add(exam);
            DateTime d = DateTime.parse(examInfo["startDate"]);
            Jalali j = Jalali.fromDateTime(d);
          }
          classExams.sort((t1, t2) => t1.startDate.compareTo(t2.startDate));
          classExams = classExams.reversed.toList();
          examsListBottomSheet();
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

  void examsListBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )
      ),
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

  Widget examsList(){
    return ListView.builder(
        itemCount: classExams.length,
        itemBuilder: (BuildContext context, int index) {
          return eachExamCard(classExams[index]);
        }
    );
  }

  Widget eachExamCard(Exam exam){
    String date = convertDateToJalaliString(exam.startDate);
    String dateAndTime = addTimeToDate(date, exam.startDate);
    return Card(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        minWidth: double.infinity,
        onPressed: () {
          _showInfoOfExam(exam);
        },
        child: Row(
          children: [
            InsidClassPage.isAdmin?adminActions(exam):memberActions(exam),
            Padding(child: AutoSizeText(dateAndTime, textAlign: TextAlign.right,), padding: EdgeInsets.only(left: 10),),
            Container(
              child: Padding(
                child: FittedBox(
                  child: Text(exam.name , textAlign: TextAlign.right, style: TextStyle(fontSize: 5),),
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
          title: Text("اطلاعات آزمون", textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AutoSizeText(startDateAndTime + " :شروع آزمون", style: TextStyle(), textAlign: TextAlign.right, maxLines: 1,),
                AutoSizeText(endDateAndTime + " :پایان آزمون", style: TextStyle(), textAlign: TextAlign.right, maxLines: 1,),
                AutoSizeText( exam.examLength.toString() +  " :مدت زمان", style: TextStyle(), textAlign: TextAlign.right, maxLines: 1,),
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
          onPressed: (){
            getQuestions(exam);
          },
          child: Container(
            color: Color.fromRGBO(14, 145, 140, 1),
            child: Padding(
              child: Center(
                child: AutoSizeText(
                "شرکت در آزمون",
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

  void getQuestions(Exam exam) async{
    Navigator.pop(context);
    InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    print(exam);
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = "http://parham-backend.herokuapp.com/exam/" + exam.examId + "/questions";
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        exam.questions = [];
        if(response.statusCode == 200) {
          var questionsInfo = json.decode(
              utf8.decode(response.bodyBytes))["questions"];
          exam.endDate = DateTime.parse(questionsInfo['user_examEndTime']);
          for (var questionInfoAndGrad in questionsInfo) {
            QuestionServer qs = new QuestionServer();
            qs.grade = questionInfoAndGrad["grade"];
            var questionInfo = questionInfoAndGrad["question"];
            qs.question = questionInfo["question"];
            qs.imageQuestion = questionInfo["imageQuestion"];
            qs.type = questionInfo["type"];
            qs.options = questionInfo["options"];
            Question q = Question.QuestionServerToQuestion(qs,qs.type);
            exam.questions.add(q);
            print(q);
          }
        }else{
          print(response.body);
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: "زمان آزمون فرانرسیده",
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

  Widget adminActions(Exam exam) {
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
            child: Center(child: Text('حذف ازمون', style: TextStyle(color: Colors.red),)),
            padding: EdgeInsets.all(0),
            onPressed: () {
              _checkRemoveExam(exam);
            },
          ),
        ),
        PopupMenuItem<String>(
          child: FlatButton(
            child: Center(child: Text('ویرایش آزمون', style: TextStyle(color: Colors.red),)),
            padding: EdgeInsets.all(0),
            onPressed: () {
              print(exam.examId);
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditExamPage(classId: InsidClassPage.currentClass.classId,examId: exam.examId,)));

            },
          ),
        ),
      ],
    );
  }

  void _checkRemoveExam( Exam exam){
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
                _pressRemoveExam(exam);
              },
              color: Colors.amber,
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),

          ]
      ).show();
    });
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
        var url = _removeExamURL  + exam.examId;
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

  String convertDateToJalaliString(DateTime time){
    Jalali jalaliTime = Jalali.fromDateTime(time);
    int sal = jalaliTime.year;
    int mah = jalaliTime.month;
    int rooz = jalaliTime.day;
    return "$sal/$mah/$rooz";
  }

  String addTimeToDate(String date, DateTime inputTime){
    int hour = inputTime.hour;
    String minute = inputTime.minute.toString();
    if(inputTime.minute < 10)
      minute = "0" + minute;
    String time = " $hour:$minute";
    return date + time;
  }
}

