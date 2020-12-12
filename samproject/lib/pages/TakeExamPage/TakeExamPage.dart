import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TakeExamPage extends StatefulWidget {
  Exam exam;


  TakeExamPage(this.exam);

  @override
  _TakeExamPageState createState() => _TakeExamPageState();
}

class _TakeExamPageState extends State<TakeExamPage> {
  // Exam exam = new Exam("", "", new DateTime(2020) , new DateTime(2020), 0);

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  void getQuestions() async{
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = "http://parham-backend.herokuapp.com/exam/" + widget.exam.examId + "/questions";
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        widget.exam.questions = [];
        if(response.statusCode == 200) {
          var questionsInfo = json.decode(
              utf8.decode(response.bodyBytes))["questions"];
          widget.exam.endDate = DateTime.parse(questionsInfo['user_examEndTime']);
          for (var questionInfoAndGrad in questionsInfo) {
            QuestionServer qs = new QuestionServer();
            qs.grade = questionInfoAndGrad["grade"];
            var questionInfo = questionInfoAndGrad["question"];
            qs.question = questionInfo["question"];
            qs.imageQuestion = questionInfo["imageQuestion"];
            qs.type = questionInfo["type"];
            qs.options = questionInfo["options"];
            Question q = Question.QuestionServerToQuestion(qs,qs.type);
            widget.exam.questions.add(q);
          }
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
  }
}
