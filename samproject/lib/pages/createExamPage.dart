import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/domain/controllers.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:samproject/widgets/questionWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
class QuestionViewInCreateExam extends StatefulWidget {
  Question question;
  CreateExamPageState parent;
  int index;
  QuestionViewInCreateExam({Key key,this.question,this.parent,this.index}) : super(key: key);
  @override
  QuestionViewInCreateExamState createState() => QuestionViewInCreateExamState();
}

class QuestionViewInCreateExamState extends State<QuestionViewInCreateExam> {
  Controllers controllers = new Controllers();
  bool IsDelete = false;
  bool IsEdit = false;
  popupMenuData payeData;
  popupMenuData bookData;
  popupMenuData chapterData;
  popupMenuData kindData;
  popupMenuData difficultyData;


  Widget Editing(Question question,VoidCallback onCloseButton,Controllers controllers)//VoidCallback onEditButton,VoidCallback onCloseButton
  {
    Question changedQuestion = widget.question.CopyQuestion();
    void onEditButton() async
    {
      // final prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token");
      // if (token == null) {return;}
      // String tokenplus = "Bearer" + " " + token;
      // widget.question.grade = double.tryParse(controllers.GradeController.text);
      // widget.question.text = controllers.QuestionTextController.text;
      // widget.question.paye = payeData.name;
      // widget.question.book = bookData.name;
      // widget.question.chapter = chapterData.name;
      // widget.question.kind = kindData.name;
      // widget.question.difficulty = difficultyData.name;
      changedQuestion.grade = double.tryParse(controllers.GradeController.text);
      changedQuestion.text = controllers.QuestionTextController.text;
      changedQuestion.paye = payeData.name;
      changedQuestion.book = bookData.name;
      changedQuestion.chapter = chapterData.name;
      changedQuestion.kind = kindData.name;
      changedQuestion.difficulty = difficultyData.name;
      changedQuestion.id = widget.question.id;


      if (changedQuestion.kind == HomePage.maps.SKindMap["MULTICHOISE"])
      {
        changedQuestion.optionOne = controllers.MultiOptionText1Controller.text;
        changedQuestion.optionTwo = controllers.MultiOptionText2Controller.text;
        changedQuestion.optionThree = controllers.MultiOptionText3Controller.text;
        changedQuestion.optionFour = controllers.MultiOptionText4Controller.text;
      }
      else if (changedQuestion.kind == HomePage.maps.SKindMap["TEST"])
      {
        changedQuestion.optionOne = controllers.TestText1Controller.text;
        changedQuestion.optionTwo = controllers.TestText2Controller.text;
        changedQuestion.optionThree = controllers.TestText3Controller.text;
        changedQuestion.optionFour = controllers.TestText4Controller.text;
      }
      else if (changedQuestion.kind == HomePage.maps.SKindMap["LONGANSWER"])
      {
        changedQuestion.answerString = controllers.TashrihiTextController.text;
      }
      else if (changedQuestion.kind == HomePage.maps.SKindMap["SHORTANSWER"])
      {
        changedQuestion.answerString = controllers.BlankTextController.text;
      }

      // String ServerPaye = HomePage.maps.RSPayeMap[changedQuestion.paye];
      // String ServerBook = HomePage.maps.RSBookMap[changedQuestion.book];
      // String ServerChapter = HomePage.maps.RSChapterMap[changedQuestion.chapter];
      // String ServerKind = HomePage.maps.RSKindMap[changedQuestion.kind];
      // String ServerDifficulty = HomePage.maps.RSDifficultyMap[changedQuestion.difficulty];

      //dynamic data;

      //if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"])
      // if (changedQuestion.kind == HomePage.maps.SKindMap["MULTICHOISE"])
      // {
      //   // widget.question.optionOne = controllers.MultiOptionText1Controller.text;
      //   // widget.question.optionTwo = controllers.MultiOptionText2Controller.text;
      //   // widget.question.optionThree = controllers.MultiOptionText3Controller.text;
      //   // widget.question.optionFour = controllers.MultiOptionText4Controller.text;
      //   changedQuestion.optionOne = controllers.MultiOptionText1Controller.text;
      //   changedQuestion.optionTwo = controllers.MultiOptionText2Controller.text;
      //   changedQuestion.optionThree = controllers.MultiOptionText3Controller.text;
      //   changedQuestion.optionFour = controllers.MultiOptionText4Controller.text;
      //   QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
      //   data = jsonEncode(<String,dynamic>{
      //     "questionId":qs.id,
      //     "type": ServerKind,
      //     "public": qs.public,
      //     if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
      //     "question": qs.question,
      //     "answers": qs.answer,
      //     "base": ServerPaye,
      //     "hardness" : ServerDifficulty,
      //     "course": ServerBook,
      //     "options" : qs.options,
      //     "chapter" : ServerChapter,
      //   });
      // }
      //else if (widget.question.kind == HomePage.maps.SKindMap["TEST"])
      // else if (changedQuestion.kind == HomePage.maps.SKindMap["TEST"])
      // {
      //   // widget.question.optionOne = controllers.TestText1Controller.text;
      //   // widget.question.optionTwo = controllers.TestText2Controller.text;
      //   // widget.question.optionThree = controllers.TestText3Controller.text;
      //   // widget.question.optionFour = controllers.TestText4Controller.text;
      //   changedQuestion.optionOne = controllers.TestText1Controller.text;
      //   changedQuestion.optionTwo = controllers.TestText2Controller.text;
      //   changedQuestion.optionThree = controllers.TestText3Controller.text;
      //   changedQuestion.optionFour = controllers.TestText4Controller.text;
      //
      //   QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
      //   data = jsonEncode(<String,dynamic>{
      //     "questionId":qs.id,
      //     "type": ServerKind,
      //     "public": qs.public,
      //     if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
      //     "question": qs.question,
      //     "answers": qs.answer,
      //     "base": ServerPaye,
      //     "hardness" : ServerDifficulty,
      //     "course": ServerBook,
      //     "options" : qs.options,
      //     "chapter" : ServerChapter,
      //   });
      // }
     //  else if (changedQuestion.kind == HomePage.maps.SKindMap["LONGANSWER"]){
     // // else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]){
     //    //widget.question.answerString = controllers.TashrihiTextController.text;
     //    changedQuestion.answerString = controllers.TashrihiTextController.text;
     //    QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
     //    data = jsonEncode(<String,dynamic>{
     //      "questionId":qs.id,
     //      "type": ServerKind,
     //      "public": qs.public,
     //      if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
     //      if(changedQuestion.answerImage != null) "imageAnswer" : changedQuestion.answerImage,
     //      "question": qs.question,
     //      "answers": qs.answer,
     //      "base": ServerPaye,
     //      "hardness" : ServerDifficulty,
     //      "course": ServerBook,
     //      "chapter" : ServerChapter,
     //    });
     //  }
     //  else if (changedQuestion.kind == HomePage.maps.SKindMap["SHORTANSWER"]){
     //    changedQuestion.answerString = controllers.BlankTextController.text;
     //    QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
     //    data = jsonEncode(<String,dynamic>{
     //      "questionId":qs.id,
     //      "type": ServerKind,
     //      "public": qs.public,
     //      if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
     //      "question": qs.question,
     //      "answers": qs.answer,
     //      "base": ServerPaye,
     //      "hardness" : ServerDifficulty,
     //      "course": ServerBook,
     //      "chapter" : ServerChapter,
     //    });
     // // else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"])
     //  //{
     //  //  widget.question.answerString = controllers.BlankTextController.text;
     //  }
      // final response = await http.put('https://parham-backend.herokuapp.com/question',
      //     headers: {
      //       'accept': 'application/json',
      //       'Authorization': tokenplus,
      //       'Content-Type': 'application/json',
      //     },
      //     body: data
      // );
      // if (response.statusCode == 200){
      //  // ShowCorrectnessDialog(true,context);
      //   print("Question changed ");
      //   final responseJson = jsonDecode(response.body);
      //   print(responseJson.toString());

        // CreateExamPage.totalGrade += changedQuestion.grade;
      // for (int i = 0 ; i<CreateExamPage.questionList.length;i++)
      // {
      //   print(CreateExamPage.questionList[i]);
      // }
        CreateExamPage.questionList.insert(CreateExamPage.questionList.indexOf(widget.question), changedQuestion.CopyQuestion());
        CreateExamPage.questionList.removeAt(CreateExamPage.questionList.indexOf(widget.question));
      //   print("fasele");
      // for (int i = 0 ; i<CreateExamPage.questionList.length;i++)
      // {
      //   print(CreateExamPage.questionList[i]);
      // }
        widget.question = changedQuestion.CopyQuestion();
      //}
      // else{
      //   ShowCorrectnessDialog(false,context);
      //   print("Question failed");
      //   final responseJson = jsonDecode(response.body);
      //   print(responseJson.toString());
      //   widget.question.grade = changedQuestion.grade;
      // }
      CreateExamPageState.calculateTotalGrade(widget.parent);
      setState(() {
        IsEdit = false;
      });
      // widget.parent.setState(() {
      //   CreateExamPageState.calculateTotalGrade();
      // });
    }
    void onCancelClick()
    {
      // if (widget.question.grade != null)
      // {
      //   CreateExamPage.totalGrade += widget.question.grade;
      // }
      setState(() {
        IsEdit = false;
      });
      // widget.parent.setState(() {
      //
      // });
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            Row(
              children: [
             //   Flexible(flex: 1,child: IconButton(icon: Icon(Icons.clear),onPressed: onCloseButton,)),
                Flexible(flex: 8,child: EditingOneLineQuestionSpecification(question: changedQuestion,payeData: payeData,bookData: bookData,kindData: kindData,chapterData: chapterData,difficultyData: difficultyData,parent2: this,)),
              ],
            ),
            EditingQuestionText(controllers: controllers,question: changedQuestion,),
            if (kindData.name == HomePage.maps.SKindMap["MULTICHOISE"]) EditingMultiChoiceOption(controllers: controllers,question: changedQuestion,)
            else if (kindData.name == HomePage.maps.SKindMap["TEST"]) EditingTest(question: changedQuestion,controllers: controllers,)
            else if (kindData.name == HomePage.maps.SKindMap["SHORTANSWER"]) EditingShortAnswer(question: changedQuestion,controllers: controllers,)
            else if (kindData.name == HomePage.maps.SKindMap["LONGANSWER"]) EditingLongAnswer(question: changedQuestion,controllers: controllers,),
            EditingGrade(controllers: controllers,),
            EditAndAddtoExamButton(onEditPressed: onEditButton,onCancelPressed: onCancelClick,IsAddtoExamEnable: false,IsEditing: true,),
          ],
        ),
      ),
    );
  }
  Widget NotEditing(Question question,VoidCallback onCloseButton,)
  {
    void onEditButton()
    {
      controllers.FillQuestionTextController(widget.question.text);
      controllers.FillMultiOptionText1Controller(widget.question.optionOne);
      controllers.FillMultiOptionText2Controller(widget.question.optionTwo);
      controllers.FillMultiOptionText3Controller(widget.question.optionThree);
      controllers.FillMultiOptionText4Controller(widget.question.optionFour);
      controllers.FillTestText1Controller(widget.question.optionOne);
      controllers.FillTestText2Controller(widget.question.optionTwo);
      controllers.FillTestText3Controller(widget.question.optionThree);
      controllers.FillTestText4Controller(widget.question.optionFour);
      controllers.FillTashrihiTextController(widget.question.answerString);
      controllers.FillBlankTextController(widget.question.answerString);
      controllers.FillGradeController(widget.question.grade.toString());
      // if (widget.question.grade != null)
      // {
      //   CreateExamPage.totalGrade -= widget.question.grade;
      //   print(CreateExamPage.totalGrade);
      // }
      if (widget.question.grade == null)
      {
        controllers.FillGradeController("0.0");
      }
      kindData.name = widget.question.kind;
      //print(widget.question.text);
      setState(() {
        IsEdit = true;
      });
    }
    return Card(
      child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: [
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Flexible(flex: 1,child: IconButton(icon: Icon(Icons.clear),onPressed: onCloseButton,)),
                      Flexible(flex: 7,child: NotEditingQuestionSpecification(question: question,)),
                      (widget.index != 0)? Flexible(flex: 1,child: IconButton(icon: Icon(Icons.arrow_upward),onPressed: onUpwardArrowClick,tooltip: "جا به جایی با سوال بالا",)):Container(),
                    ],
                  ),
                  //    NotEditingQuestionSpecification(question: question,),
                  NotEditingQuestionText(question: question,),
                  if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"]) NotEditingMultiChoiceOption(question: question,isNull: true,)
                  else if (widget.question.kind == HomePage.maps.SKindMap["TEST"]) NotEditingTest(question: question)
                  else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"]) NotEditingAnswerString(question: question)
                  else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]) NotEditingAnswerString(question: question),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    //(widget.index != CreateExamPage.questionList.length-1)? Flexible(flex: 1,child: IconButton(icon: Icon(Icons.arrow_downward),onPressed: onDownwardArrowClick,)):Container(width: 0,height: 0,),
                    Flexible(flex: 9,child:(question.grade == null) ? Text("بارم : 0.0",textDirection: TextDirection.rtl):Text("بارم : "+ question.grade.toString(),textDirection: TextDirection.rtl)),
                  ],
                ),
              ),
              (widget.index != CreateExamPage.questionList.length-1) ?
              Row(
                textDirection: TextDirection.rtl,
             //     mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(flex: 1,child: IconButton(icon: Icon(Icons.arrow_downward),onPressed: onDownwardArrowClick,tooltip: "جه به جایی با سوال پایین",)),
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xFF3D5A80),
                      child: Container(
                        width: 70,
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ويرايش',style: TextStyle(color: Colors.white),),
                            Icon(Icons.edit,color: Colors.white,),
                          ],
                        ),
                      ),
                  onPressed: onEditButton),
                    )
                ],
              ):
              RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xFF3D5A80),
                  child: Container(
                    width: 70,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ويرايش',style: TextStyle(color: Colors.white),),
                        Icon(Icons.edit,color: Colors.white,),
                      ],
                    ),
                  ),
                  onPressed: onEditButton),
            ],
          )
      ),
    );
  }
  void onUpwardArrowClick()
  {
    Question previousQuestion = CreateExamPage.questionList[widget.index-1].CopyQuestion();
    CreateExamPage.questionList[widget.index-1] = widget.question.CopyQuestion();
    CreateExamPage.questionList[widget.index] = previousQuestion.CopyQuestion();
    widget.parent.setState(() {
     // widget.question = previousQuestion.CopyQuestion();
    });
  }
  void onDownwardArrowClick()
  {
    Question nextQuestion = CreateExamPage.questionList[widget.index+1].CopyQuestion();
    CreateExamPage.questionList[widget.index+1] = widget.question.CopyQuestion();
    CreateExamPage.questionList[widget.index] = nextQuestion.CopyQuestion();
    widget.parent.setState(() {
      //widget.question = nextQuestion.CopyQuestion();
    });
  }
  void onCloseButton() async
  {
    CreateExamPage.questionList.remove(widget.question);
    // if (widget.question.grade != null)
    // {
    //   CreateExamPage.totalGrade -= widget.question.grade;
    // }
    widget.parent.setState(() {
      CreateExamPageState.calculateTotalGrade(widget.parent);
    });
  }

  @override
  void initState() {
    super.initState();
    // controllers.FillQuestionTextController(widget.question.text);
    // controllers.FillMultiOptionText1Controller(widget.question.optionOne);
    // controllers.FillMultiOptionText2Controller(widget.question.optionTwo);
    // controllers.FillMultiOptionText3Controller(widget.question.optionThree);
    // controllers.FillMultiOptionText4Controller(widget.question.optionFour);
    // controllers.FillTestText1Controller(widget.question.optionOne);
    // controllers.FillTestText2Controller(widget.question.optionTwo);
    // controllers.FillTestText3Controller(widget.question.optionThree);
    // controllers.FillTestText4Controller(widget.question.optionFour);
    // controllers.FillTashrihiTextController(widget.question.answerString);
    // controllers.FillBlankTextController(widget.question.answerString);
    // controllers.FillGradeController(widget.question.grade.toString());
    // if (widget.question.grade == null)
    // {
    //   controllers.FillGradeController("0.0");
    // }

    payeData = new popupMenuData("پایه تحصیلی");
    bookData = new popupMenuData("درس");
    chapterData = new popupMenuData("فصل");
    kindData = new popupMenuData("نوع سوال");
    difficultyData = new popupMenuData("دشواری سوال");
    // kindData.name = widget.question.kind;

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          (IsDelete == false) ?
          ((IsEdit == false) ? NotEditing(widget.question,onCloseButton)
              : Editing(widget.question,onCloseButton,controllers))
              : Container(),
        ],
      ),
    );
  }
}

