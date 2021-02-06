import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/UserAnswer.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/ReviewExamPage/ReviewExamPage.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/LongAnswer.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/MultipleChoiceQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/ShortAnswerQuestion.dart';
import 'package:samproject/pages/ReviewExamPage/typeofanswer/TestQuestion.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:samproject/widgets/questionWidgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuestionViewInReviewExam extends StatefulWidget {
  Question question;
  bool isTeacherUsing;
  String examId;
  String userName;
  int questionIndex;
  QuestionViewInReviewExam({Key key, this.question,this.isTeacherUsing = false,this.examId = null,this.userName = null,this.questionIndex})
      : super(key: key);

  @override
  _QuestionViewInReviewExamState createState() =>
      _QuestionViewInReviewExamState();
}

class _QuestionViewInReviewExamState extends State<QuestionViewInReviewExam> {
  TextEditingController TeacherGradeController = new TextEditingController();
  final RoundedLoadingButtonController _submitGradeBtnController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _downloadFileBtnController = new RoundedLoadingButtonController();
  UserAnswerLong userAnswerLong;
  bool IsGradeChange = false;
  void downloaFile() async
  {
    //UserAnswerLong userAnswerLong = widget.question.userAnswer;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: userAnswerLong.answerFile,
      savedDir: appDocDir.path,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    print(userAnswerLong.answerFile);
    await _downloadFileBtnController.stop();
  }
  void submitGradeChange() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {
      return;
    }
    String tokenplus = "Bearer" + " " + token;
    dynamic data;
    String url = "https://parham-backend.herokuapp.com/exam/" + widget.examId + "/attendees/" + widget.userName;
    print(url);
    double totalGrade = 0;
    ReviewExamPage.grades[widget.questionIndex-1] = double.tryParse(TeacherGradeController.text);
    for (int i = 0;i<ReviewExamPage.grades.length;i++)
    {
      totalGrade += ReviewExamPage.grades[i];
    }
    data = jsonEncode(<String, dynamic>{
      "answerGrades": ReviewExamPage.grades,
      "totalGrade": totalGrade,
    });
    print(data);
    final response = await http.put(url,
        headers: {
          'accept': 'application/json',
          'Authorization': tokenplus,
          'Content-Type': 'application/json',
        },
        body: data);
    if (response.statusCode == 200)
    {
      ShowCorrectnessDialog(true, context);
      // final responseJson = jsonDecode(response.body);
      // print(responseJson.toString());
      _submitGradeBtnController.stop();
    }
    else
    {
      ShowCorrectnessDialog(false, context);
      // final responseJson = jsonDecode(response.body);
      // print(responseJson.toString());
      _submitGradeBtnController.stop();
    }
  }
  void onGradeChange(String value)
  {
    if (TeacherGradeController.text != widget.question.userAnswer.grade)
    {
      IsGradeChange = true;
      setState(() {

      });
    }
    else
      {
        IsGradeChange = false;
        setState(() {

        });
      }
  }
  @override
  void initState() {
    super.initState();
    if (widget.question.userAnswer.grade == "null")
    {
      widget.question.userAnswer.grade = 0.toString();
    }
    TeacherGradeController.text = widget.question.userAnswer.grade;//widget.question.userAnswer.grade,
    if (widget.question.kind == "LONGANSWER")
    {
      userAnswerLong = widget.question.userAnswer;
    }

  }
  @override
  Widget build(BuildContext context) {
    var GradeColumn = Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "بارم",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            (widget.isTeacherUsing) ? Container(
              width: 35,
              child: TextFormField(
                textDirection: TextDirection.rtl,
                controller: TeacherGradeController,
                keyboardType: TextInputType.number,
                onChanged: (value) => onGradeChange(value),
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                  border: OutlineInputBorder(),
                ),
              ),
            ) :
                Text(widget.question.userAnswer.grade,textDirection: TextDirection.rtl,textAlign: TextAlign.center, /*widget.question.userAnswer.grade*/),
            Text("/"),
            Text(widget.question.grade.toString(),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center
            ),
          ],
        )
      ],
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Container(
                    child: Card(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: 50,
                        ),
                        margin: EdgeInsets.fromLTRB(4, 15, 4, 4),
                        padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
                        child: Column(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(alignment: Alignment.centerRight,child: Text(widget.question.text,textDirection: TextDirection.rtl,)),
                            (widget.question.questionImage != null) ? Image.memory(base64Decode(widget.question.questionImage),fit: BoxFit.cover,height: 200,) : Container(),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 10,
                      child: Container(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        color: Colors.white,
                        child: Text("سوال",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),),
                      )
                  ),
                  Positioned(
                    top: (widget.isTeacherUsing) ? 10 :15,
                    left: 4,
                    child: Card(
                      child:GradeColumn
                    ),
                  ),
                ],
              ),

              // Row(
              //   children: [
              //     Expanded(
              //       flex: 1,
              //       child: GradeColumn
              //       // Column(
              //       //   children: [
              //       //     Text(
              //       //       "بارم",
              //       //       textDirection: TextDirection.rtl,
              //       //       textAlign: TextAlign.center,
              //       //     ),
              //       //     Text(widget.question.grade.toString(),
              //       //         textDirection: TextDirection.rtl,
              //       //         textAlign: TextAlign.center),
              //       //   ],
              //       // ),
              //     ),
              //     Expanded(
              //       flex: 3,
              //       child: NotEditingQuestionText(
              //         question: widget.question,
              //       ),
              //     ),
              //   ],
              // ),

              if (widget.question.kind ==
                  "MULTICHOISE")
                Card(child: MultiChoiceWidgetInReview(question: widget.question,userAnswerMultipleChoice: widget.question.userAnswer,))
              else if (widget.question.kind ==
                  "TEST")
                Card(child: TestWidgetInReview(question: widget.question,userAnswerTest: widget.question.userAnswer,))
              else if (widget.question.kind ==
                    "SHORTANSWER")
                  ShortAnswerWidgetInReview(question: widget.question,isTeacherUsing: widget.isTeacherUsing,)
                else
                  LongAnswerWidgetInReview(question: widget.question,isTeacherUsing: widget.isTeacherUsing,),

              if (userAnswerLong == null && !IsGradeChange) Container()
              else if (userAnswerLong == null && IsGradeChange)
                RoundedLoadingButton(borderRadius: 0,
                  width: 100,
                  height: 40,
                  onPressed: () => submitGradeChange(),
                  child: Text("اعمال تغییرات",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                  color: Color(0xFF3D5A80),
                  controller:_submitGradeBtnController,
                )
              //   Container(
              //   child: FlatButton(
              //     onPressed: submitGradeChange,
              //     child: Text("اعمال تغییرات", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              //   ),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(30)),
              //     color: Color(0xFF3D5A80),
              //   ),
              //   width: 150,
              // )
              else if (userAnswerLong.answerFile != "" && !IsGradeChange)
                  RoundedLoadingButton(borderRadius: 0,
                    width: 100,
                    height: 40,
                    onPressed: () => downloaFile(),
                    child: Text("دانلود فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                    color: Color(0xFF3D5A80),
                    controller:_downloadFileBtnController,
                  )
              //   Container(
              //   child: FlatButton(
              //     onPressed: downloaFile,
              //     child: Text("دانلود فایل", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              //   ),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(30)),
              //     color: Color(0xFF3D5A80),
              //   ),
              //   width: 150,
              // )
              else if (userAnswerLong.answerFile != "" && IsGradeChange) Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedLoadingButton(borderRadius: 0,
                      width: 100,
                      height: 40,
                      onPressed: () => downloaFile(),
                      child: Text("دانلود فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                      color: Color(0xFF3D5A80),
                      controller:_downloadFileBtnController,
                    ),
                    RoundedLoadingButton(borderRadius: 0,
                      width: 100,
                      height: 40,
                      onPressed: () => submitGradeChange(),
                      child: Text("اعمال تغییرات",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                      color: Color(0xFF0e918c),
                      controller:_submitGradeBtnController,
                    )

                    // Container(
                    //   child: FlatButton(
                    //     onPressed: downloaFile,
                    //     child: Text("دانلود فایل", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    //   ),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(30)),
                    //     color: Color(0xFF3D5A80),
                    //   ),
                    //   width: 150,
                    // ),
                    // Container(
                    //   child: FlatButton(
                    //     onPressed: submitGradeChange,
                    //     child: Text("اعمال تغییرات", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    //   ),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(30)),
                    //     color: Color(0xFF3D5A80),
                    //   ),
                    //   width: 150,
                    // ),
                  ],
                ),
            ],
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
                  color: Colors.green,
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
                  color: Colors.green,
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
                  color: Colors.green,
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
                  color: Colors.green,
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

class LongAnswerWidgetInReview2 extends StatefulWidget {
  Question question;
  LongAnswerWidgetInReview2({Key key, this.question}) : super(key: key);
  @override
  _LongAnswerWidgetInReview2State createState() => _LongAnswerWidgetInReview2State();
}

class _LongAnswerWidgetInReview2State extends State<LongAnswerWidgetInReview2> {
  bool userAnswer = false;
  final PageController pageController = PageController(
    initialPage: 1,
  );
  void initializeDownloader() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );
  }
  @override
  void initState() {
    super.initState();
    initializeDownloader();
  }
  void downloaFile() async
  {
    UserAnswerLong userAnswerLong = widget.question.userAnswer;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: userAnswerLong.answerFile,
      savedDir: appDocDir.path,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }
  Widget questionAnswerView() {
    return Text(
      "پاسخ سوال : "  + widget.question.answerString,
      textDirection: TextDirection.rtl,
      style: TextStyle(
     //   fontSize: 16.0,
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
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    "پاسخ شما : "  + userAnswerLong.answerText,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                   //   fontSize: 16.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: FlatButton(
                  onPressed: downloaFile,
                  child: Text("دانلود فایل", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xFF3D5A80),
                ),
                width: 150,
              ),
            )
          ],
        ),
      );
    else
      return Text(
        "پاسخ شما : "  + userAnswerLong.answerText,
        textDirection: TextDirection.rtl,
        style: TextStyle(
        //  fontSize: 16.0,
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
              height: 300,
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

class LongAnswerWidgetInReview extends StatefulWidget {
  Question question;
  bool isTeacherUsing;
  LongAnswerWidgetInReview({Key key, this.question, this.isTeacherUsing = false}) : super(key: key);
  @override
  _LongAnswerWidgetInReviewState createState() => _LongAnswerWidgetInReviewState();
}

class _LongAnswerWidgetInReviewState extends State<LongAnswerWidgetInReview> {
  UserAnswerLong userAnswerLong;
  @override
  void initState() {
    super.initState();
    userAnswerLong = widget.question.userAnswer;
  }
  void downloaFile() async
  {
    //UserAnswerLong userAnswerLong = widget.question.userAnswer;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: userAnswerLong.answerFile,
      savedDir: appDocDir.path,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }
  @override
  Widget build(BuildContext context) {
  //  UserAnswerLong userAnswerLong = widget.question.userAnswer;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Container(
              child: Card(
                child: Container(
                  margin: EdgeInsets.fromLTRB(4, 15, 4, 4),
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(alignment: Alignment.centerRight,child: Text(widget.question.answerString,textDirection: TextDirection.rtl,textAlign: TextAlign.right,)),
                      (widget.question.answerImage != null) ? Image.memory(base64Decode(widget.question.answerImage),fit: BoxFit.cover,height: 200,) : Container(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
            Positioned(
                right: 20,
                top: 10,
                child: Container(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  color: Colors.white,
                  child: Text("پاسخ سوال",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),),
                )
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              child: Card(
                child: Container(
                  margin: EdgeInsets.fromLTRB(4, 15, 4, 4),
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (userAnswerLong.answerText != null) Container(alignment: Alignment.centerRight,child: Text(userAnswerLong.answerText,textDirection: TextDirection.rtl,))
                      else if (userAnswerLong.answerText == null && userAnswerLong.answerFile == null && widget.isTeacherUsing) Text("دانش آموز به این سوال پاسخی نداده است",textDirection: TextDirection.rtl,)
                      else if (userAnswerLong.answerText == null && userAnswerLong.answerFile != null && widget.isTeacherUsing) Text("دانش آموز فایلی را به عنوان جواب ارسال کرده است",textDirection: TextDirection.rtl,)
                      else if (userAnswerLong.answerText == null && userAnswerLong.answerFile == null && !widget.isTeacherUsing) Text("شما به این سوال پاسخی نداده اید",textDirection: TextDirection.rtl)
                          else if (userAnswerLong.answerText == null && userAnswerLong.answerFile != null && !widget.isTeacherUsing) Text("شما فایلی را به عنوان جواب ارسال کرده اید",textDirection: TextDirection.rtl),
                      Container(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
            Positioned(
                right: 20,
                top: 10,
                child: Container(
                    padding: EdgeInsets.only(left: 4, right: 4),
                    color: Colors.white,
                    child: (widget.isTeacherUsing) ? Text("پاسخ دانش آموز",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),) :
                    Text("پاسخ شما",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),)
                )
            ),
          ],
        ),
        // (userAnswerLong.answerFile != null) ? Container(
        //   child: FlatButton(
        //     onPressed: downloaFile,
        //     child: Text("دانلود فایل", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        //   ),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(30)),
        //     color: Color(0xFF3D5A80),
        //   ),
        //   width: 150,
        // ) : Container(),
      ],
    );
  }
}


class ShortAnswerWidgetInReview extends StatelessWidget {
  Question question;
  bool isTeacherUsing;
  ShortAnswerWidgetInReview({Key key, this.question, this.isTeacherUsing = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserAnswerShort userAnswerShort = question.userAnswer;
  //  userAnswerShort.answerText = null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Container(
              child: Card(
                child: Container(
                  margin: EdgeInsets.fromLTRB(4, 15, 4, 4),
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(alignment: Alignment.centerRight,child: Text(question.answerString,textDirection: TextDirection.rtl,textAlign: TextAlign.right,)),
                      (question.answerImage != null) ? Image.memory(base64Decode(question.answerImage),fit: BoxFit.cover,height: 200,) : Container(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
            Positioned(
                right: 20,
                top: 10,
                child: Container(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  color: Colors.white,
                  child: Text("پاسخ سوال",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),),
                )
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              child: Card(
                child: Container(
                  margin: EdgeInsets.fromLTRB(4, 15, 4, 4),
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (userAnswerShort.answerText != null) Container(alignment: Alignment.centerRight,child: Text(userAnswerShort.answerText,textDirection: TextDirection.rtl,))
                      else if (userAnswerShort.answerText == null && isTeacherUsing) Text("دانش آموز به این سوال پاسخی نداده است",textDirection: TextDirection.rtl,)
                      else if (userAnswerShort.answerText == null && !isTeacherUsing) Text("شما به این سوال پاسخی نداده اید",textDirection: TextDirection.rtl),
                      Container(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
            Positioned(
                right: 20,
                top: 10,
                child: Container(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  color: Colors.white,
                  child: (isTeacherUsing) ? Text("پاسخ دانش آموز",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),) :
                  Text("پاسخ شما",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),)
                )
            ),
          ],
        ),
      ],
    );
  }
}

