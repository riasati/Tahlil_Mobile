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
import 'package:http/http.dart' as http;


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
  int endTime;

  void endTimerFunction()
  {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LastPage(widget.exam.examId, true,widget.exam)));
    Navigator.pop(context);
  }

  PageController controller=PageController();
  List<Widget> _list=<Widget>[];
  void fillPageList()
  {
    for(int i = 0;i<widget.exam.questions.length;i++)
    {
      _list.add(QuestionViewInTakeExam(question: widget.exam.questions[i],ExamId: widget.exam.examId,questionIndex: i+1,));
    }
  }
  void setTimer() async
  {
    DateTime serverDate;
    var headers = {
      'accept': 'application/json',
    };
    var response = await http.get('https://parham-backend.herokuapp.com/public/time', headers: headers);
    if (response.statusCode == 200)
    {
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      serverDate = DateTime.parse(responseJson["date"]);
    }
    else
      {
        return;
      }
    endTime = DateTime.now().millisecondsSinceEpoch + (widget.exam.endDate.millisecondsSinceEpoch - serverDate.millisecondsSinceEpoch);
    setState(() {

    });
  }
  @override
  void initState() {
    setTimer();
    super.initState();
    fillPageList();
    print(widget.exam);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: buildBottomNavigator(context),
        appBar: AppBar(
          backgroundColor: Color(0xFF3D5A80),
          title: Container(
            //   padding: EdgeInsets.only(right: 40),
            alignment: Alignment.center,
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.exam.name,textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white,fontSize: 20.0),textAlign: TextAlign.center,),
                //   Expanded(child: Container()),
                CountdownTimer(endTime: endTime,onEnd: endTimerFunction,textStyle: TextStyle(color: Colors.white,fontSize: 20.0),)
              ],
            ),
          ),
        ),
        body: Card(
          child: PageView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            children: _list,
            onPageChanged: (num)
            {
              _currentQuestion = num;
              questionRouterKey.currentState.focusToItem(_currentQuestion);
              setState(() {

              });
            },
          ),
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
              controller.animateToPage(_currentQuestion, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
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
            {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LastPage(widget.exam.examId, false,widget.exam)));
            }
            else
              _currentQuestion++;
            controller.animateToPage(_currentQuestion, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
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
            controller.animateToPage(_currentQuestion, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
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
