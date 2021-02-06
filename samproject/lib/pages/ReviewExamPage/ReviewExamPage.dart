
import 'package:flutter/material.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/LongAnswer.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/MultipleChoiceQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/ShortAnswerQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/TestQuestion.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'QuestionView.dart';


class ReviewExamPage extends StatefulWidget {
  Exam exam;
  ReviewExamPage(this.exam,this.isTeacherUsing,{this.userName = null});
  bool isTeacherUsing = false;
  String userName;
  static List<double> grades = [];
  @override
  _ReviewExamPageState createState() => _ReviewExamPageState();
}

class _ReviewExamPageState extends State<ReviewExamPage> {
  int _currentQuestion = 0;
  GlobalKey<ScrollSnapListState> questionRouterKey = GlobalKey();
  PageController controller=PageController();
  List<Widget> _list=<Widget>[];
 // bool isTeacherUsing = false;
  void fillPageList()
  {
    for(int i = 0;i<widget.exam.questions.length;i++)
    {
      _list.add(QuestionViewInReviewExam(question: widget.exam.questions[i],isTeacherUsing: widget.isTeacherUsing,questionIndex:i+1,examId: widget.exam.examId,userName: widget.userName,));
    }
  }
  void fillGrades()
  {
    for (int i = 0;i<widget.exam.questions.length;i++)
    {
      if (widget.exam.questions[i].userAnswer.grade == "null")
      {
        widget.exam.questions[i].userAnswer.grade = 0.toString();
      }
      ReviewExamPage.grades.add(double.tryParse(widget.exam.questions[i].userAnswer.grade));
    }
  }

  @override
  void initState() {
    super.initState();
    ReviewExamPage.grades.clear();
    fillPageList();
    fillGrades();
    //print(ReviewExamPage.grades.length);
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
            child: (widget.isTeacherUsing) ? Text(//widget.exam.name
              "تصحیح "  + widget.exam.name,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ) :Text(//widget.exam.name
              "مرور "  + widget.exam.name,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
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
        ),//QuestionViewInReviewExam(question:widget.exam.questions[_currentQuestion]),
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
    return Container(
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
            else
              Navigator.pop(context);
            controller.animateToPage(_currentQuestion, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
            questionRouterKey.currentState.focusToItem(_currentQuestion);
          });
        },
      ),
    );
  }

  Widget nextButton() {
    return Opacity(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFF3D5A80),
        ),
        margin: EdgeInsets.only(right: 3),
        child: MaterialButton(
          child: Text(
            "بعدی",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: (){
            setState(() {
              if(_currentQuestion == widget.exam.questions.length - 1)
                print("finish");
              else
                _currentQuestion++;
              controller.animateToPage(_currentQuestion, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
              questionRouterKey.currentState.focusToItem(_currentQuestion);
            });
          },
        ),
      ),
      opacity: _currentQuestion == widget.exam.questions.length - 1?0:1,
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
      _currentQuestion = index;
    });
  }
}
