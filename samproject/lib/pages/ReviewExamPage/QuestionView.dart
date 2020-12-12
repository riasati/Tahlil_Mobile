import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samproject/domain/UserAnswer.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/MultipleChoiceQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/ShortAnswerQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/TestQuestion.dart';
import 'package:samproject/widgets/questionWidgets.dart';

class QuestionViewInReviewExam extends StatefulWidget {
  Question question;
  UserAnswer userAnswer;
  QuestionViewInReviewExam({Key key,this.question,this.userAnswer}) : super(key: key);
  @override
  _QuestionViewInReviewExamState createState() => _QuestionViewInReviewExamState();
}

class _QuestionViewInReviewExamState extends State<QuestionViewInReviewExam> {
  @override
  void initState() {
    super.initState();
    widget.question.userAnswer = widget.userAnswer;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text("بارم",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                  Text(widget.question.grade.toString(),textDirection: TextDirection.rtl,textAlign: TextAlign.center),
                ],
              ),
            ),
            Expanded(flex: 10,child: NotEditingQuestionSpecification(question: widget.question,)),
          ],
        ),
        NotEditingQuestionText(question: widget.question,),
        // if (widget.question.kind == "چند گزینه ای"/*HomePage.maps.SKindMap["MULTICHOISE"]*/) MultipleChoiceQuestion(widget.question)
        // else if (widget.question.kind == "تست"/*HomePage.maps.SKindMap["TEST"]*/) TestQuestion(widget.question)
        // else if (widget.question.kind == "پاسخ کوتاه"/*HomePage.maps.SKindMap["SHORTANSWER"]*/) ShortAnswerQuestion(widget.question)
        //   else if (widget.question.kind == "تشریحی"/*HomePage.maps.SKindMap["LONGANSWER"]*/) ShortAnswerQuestion(widget.question),

        if (widget.question.kind == "چند گزینه ای"/*HomePage.maps.SKindMap["MULTICHOISE"]*/) MultiChoiceWidgetInReview(question: widget.question,userAnswerMultipleChoice: widget.userAnswer,)
        else if (widget.question.kind == "تست"/*HomePage.maps.SKindMap["TEST"]*/) TestWidgetInReview(question: widget.question,userAnswerTest: widget.userAnswer,)
        else if (widget.question.kind == "پاسخ کوتاه"/*HomePage.maps.SKindMap["SHORTANSWER"]*/) ShortAnswerQuestion(widget.question)
          else if (widget.question.kind == "تشریحی"/*HomePage.maps.SKindMap["LONGANSWER"]*/) ShortAnswerQuestion(widget.question),

        //RaisedButton(onPressed: filePicker,child: Text("انتخاب فایل"),)
        //IconButton(icon: Icon(Icons.camera),onPressed: getAnswerImage,tooltip: "می توان فقط عکس هم فرستاد",),
        // (_AnswerFile != null) ? Text(basename(_AnswerFile.path),textDirection: TextDirection.rtl,) : Container(),
        // (widget.question.kind == "تشریحی") ? RaisedButton(onPressed: chooseFile,child: Text("انتخاب فایل"),) : Container(),
        // RaisedButton(onPressed: sendFile,child: Text("ثبت پاسخ")),
      ],
    );
  }
}
class MultiChoiceWidgetInReview extends StatefulWidget {
  Question question;
  UserAnswerMultipleChoice userAnswerMultipleChoice;
  MultiChoiceWidgetInReview({Key key,this.question,this.userAnswerMultipleChoice}) : super(key: key);
  @override
  _MultiChoiceWidgetInReviewState createState() => _MultiChoiceWidgetInReviewState();
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
              if(widget.question.numberOne == 1 && widget.userAnswerMultipleChoice.userChoices.contains(1)) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberOne == 0 && widget.userAnswerMultipleChoice.userChoices.contains(1)) Icon(Icons.clear,size: 30,color: Colors.red,)
              else if (widget.question.numberOne == 1 && !widget.userAnswerMultipleChoice.userChoices.contains(1)) Icon(Icons.check,size: 30,color: Colors.yellow,)
              else Container(width: 30,),
              Checkbox(value: (widget.userAnswerMultipleChoice.userChoices.contains(1)) ? true: false, onChanged:null),
              Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if(widget.question.numberTwo == 1 && widget.userAnswerMultipleChoice.userChoices.contains(2)) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberTwo == 0 && widget.userAnswerMultipleChoice.userChoices.contains(2)) Icon(Icons.clear,size: 30,color: Colors.red,)
              else if (widget.question.numberTwo == 1 && !widget.userAnswerMultipleChoice.userChoices.contains(2)) Icon(Icons.check,size: 30,color: Colors.yellow,)
                else Container(width: 30,),
              Checkbox(value: (widget.userAnswerMultipleChoice.userChoices.contains(2)) ? true: false, onChanged:null),
              Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if(widget.question.numberThree == 1 && widget.userAnswerMultipleChoice.userChoices.contains(3)) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberThree == 0 && widget.userAnswerMultipleChoice.userChoices.contains(3)) Icon(Icons.clear,size: 30,color: Colors.red,)
              else if (widget.question.numberThree == 1 && !widget.userAnswerMultipleChoice.userChoices.contains(3)) Icon(Icons.check,size: 30,color: Colors.yellow,)
                else Container(width: 30,),
              Checkbox(value: (widget.userAnswerMultipleChoice.userChoices.contains(3)) ? true: false, onChanged:null),
              Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if(widget.question.numberFour == 1 && widget.userAnswerMultipleChoice.userChoices.contains(4)) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberFour == 0 && widget.userAnswerMultipleChoice.userChoices.contains(4)) Icon(Icons.clear,size: 30,color: Colors.red,)
              else if (widget.question.numberFour == 1 && !widget.userAnswerMultipleChoice.userChoices.contains(4)) Icon(Icons.check,size: 30,color: Colors.yellow,)
                else Container(width: 30,),
              Checkbox(value: (widget.userAnswerMultipleChoice.userChoices.contains(3)) ? true: false, onChanged:null),
              Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl))
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
  TestWidgetInReview({Key key,this.question,this.userAnswerTest}) : super(key: key);
  @override
  _TestWidgetInReviewState createState() => _TestWidgetInReviewState();
}

