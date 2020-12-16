import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswer.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/LongAnswer.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/MultipleChoiceQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/ShortAnswerQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/TestQuestion.dart';
import 'package:samproject/widgets/questionWidgets.dart';

class QuestionViewInReviewExam extends StatefulWidget {
  Question question;

  QuestionViewInReviewExam({Key key, this.question})
      : super(key: key);

  @override
  _QuestionViewInReviewExamState createState() =>
      _QuestionViewInReviewExamState();
}

class _QuestionViewInReviewExamState extends State<QuestionViewInReviewExam> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              //textDirection: TextDirection.rtl,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            "بارم",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                          ),
                          Text(widget.question.grade.toString(),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: NotEditingQuestionText(
                        question: widget.question,
                      ),
                    ),
                  ],
                ),
                // if (widget.question.kind == "چند گزینه ای"/*HomePage.maps.SKindMap["MULTICHOISE"]*/) MultipleChoiceQuestion(widget.question)
                // else if (widget.question.kind == "تست"/*HomePage.maps.SKindMap["TEST"]*/) TestQuestion(widget.question)
                // else if (widget.question.kind == "پاسخ کوتاه"/*HomePage.maps.SKindMap["SHORTANSWER"]*/) ShortAnswerQuestion(widget.question)
                //   else if (widget.question.kind == "تشریحی"/*HomePage.maps.SKindMap["LONGANSWER"]*/) ShortAnswerQuestion(widget.question),

                if (widget.question.kind ==
                    "MULTICHOISE")
                  MultipleChoiceQuestion(widget.question)
                else if (widget.question.kind ==
                    "TEST" )
                  TestQuestion(widget.question,)
                else if (widget.question.kind ==
                      "SHORTANSWER" )
                    ShortAnswerQuestion(widget.question)
                  else
                    LongAnswerWidgetInReivuew(question: widget.question,),

                if (widget.question.kind ==
                    "MULTICHOISE")
                  MultiChoiceWidgetInReview(question: widget.question,userAnswerMultipleChoice: widget.question.userAnswer,)
                else if (widget.question.kind ==
                    "TEST")
                  TestWidgetInReview(question: widget.question,userAnswerTest: widget.question.userAnswer,)
                else if (widget.question.kind ==
                      "SHORTANSWER")
                    ShortAnswerQuestion(widget.question)
                  else
                    LongAnswerWidgetInReivuew(question: widget.question,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiChoiceWidgetInReview extends StatefulWidget {
  Question question;
  UserAnswerMultipleChoice userAnswerMultipleChoice;

  MultiChoiceWidgetInReview(
      {Key key, this.question, this.userAnswerMultipleChoice})
      : super(key: key);

  @override
  _MultiChoiceWidgetInReviewState createState() =>
      _MultiChoiceWidgetInReviewState();
}

class _MultiChoiceWidgetInReviewState extends State<MultiChoiceWidgetInReview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberOne == 1 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(1))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberOne == 0 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(1))
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberOne == 1 &&
                  !widget.userAnswerMultipleChoice.userChoices.contains(1))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else
                Container(
                  width: 30,
                ),
              Checkbox(
                  value:
                      (widget.userAnswerMultipleChoice.userChoices.contains(1))
                          ? true
                          : false,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionOne,
                      textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberTwo == 1 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(2))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberTwo == 0 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(2))
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberTwo == 1 &&
                  !widget.userAnswerMultipleChoice.userChoices.contains(2))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else
                Container(
                  width: 30,
                ),
              Checkbox(
                  value:
                      (widget.userAnswerMultipleChoice.userChoices.contains(2))
                          ? true
                          : false,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionTwo,
                      textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberThree == 1 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(3))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberThree == 0 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(3))
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberThree == 1 &&
                  !widget.userAnswerMultipleChoice.userChoices.contains(3))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else
                Container(
                  width: 30,
                ),
              Checkbox(
                  value:
                      (widget.userAnswerMultipleChoice.userChoices.contains(3))
                          ? true
                          : false,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionThree,
                      textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberFour == 1 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(4))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberFour == 0 &&
                  widget.userAnswerMultipleChoice.userChoices.contains(4))
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberFour == 1 &&
                  !widget.userAnswerMultipleChoice.userChoices.contains(4))
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else
                Container(
                  width: 30,
                ),
              Checkbox(
                  value:
                      (widget.userAnswerMultipleChoice.userChoices.contains(4))
                          ? true
                          : false,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionFour,
                      textDirection: TextDirection.rtl))
            ],
          ),
        ],
      ),
    );
  }
}

class TestWidgetInReview extends StatefulWidget {
  Question question;
  UserAnswerTest userAnswerTest;

  TestWidgetInReview({Key key, this.question, this.userAnswerTest})
      : super(key: key);

  @override
  _TestWidgetInReviewState createState() => _TestWidgetInReviewState();
}

class _TestWidgetInReviewState extends State<TestWidgetInReview> {
  int _radioGroupValue;

