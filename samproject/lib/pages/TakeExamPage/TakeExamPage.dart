import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/pages/TakeExamPage/BottomNavigator.dart';
import 'package:samproject/pages/TakeExamPage/LastPage.dart';
import 'package:samproject/pages/TakeExamPage/QuestionView.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TakeExamPage extends StatefulWidget {
  Exam exam;
  TakeExamPage(this.exam);

  @override
  _TakeExamPageState createState() => _TakeExamPageState();
}

class _TakeExamPageState extends State<TakeExamPage> {
  //Exam exam = new Exam("", "", new DateTime(2020) , new DateTime(2020), 0);
  int _currentQuestion = 0;
  GlobalKey<ScrollSnapListState> questionRouterKey = GlobalKey();
  DateTime user_examEndTime;
  int endTime;

  void endTimerFunction()
  {

  }
  void getQuestions()
  {
    // fill this exam.question
    // fill user_examEndTime
  }
  @override
  void initState() {
    super.initState();
    getQuestions();
    user_examEndTime = DateTime.now().add(Duration(hours: 1));
    endTime = user_examEndTime.millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: buildBottomNavigator(context),
        body: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(widget.exam.name,textDirection: TextDirection.rtl,),
                Expanded(child: Container()),
                CountdownTimer(endTime: endTime,onEnd: endTimerFunction,)
              ],
            ),
            Center(
              child: Card(
                child: QuestionViewInTakeExam(question: widget.exam.questions[_currentQuestion],ExamId: widget.exam.examId,questionIndex: _currentQuestion,),
              )
              // Container(
              //   child: Text(
              //     widget.exam.questions[_currentQuestion].kind
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavigator(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        // border: Border.all(10)
      ),
      height: 70,
      child: Row(
        children: [
          Expanded(child: previousButton()),
          Expanded(
              flex: 3,
              child: questionRouter()
          ),
          Expanded(
              child: nextButton()),
        ],
      ),
    );
  }

  Widget previousButton() {
    return Opacity(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFF3D5A80),
        ),
        margin: EdgeInsets.only(left: 3),
        child: MaterialButton(
          child: Text(
            "قبلی",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: (){
            setState(() {
              if(_currentQuestion > 0)
                _currentQuestion--;
                questionRouterKey.currentState.focusToItem(_currentQuestion);
            });
          },
        ),
      ),
      opacity: _currentQuestion == 0?0.0:1.0,
    );
  }

  Widget nextButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF3D5A80),
      ),
      margin: EdgeInsets.only(right: 3),
      child: MaterialButton(
        child: Text(
          _currentQuestion == widget.exam.questions.length - 1?"پایان":"بعدی",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: (){
          setState(() {
            if(_currentQuestion == widget.exam.questions.length - 1)
              Navigator.push(context, MaterialPageRoute(builder: (context) => LastPage(widget.exam.examId)));
            else
              _currentQuestion++;
              questionRouterKey.currentState.focusToItem(_currentQuestion);
          });
        },
      ),
    );
  }

  Widget questionRouter(){
    return Padding(
      child: Center(
        child: ScrollSnapList(
          onItemFocus: _onItemFocus,
          itemSize: 40,
          itemBuilder: _buildListItem,
          itemCount: widget.exam.questions.length,
          key: questionRouterKey,
          dynamicItemSize: true,
          reverse: false,
          // dynamicSizeEquation: (distance) {
          //   return 1;
          // },
          margin: EdgeInsets.only(left:10, right: 10),
          scrollDirection: Axis.horizontal,
          dynamicItemOpacity: 0.8,

        ),
      ),
      padding: EdgeInsets.only(right: 10, left: 10),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            _currentQuestion = index;
            questionRouterKey.currentState.focusToItem(_currentQuestion);
          });
        },
        color: Colors.red,
        textColor: Colors.white,
        height: 10,
        child: Text(
            (index + 1).toString(),
        ),

        shape: CircleBorder(),
      ),
      width: 40,
    );
  }

  void _onItemFocus(int index) {
    setState(() {
      //_currentQuestion = index;
    });
  }
}
