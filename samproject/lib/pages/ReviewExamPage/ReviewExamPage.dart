
import 'package:flutter/material.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/MultipleChoiceQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/ShortAnswerQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/TestQuestion.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';


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
      answerView = TestQuestion(question);
    else if(question.kind == "MULTICHOISE")
      answerView = MultipleChoiceQuestion(question);
    else if(question.kind == "SHORTANSWER")
      answerView = ShortAnswerQuestion(question);
    else
      answerView = Container(child: Text("LONG ANSWER"),);
    return Column(
      children: [
        answerView,//answer
      ],
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