  @override
  void initState() {
    super.initState();
    if (widget.userAnswerTest.userChoice != null) {
      _radioGroupValue = widget.userAnswerTest.userChoice;
    } else {
      _radioGroupValue = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberOne == 1 &&
                  widget.userAnswerTest.userChoice == null)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else if (widget.userAnswerTest.userChoice == null)
                Container(
                  width: 30,
                )
              else if (widget.question.numberOne == 1 &&
                  widget.userAnswerTest.userChoice == 1)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberOne == 1 &&
                  widget.userAnswerTest.userChoice != 1)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberOne != 1 &&
                  widget.userAnswerTest.userChoice == 1)
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else
                Container(
                  width: 30,
                ),
              Radio(
                  visualDensity: VisualDensity.compact,
                  value: 1,
                  groupValue: _radioGroupValue,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionOne,
                      textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberOne == 2 &&
                  widget.userAnswerTest.userChoice == null)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else if (widget.userAnswerTest.userChoice == null)
                Container(
                  width: 30,
                )
              else if (widget.question.numberOne == 2 &&
                  widget.userAnswerTest.userChoice == 2)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberOne == 2 &&
                  widget.userAnswerTest.userChoice != 2)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberOne != 2 &&
                  widget.userAnswerTest.userChoice == 2)
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else
                Container(
                  width: 30,
                ),
              Radio(
                  visualDensity: VisualDensity.compact,
                  value: 2,
                  groupValue: _radioGroupValue,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionTwo,
                      textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberOne == 3 &&
                  widget.userAnswerTest.userChoice == null)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else if (widget.userAnswerTest.userChoice == null)
                Container(
                  width: 30,
                )
              else if (widget.question.numberOne == 3 &&
                  widget.userAnswerTest.userChoice == 3)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberOne == 3 &&
                  widget.userAnswerTest.userChoice != 3)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberOne != 3 &&
                  widget.userAnswerTest.userChoice == 3)
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else
                Container(
                  width: 30,
                ),
              Radio(
                  visualDensity: VisualDensity.compact,
                  value: 3,
                  groupValue: _radioGroupValue,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionThree,
                      textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if (widget.question.numberOne == 4 &&
                  widget.userAnswerTest.userChoice == null)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.yellow,
                )
              else if (widget.userAnswerTest.userChoice == null)
                Container(
                  width: 30,
                )
              else if (widget.question.numberOne == 4 &&
                  widget.userAnswerTest.userChoice == 4)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              else if (widget.question.numberOne == 4 &&
                  widget.userAnswerTest.userChoice != 4)
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.red,
                )
              else if (widget.question.numberOne != 4 &&
                  widget.userAnswerTest.userChoice == 4)
                Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.red,
                )
              else
                Container(
                  width: 30,
                ),
              Radio(
                  visualDensity: VisualDensity.compact,
                  value: 4,
                  groupValue: _radioGroupValue,
                  onChanged: null),
              Expanded(
                  child: Text(widget.question.optionFour,
                      textDirection: TextDirection.rtl))
            ],
          ),
        ],
      ),
    );
  }
}

class LongAnswerWidgetInReivuew extends StatefulWidget {
  Question question;
  LongAnswerWidgetInReivuew({Key key, this.question}) : super(key: key);
  @override
  _LongAnswerWidgetInReivuewState createState() => _LongAnswerWidgetInReivuewState();
}

class _LongAnswerWidgetInReivuewState extends State<LongAnswerWidgetInReivuew> {
  bool userAnswer = false;
  final PageController pageController = PageController(
    initialPage: 1,
  );
  Widget questionAnswerView() {
    return Text(
      widget.question.answerString,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }
  Widget userAnswerView() {
    UserAnswerLong userAnswerLong = widget.question.userAnswer;
    if(userAnswerLong.answerFile != null && userAnswerLong.answerFile.isNotEmpty)
      return Padding(
        padding: EdgeInsets.all(4.0),//EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userAnswerLong.answerText,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
            Container(
              child: FlatButton(
                onPressed: () {},
                child: Text("دانلود فایل", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xFF3D5A80),
              ),
              width: 150,
            )
          ],
        ),
      );
    else
      return Text(
        userAnswerLong.answerText,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        textAlign: TextAlign.right,
      );
  }
  Widget buttonBar() {
    return ButtonBar(
      children: [
        Container(
          child: FlatButton(
            onPressed: () {
              setState(() {
                userAnswer = true;
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              });
            },
            child: Text(
              "پاسخ شما",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: userAnswer ? Colors.white : Colors.black),
            ),
          ),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            color: userAnswer ? Colors.black : Colors.black26,
          ),
        ),
        Container(
          child: FlatButton(
              onPressed: () {
                setState(() {
                  userAnswer = false;
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                });
              },
              child: Text(
                "پاسخ سوال",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: userAnswer ? Colors.black : Colors.white),
              )),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: userAnswer ? Colors.black26 : Colors.black,
          ),
        ),
      ],
      buttonPadding: EdgeInsets.all(0),
      alignment: MainAxisAlignment.center,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
       // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            child: //userAnswerView(),
            Container(
              height: 250,
              child: PageView(
                //physics:NeverScrollableScrollPhysics(),
                physics: ScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    userAnswer = (index == 0);
                  });
                },
                controller: pageController,
                children: [
                  userAnswerView(),
                  questionAnswerView(),
                ],
              ),
            ),
          ),
          buttonBar()
        ],
      ),
    );
  }
}