class CreateExamPage extends StatefulWidget {
  static List<Question> questionList = [];
  static double totalGrade = 0;
  String classId;
  CreateExamPage({Key key,this.classId}) : super(key: key);
  @override
  CreateExamPageState createState() => CreateExamPageState();
}

class CreateExamPageState extends State<CreateExamPage> {
  TextEditingController examTopic = new TextEditingController();
  TextEditingController examDate = new TextEditingController();
  TextEditingController examStartTime = new TextEditingController();
  TextEditingController examFinishTime = new TextEditingController();
  TextEditingController examDurationTime = new TextEditingController();

  final RoundedLoadingButtonController _createExamController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _createQuestionController = new RoundedLoadingButtonController();


  bool presedCreatedNewQuestion = false;
  Controllers controller = new Controllers();
  Question newQuestion = new Question();
  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  popupMenuData bookData = new popupMenuData("درس");
  popupMenuData chapterData = new popupMenuData("فصل");
  popupMenuData kindData = new popupMenuData("نوع سوال");
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");

  // int endTime2 = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
  // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  // @override
  // void initState() {
  //   super.initState();
  //   print(endTime);
  //   print(endTime2);
  // }
  void  _showDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return  PersianDateTimePicker(
          type: 'date',
          onSelect: (date) {
            print(date);
            examDate.text = date;
          },
        );
      },
    );
  }
  void  _showTimePicker(bool IsStart) {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        String initialValue = "0:0";
        if (IsStart)
        {
          if (examStartTime.text.split(":").length == 2)
          {
            initialValue = examStartTime.text;
          }
        }
        else
          {
            if (examFinishTime.text.split(":").length == 2)
            {
              initialValue = examFinishTime.text;
            }
          }
        return  PersianDateTimePicker(
          initial: initialValue,
          type: 'time',
          onSelect: (time) {
            print(time);
            if (IsStart)
            {
              examStartTime.text = time;
            }
            else
              {
                examFinishTime.text = time;
              }

          },
        );
      },
    );
  }

  static void calculateTotalGrade(CreateExamPageState state)
  {
    CreateExamPage.totalGrade = 0;
    for (int i=0;i<CreateExamPage.questionList.length;i++)
    {
      if (CreateExamPage.questionList[i].grade != null)
      {
        CreateExamPage.totalGrade += CreateExamPage.questionList[i].grade;
      }
    }
    state.setState(() {

    });
  }
  void ClickAddQuestion()
  {
    setState(() {
      (presedCreatedNewQuestion == false) ? presedCreatedNewQuestion = true : presedCreatedNewQuestion = false;
    });
  }

  void onCreateQuestion() async
  {
    newQuestion.text = controller.QuestionTextController.text;
    newQuestion.paye = payeData.name;
    newQuestion.book = bookData.name;
    newQuestion.chapter = chapterData.name;
    newQuestion.kind = kindData.name;
    newQuestion.difficulty = difficultyData.name;
    newQuestion.grade = double.tryParse(controller.GradeController.text);
    if (newQuestion.text == null || newQuestion.paye == null || newQuestion.book == null || newQuestion.chapter == null || newQuestion.difficulty == null || newQuestion.kind == null)
    {
      ShowCorrectnessDialog(false, context);
      _createQuestionController.stop();
      return ;
    }
    String ServerPaye = HomePage.maps.RSPayeMap[newQuestion.paye];
    String ServerBook = HomePage.maps.RSBookMap[newQuestion.book];
    String ServerChapter = HomePage.maps.RSChapterMap[newQuestion.chapter];
    String ServerKind = HomePage.maps.RSKindMap[newQuestion.kind];
    String ServerDifficulty = HomePage.maps.RSDifficultyMap[newQuestion.difficulty];
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {
      return;
    }
    String tokenplus = "Bearer" + " " + token;
    dynamic data;
    String url = "https://parham-backend.herokuapp.com/question";
    if (newQuestion.kind == HomePage.maps.SKindMap["SHORTANSWER"])
    {
      newQuestion.answerString = controller.BlankTextController.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion,ServerKind);

      data = jsonEncode(<String, dynamic>{
        "type": ServerKind,
        "public": qs.public,
        if(newQuestion.questionImage != null) "imageQuestion" : newQuestion.questionImage,
        "question": qs.question,
        "answers": qs.answer,
        "base": ServerPaye,
        "hardness": ServerDifficulty,
        "course": ServerBook,
        "chapter": ServerChapter,
      });
    }
    else if (newQuestion.kind == HomePage.maps.SKindMap["TEST"])
    {
      newQuestion.optionOne = controller.TestText1Controller.text;
      newQuestion.optionTwo = controller.TestText2Controller.text;
      newQuestion.optionThree = controller.TestText3Controller.text;
      newQuestion.optionFour = controller.TestText4Controller.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion,ServerKind);
      data = jsonEncode(<String, dynamic>{
        "type": ServerKind,
        "public": qs.public,
        if(newQuestion.questionImage != null) "imageQuestion" : newQuestion.questionImage,
        "question": qs.question,
        "answers": qs.answer,
        "base": ServerPaye,
        "hardness": ServerDifficulty,
        "course": ServerBook,
        "options": qs.options,
        "chapter": ServerChapter,
      });
    }
    else if (newQuestion.kind == HomePage.maps.SKindMap["MULTICHOISE"])
    {
      newQuestion.optionOne = controller.MultiOptionText1Controller.text;
      newQuestion.optionTwo = controller.MultiOptionText2Controller.text;
      newQuestion.optionThree = controller.MultiOptionText3Controller.text;
      newQuestion.optionFour = controller.MultiOptionText4Controller.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion,ServerKind);
      data = jsonEncode(<String, dynamic>{
        "type": ServerKind,
        "public": qs.public,
        if(newQuestion.questionImage != null) "imageQuestion" : newQuestion.questionImage,
        "question": qs.question,
        "answers": qs.answer,
        "base": ServerPaye,
        "hardness": ServerDifficulty,
        "course": ServerBook,
        "options": qs.options,
        "chapter": ServerChapter,
      });
    }
    else if (newQuestion.kind == HomePage.maps.SKindMap["LONGANSWER"])
    {
      newQuestion.answerString = controller.TashrihiTextController.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion,ServerKind);
      data = jsonEncode(<String, dynamic>{
        "type": ServerKind,
        "public": qs.public,
        if(newQuestion.questionImage != null) "imageQuestion" : newQuestion.questionImage,
        if(newQuestion.answerImage != null) "imageAnswer" : newQuestion.answerImage,
        "question": qs.question,
        "answers": qs.answer,
        "base": ServerPaye,
        "hardness": ServerDifficulty,
        "course": ServerBook,
        "chapter": ServerChapter,
      });
    }
    final response = await http.post(url,
        headers: {
          'accept': 'application/json',
          'Authorization': tokenplus,
          'Content-Type': 'application/json',
        },
        body: data);
    if (response.statusCode == 200) {
      ShowCorrectnessDialog(true, context);
      print("Question Created");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      newQuestion.id = responseJson["questionId"];
      _createQuestionController.stop();
      //_btnController.stop();
    } else {
      ShowCorrectnessDialog(false, context);
      print("Question failed");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      _createQuestionController.stop();
      return;
      //_btnController.stop();
    }
    //
    // print(newQuestion.text);
    // print(newQuestion.paye);
    // print(newQuestion.book);
    // print(newQuestion.chapter);
    // print(newQuestion.difficulty);
    // print(newQuestion.answerString);
    // print(newQuestion.optionOne);
    // print(newQuestion.numberOne);

    Question addQuestion = newQuestion.CopyQuestion();
    CreateExamPage.questionList.add(addQuestion);
    calculateTotalGrade(this);
    // if (newQuestion.grade != null)
    // {
    //   CreateExamPage.totalGrade += newQuestion.grade;
    // }
    newQuestion = new Question();
    controller = new Controllers();
    setState(() {
    //  dragAndDrop();
    });
  }
  void ClickMyQuestion()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyQuestionPage(IsAddtoExamEnable: true,parent:this),
      ),
    );
  }
  void ClickSearchQuestion()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchQuestionPage(IsAddtoExamEnable: true,parent:this),
      ),
    );
   // Navigator.pop(context);
  }

  void CreateExam() async
  {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    if (token == null) {
      return;
    }
    String tokenplus = "Bearer" + " " + token;
    dynamic data;
    String url = "https://parham-backend.herokuapp.com/exam";
    List questionObjects = [];
    for (int i = 0;i<CreateExamPage.questionList.length;i++)
    {
      dynamic questionObject = {};
      String ServerPaye = HomePage.maps.RSPayeMap[CreateExamPage.questionList[i].paye];
      String ServerBook = HomePage.maps.RSBookMap[CreateExamPage.questionList[i].book];
      String ServerChapter = HomePage.maps.RSChapterMap[CreateExamPage.questionList[i].chapter];
      String ServerKind = HomePage.maps.RSKindMap[CreateExamPage.questionList[i].kind];
      String ServerDifficulty = HomePage.maps.RSDifficultyMap[CreateExamPage.questionList[i].difficulty];
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(CreateExamPage.questionList[i],ServerKind);

      if (CreateExamPage.questionList[i].kind == HomePage.maps.SKindMap["TEST"])
      {
        questionObject = {
          "type": ServerKind,
          "public": qs.public,
          if(CreateExamPage.questionList[i].questionImage != null) "imageQuestion" : CreateExamPage.questionList[i].questionImage,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness": ServerDifficulty,
          "course": ServerBook,
          "options": qs.options,
          "chapter": ServerChapter,
        };
      }
      else if (CreateExamPage.questionList[i].kind == HomePage.maps.SKindMap["SHORTANSWER"])
      {
        questionObject = {
          "type": ServerKind,
          if(CreateExamPage.questionList[i].questionImage != null) "imageQuestion" : CreateExamPage.questionList[i].questionImage,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness": ServerDifficulty,
          "course": ServerBook,
          "chapter": ServerChapter,
        };
      }
      else if (CreateExamPage.questionList[i].kind == HomePage.maps.SKindMap["MULTICHOISE"])
      {
        questionObject = {
          "type": ServerKind,
          if(CreateExamPage.questionList[i].questionImage != null) "imageQuestion" : CreateExamPage.questionList[i].questionImage,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness": ServerDifficulty,
          "course": ServerBook,
          "options": qs.options,
          "chapter": ServerChapter,
        };
      }
      else if (CreateExamPage.questionList[i].kind == HomePage.maps.SKindMap["LONGANSWER"])
      {
        questionObject = {
          "type": ServerKind,
          if(CreateExamPage.questionList[i].questionImage != null) "imageQuestion" : CreateExamPage.questionList[i].questionImage,
          if(CreateExamPage.questionList[i].answerImage != null) "imageAnswer" : CreateExamPage.questionList[i].answerImage,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness": ServerDifficulty,
          "course": ServerBook,
          "chapter": ServerChapter,
        };
      }

      //print(CreateExamPage.questionList[i]);
     // String id = CreateExamPage.questionList[i].id;
     // print(CreateExamPage.questionList[i].id);
      double grade = CreateExamPage.questionList[i].grade;
      questionObjects.add({"question" : questionObject , "grade" : grade});
      //print(CreateExamPage.questionList[i].id);
    }
    if (examDate.text.isEmpty || examStartTime.text.isEmpty || examFinishTime.text.isEmpty || examDurationTime.text.isEmpty)
    {
      ShowCorrectnessDialog(false, context);
      _createExamController.stop();
      return;
    }
    Exam newExam = new Exam(null,examTopic.text,null,null,int.tryParse(examDurationTime.text));
    DateTime startExamDatetime = newExam.CreateDateTimeFromJalali(examDate.text, examStartTime.text);
    DateTime endExamDatetime = newExam.CreateDateTimeFromJalali(examDate.text, examFinishTime.text);
    newExam.startDate = startExamDatetime;
    newExam.endDate = endExamDatetime;
    data = jsonEncode(<String, dynamic>{
      "name": newExam.name,//examTopic.text,
      "startDate": newExam.startDate.toIso8601String(),
      "endDate": newExam.endDate.toIso8601String(),
      "examLength": newExam.examLength,
      "questions": questionObjects,//[{"question" : "adsfasd","grade":3}],
      "useInClass": widget.classId,
    });
    print(data);
    final response = await http.post(url,
        headers: {
          'accept': 'application/json',
          'Authorization': tokenplus,
          'Content-Type': 'application/json',
        },
        body: data);
    if (response.statusCode == 200)
    {
      ShowCorrectnessDialog(true, context);
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      _createExamController.stop();
      CreateExamPage.questionList.clear();
      CreateExamPage.totalGrade = 0;
      setState(() {

      });
    }
    else
      {
        ShowCorrectnessDialog(false, context);
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _createExamController.stop();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          padding: EdgeInsets.only(right: 40),
          alignment: Alignment.center,
          child: Text(
            "ایجاد آزمون",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              // DragAndDropLists(
              // children: _contents,
              // onItemReorder: _onItemReorder,
              // onListReorder: _onListReorder,
              // ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              //   child: Text("عنوان آزمون",textDirection: TextDirection.rtl,),
                              // ),
                              Expanded(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    textDirection: TextDirection.rtl,
                                    controller: examTopic,
                                    textAlign: TextAlign.right,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: "عنوان آزمون",
                                      border: OutlineInputBorder(),
                                      // isCollapsed: true,
                                      // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                    ),
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("تاریخ آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examDate,
                        //             textAlign: TextAlign.right,
                        //             keyboardType: TextInputType.datetime,
                        //             decoration: InputDecoration(
                        //               hintText: "1399/9/2",
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("زمان شروع آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examStartTime,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.right,
                        //             decoration: InputDecoration(
                        //               hintText: "17:30",
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("زمان اتمام آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examFinishTime,
                        //             textAlign: TextAlign.right,
                        //             keyboardType: TextInputType.number,
                        //             decoration: InputDecoration(
                        //               hintText: "18:0",
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //             //decoration: InputDecoration(border: OutlineInputBorder()),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("زمان آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examDurationTime,
                        //             textAlign: TextAlign.right,
                        //             keyboardType: TextInputType.number,
                        //             decoration: InputDecoration(
                        //               hintText: "به دقیقه",
                        //               hintStyle: TextStyle(fontSize: 12),
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //             //decoration: InputDecoration(border: OutlineInputBorder()),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("تاریخ آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            textDirection: TextDirection.rtl,
                                            controller: examDate,
                                            textAlign: TextAlign.right,
                                            onTap: _showDatePicker,
                                            //keyboardType: TextInputType.datetime,
                                            decoration: InputDecoration(
                                              labelText: "تاریخ آزمون",
                                              hintText: "1399/9/2",
                                              border: OutlineInputBorder(),
                                              // isCollapsed: true,
                                              // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("زمان آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            textDirection: TextDirection.rtl,
                                            controller: examDurationTime,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "زمان آزمون",
                                              hintText: "به دقیقه",
                                              hintStyle: TextStyle(fontSize: 10),
                                              border: OutlineInputBorder(),
                                              // isCollapsed: true,
                                              // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                            ),
                                            //decoration: InputDecoration(border: OutlineInputBorder()),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("شروع آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          textDirection: TextDirection.rtl,
                                          controller: examStartTime,
                                          onTap: (){_showTimePicker(true);},
                                          //keyboardType: TextInputType.number,
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            labelText: "شروع آزمون",
                                            hintText: "17:30",
                                            border: OutlineInputBorder(),
                                            // isCollapsed: true,
                                            // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              SizedBox(width: 10,),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("اتمام آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          textDirection: TextDirection.rtl,
                                          controller: examFinishTime,
                                          textAlign: TextAlign.right,
                                          onTap: (){_showTimePicker(false);},
                                          //keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: "اتمام آزمون",
                                            hintText: "18:00",
                                            border: OutlineInputBorder(),
                                            // isCollapsed: true,
                                            // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                          ),
                                          //decoration: InputDecoration(border: OutlineInputBorder()),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              //       child: Text("زمان شروع آزمون",textDirection: TextDirection.rtl,),
                              //     ),
                              //     Flexible(
                              //       flex: 1,
                              //         child: TextFormField(
                              //           textDirection: TextDirection.rtl,
                              //           controller: examStartTime,
                              //           keyboardType: TextInputType.number,
                              //           textAlign: TextAlign.right,
                              //           decoration: InputDecoration(
                              //             hintText: "17:30",
                              //             border: OutlineInputBorder(),
                              //             isCollapsed: true,
                              //             contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                              //           ),
                              //         )
                              //     )
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              //       child: Text("زمان اتمام آزمون",textDirection: TextDirection.rtl,),
                              //     ),
                              //     Flexible(
                              //       flex: 1,
                              //         child: TextFormField(
                              //           textDirection: TextDirection.rtl,
                              //           controller: examFinishTime,
                              //           textAlign: TextAlign.right,
                              //           keyboardType: TextInputType.number,
                              //           decoration: InputDecoration(
                              //             hintText: "18:0",
                              //             border: OutlineInputBorder(),
                              //             isCollapsed: true,
                              //             contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                              //           ),
                              //           //decoration: InputDecoration(border: OutlineInputBorder()),
                              //         )
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text( "جمع نمرات : "+CreateExamPage.totalGrade.toStringAsPrecision(3) ,textDirection: TextDirection.rtl,),
                              RoundedLoadingButton(borderRadius: 0,
                                width: 120,
                                height: 40,
                                onPressed: () => CreateExam(),
                                child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('ایجاد آزمون',style: TextStyle(color: Colors.white),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                                          Icon(Icons.add,color: Colors.white,),
                                        ],
                                      ),//Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                                color: Color(0xFF3D5A80),
                                controller:_createExamController,
                              ),
                              // RaisedButton(
                              //     textColor: Colors.white,
                              //     color: Color(0xFF3D5A80),//Color.fromRGBO(238, 108,77 ,1.0),//Color(0xFF3D5A80),
                              //     child: Row(
                              //       textDirection: TextDirection.rtl,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Text('ایجاد آزمون',style: TextStyle(color: Colors.white),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                              //         Icon(Icons.add,color: Colors.white,),
                              //       ],
                              //     ),//Text("ایجاد آزمون",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                              //     onPressed: CreateExam
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:  CreateExamPage.questionList.length,
                      itemBuilder: (BuildContext context, int index)
                      {
                        return QuestionViewInCreateExam(question: CreateExamPage.questionList[index],parent: this,index: index,);
                      }
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(padding: const EdgeInsets.all(4.0),alignment: Alignment.centerRight,child: Text("اضافه کردن سوال بر اساس",textDirection: TextDirection.rtl,)),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              textColor: Colors.white,
                              color: Color(0xFF3D5A80),//Color(0xFF3D5A80),
                              child: Text("ایجاد سوال"),
                              onPressed: ClickAddQuestion
                             ),
                            RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xFF0e918c),//Color(0xFF3D5A80),
                                child: Text("سوالات من"),
                                onPressed: ClickMyQuestion
                            ),
                            RaisedButton(
                                textColor: Colors.white,
                                color: Color.fromRGBO(238, 108,77 ,1.0),//Color.fromRGBO(28, 160, 160,1.0),//Color(0xFF3D5A80),//Rgb (28,160,160)
                                child: Text("بانک سوال"),
                                onPressed: ClickSearchQuestion
                            ),
                          ],
                        ),
                        (presedCreatedNewQuestion)? Column(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            EditingQuestionText(question: newQuestion,controllers: controller,),
                            EditingTwoLineQuestionSpecification(question: newQuestion,payeData: payeData,bookData: bookData,chapterData: chapterData,kindData: kindData,difficultyData: difficultyData,parent: this,),
                            (kindData.name == HomePage.maps.SKindMap["MULTICHOISE"]) ? EditingMultiChoiceOption(question: newQuestion,controllers: controller,) : Container(),
                            (kindData.name == HomePage.maps.SKindMap["SHORTANSWER"]) ? EditingShortAnswer(question: newQuestion,controllers: controller,) : Container(),
                            (kindData.name == HomePage.maps.SKindMap["LONGANSWER"]) ? EditingLongAnswer(question: newQuestion,controllers: controller,) : Container(),
                            (kindData.name == HomePage.maps.SKindMap["TEST"]) ? EditingTest(question: newQuestion,controllers: controller,) : Container(),
                            EditingGrade(controllers: controller,),
                            AddInBankOption(question: newQuestion,),
                            Container(
                              width: 120,
                              child: RoundedLoadingButton(
                                borderRadius: 0,
                                height: 40,
                                onPressed: () => onCreateQuestion(),
                                color: Color(0xFF3D5A80),
                                controller:_createQuestionController,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('ایجاد سوال',style: TextStyle(color: Colors.white),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                                    Icon(Icons.create,color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                            // RaisedButton(
                            //   textColor: Colors.white,
                            //   color: Color(0xFF3D5A80),
                            //   child:Container(
                            //     width: 100,
                            //     child: Row(
                            //       textDirection: TextDirection.rtl,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text('ایجاد سوال', style: TextStyle(color: Colors.white),),
                            //         Icon(Icons.create,color: Colors.white,),
                            //       ],
                            //     ),
                            //   ),
                            //   onPressed: onCreateQuestion,
                            // ),
                          ],
                        ) : Container(),
                      ],
                    ),
                  ),
                ),
                // CountdownTimer(
                //   endTime: endTime,
                //
                // ),
                // RaisedButton(
                //     textColor: Colors.white,
                //     color: Color(0xFF3D5A80),
                //     child: Text("ایجاد آزمون"),
                //     onPressed: CreateExam
                // ),
              ],
            ),
          ),
        )),
    );
  }
}