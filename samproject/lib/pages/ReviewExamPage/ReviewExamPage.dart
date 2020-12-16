
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
  ReviewExamPage(this.exam);
  @override
  _ReviewExamPageState createState() => _ReviewExamPageState();
}

class _ReviewExamPageState extends State<ReviewExamPage> {
  int _currentQuestion = 0;
  GlobalKey<ScrollSnapListState> questionRouterKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: buildBottomNavigator(context),
        body: Container(
          child: questionView(widget.exam.questions[_currentQuestion]),
        ),
      ),
    );
  }


  Widget questionView(Question question){
    var answerView;
    if(question.kind == "TEST")
      answerView = Expanded(child: TestQuestion(question), flex: 2,);
    else if(question.kind == "MULTICHOISE")
      answerView = Expanded(child: MultipleChoiceQuestion(question), flex: 2,);
    else if(question.kind == "SHORTANSWER")
      answerView = Expanded(child: ShortAnswerQuestion(question), flex: 1,);
    else{
      UserAnswerLong userAnswerLong = question.userAnswer;
      userAnswerLong.answerFile = "slkflskjdf";
      userAnswerLong.answerText = "ljsdlfj";
      answerView = Expanded(child: LongAnswerQuestion(question), flex: 2,);
    }
    // return Column(
    //   children: [
    //     Expanded(
    //       flex: 1,
    //       child: Center(
    //         child: QuestionViewInReviewExam(question: question, userAnswer:question.userAnswer),
    //       ),
    //     ),
    //     answerView,//answer
    //   ],
    // );

    return QuestionViewInReviewExam(question: question, userAnswer:question.userAnswer);

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