class _TestWidgetInReviewState extends State<TestWidgetInReview> {
  int _radioGroupValue;
  @override
  void initState() {
    super.initState();
    if (widget.userAnswerTest.userChoice != null)
    {
      _radioGroupValue = widget.userAnswerTest.userChoice;
    }
    else
      {
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
              if(widget.question.numberOne == 1 && widget.userAnswerTest.userChoice == null) Icon(Icons.check,size: 30,color: Colors.yellow,)
              else if(widget.userAnswerTest.userChoice == null) Container(width: 30,)
              else if (widget.question.numberOne == 1 &&  widget.userAnswerTest.userChoice == 1) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberOne == 1 &&  widget.userAnswerTest.userChoice != 1) Icon(Icons.check,size: 30,color: Colors.red,)
              else if (widget.question.numberOne != 1 &&  widget.userAnswerTest.userChoice == 1) Icon(Icons.clear,size: 30,color: Colors.red,)
              else Container(width: 30,),
              Radio(visualDensity: VisualDensity.compact,value: 1, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if(widget.question.numberOne == 2 && widget.userAnswerTest.userChoice == null) Icon(Icons.check,size: 30,color: Colors.yellow,)
              else if(widget.userAnswerTest.userChoice == null) Container(width: 30,)
              else if (widget.question.numberOne == 2 && widget.userAnswerTest.userChoice == 2) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberOne == 2 && widget.userAnswerTest.userChoice != 2) Icon(Icons.check,size: 30,color: Colors.red,)
              else if (widget.question.numberOne != 2 && widget.userAnswerTest.userChoice == 2) Icon(Icons.clear,size: 30,color: Colors.red,)
              else Container(width: 30,),
              Radio(visualDensity: VisualDensity.compact,value: 2, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if(widget.question.numberOne == 3 && widget.userAnswerTest.userChoice == null) Icon(Icons.check,size: 30,color: Colors.yellow,)
              else if(widget.userAnswerTest.userChoice == null) Container(width: 30,)
              else if (widget.question.numberOne == 3 && widget.userAnswerTest.userChoice == 3) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberOne == 3 && widget.userAnswerTest.userChoice != 3) Icon(Icons.check,size: 30,color: Colors.red,)
              else if (widget.question.numberOne != 3 && widget.userAnswerTest.userChoice == 3) Icon(Icons.clear,size: 30,color: Colors.red,)
              else Container(width: 30,),
              Radio(visualDensity: VisualDensity.compact,value: 3, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              if(widget.question.numberOne == 4 && widget.userAnswerTest.userChoice == null) Icon(Icons.check,size: 30,color: Colors.yellow,)
              else if(widget.userAnswerTest.userChoice == null) Container(width: 30,)
              else if (widget.question.numberOne == 4 && widget.userAnswerTest.userChoice == 4) Icon(Icons.check,size: 30,color: Colors.green,)
              else if (widget.question.numberOne == 4 && widget.userAnswerTest.userChoice != 4) Icon(Icons.check,size: 30,color: Colors.red,)
              else if (widget.question.numberOne != 4 && widget.userAnswerTest.userChoice == 4) Icon(Icons.clear,size: 30,color: Colors.red,)
              else Container(width: 30,),
              Radio(visualDensity: VisualDensity.compact,value: 4, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl))
            ],
          ),
        ],
      ),
    );
  }
}

