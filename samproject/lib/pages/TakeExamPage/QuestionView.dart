import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samproject/domain/controllers.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/widgets/questionWidgets.dart';
//import 'package:file_picker/file_picker.dart';
class QuestionViewInTakeExam extends StatefulWidget {
  Question question;
  QuestionViewInTakeExam({Key key, this.question,}) : super(key: key);
  @override
  _QuestionViewInTakeExamState createState() => _QuestionViewInTakeExamState();
}

class _QuestionViewInTakeExamState extends State<QuestionViewInTakeExam> {
  Controllers controllers = new Controllers();
  Question UserAnswerQuestion;
  @override
  void initState() {
    super.initState();
    UserAnswerQuestion = widget.question.CopyQuestion();
    UserAnswerQuestion.answerImage = null;
    UserAnswerQuestion.answerString = null;
    UserAnswerQuestion.isPublic = null;
    UserAnswerQuestion.numberOne = 0;
    UserAnswerQuestion.numberTwo = 0;
    UserAnswerQuestion.numberThree = 0;
    UserAnswerQuestion.numberFour = 0;
  }
  // void filePicker()async
  // {
  //   FilePickerResult result = await FilePicker.platform.pickFiles();
  //
  //   if(result != null) {
  //     File file = File(result.files.single.path);
  //   } else {
  //     // User canceled the picker
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Text("بارم"),
                Text(widget.question.grade.toString()),
                //Expanded(child: Container()),
              ],
            )
        ),
        Expanded(
          flex: 10,
          child: Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NotEditingQuestionSpecification(question: widget.question,),
              NotEditingQuestionText(question: widget.question,),
              if (widget.question.kind == "چند گزینه ای"/*HomePage.maps.SKindMap["MULTICHOISE"]*/) NotEditingMultiChoiceOption(question: UserAnswerQuestion,isNull: false,)
              else if (widget.question.kind == "تست"/*HomePage.maps.SKindMap["TEST"]*/) NotEditingTest(question: UserAnswerQuestion,isNull: false,)
              else if (widget.question.kind == "پاسخ کوتاه"/*HomePage.maps.SKindMap["SHORTANSWER"]*/) EditingShortAnswer(question: UserAnswerQuestion,controllers: controllers,)
                else if (widget.question.kind == "تشریحی"/*HomePage.maps.SKindMap["LONGANSWER"]*/) EditingLongAnswer(question: UserAnswerQuestion,controllers: controllers,),
              //RaisedButton(onPressed: filePicker,child: Text("انتخاب فایل"),)
            ],
          ),
        ),
      ],
    );
  }
}
