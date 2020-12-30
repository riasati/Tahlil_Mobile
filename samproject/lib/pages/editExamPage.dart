import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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
class QuestionViewInEditExam extends StatefulWidget {
  Question question;
  EditExamPageState parent;
  int index;
  QuestionViewInEditExam({Key key,this.question,this.parent,this.index}) : super(key: key);
  @override
  QuestionViewInEditExamState createState() => QuestionViewInEditExamState();
}

class QuestionViewInEditExamState extends State<QuestionViewInEditExam> {
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
    void onEditButton()
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

      // dynamic data;
      //
      // //if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"])
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
      // else if (changedQuestion.kind == HomePage.maps.SKindMap["LONGANSWER"]){
      //   // else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]){
      //   //widget.question.answerString = controllers.TashrihiTextController.text;
      //   changedQuestion.answerString = controllers.TashrihiTextController.text;
      //   QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
      //   data = jsonEncode(<String,dynamic>{
      //     "questionId":qs.id,
      //     "type": ServerKind,
      //     "public": qs.public,
      //     if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
      //     if(changedQuestion.answerImage != null) "imageAnswer" : changedQuestion.answerImage,
      //     "question": qs.question,
      //     "answers": qs.answer,
      //     "base": ServerPaye,
      //     "hardness" : ServerDifficulty,
      //     "course": ServerBook,
      //     "chapter" : ServerChapter,
      //   });
      // }
      // else if (changedQuestion.kind == HomePage.maps.SKindMap["SHORTANSWER"]){
      //   changedQuestion.answerString = controllers.BlankTextController.text;
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
      //     "chapter" : ServerChapter,
      //   });
      //   // else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"])
      //   //{
      //   //  widget.question.answerString = controllers.BlankTextController.text;
      // }
      // final response = await http.put('https://parham-backend.herokuapp.com/question',
      //     headers: {
      //       'accept': 'application/json',
      //       'Authorization': tokenplus,
      //       'Content-Type': 'application/json',
      //     },
      //     body: data
      // );
      // if (response.statusCode == 200){
      //   // ShowCorrectnessDialog(true,context);
      //   print("Question changed ");
      //   final responseJson = jsonDecode(response.body);
      //   print(responseJson.toString());
        EditExamPage.questionList.insert(EditExamPage.questionList.indexOf(widget.question), changedQuestion.CopyQuestion());
        EditExamPage.questionList.removeAt(EditExamPage.questionList.indexOf(widget.question));
        widget.question = changedQuestion.CopyQuestion();

     // }
      // else{
      //   ShowCorrectnessDialog(false,context);
      //   print("Question failed");
      //   final responseJson = jsonDecode(response.body);
      //   print(responseJson.toString());
      //   widget.question.grade = changedQuestion.grade;
      //
      // }
      EditExamPageState.calculateTotalGrade(widget.parent);
      setState(() {
        IsEdit = false;
      });
    }
    void onCancelClick()
    {
      setState(() {
        IsEdit = false;
      });
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
                Flexible(flex: 8,child: EditingOneLineQuestionSpecification(question: changedQuestion,payeData: payeData,bookData: bookData,kindData: kindData,chapterData: chapterData,difficultyData: difficultyData,parent3: this,)),
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
                      (widget.index != 0)? Flexible(flex: 1,child: IconButton(icon: Icon(Icons.arrow_upward),onPressed: onUpwardArrowClick,)):Container(),
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
                    //(widget.index != EditExamPage.questionList.length-1)? Flexible(flex: 1,child: IconButton(icon: Icon(Icons.arrow_downward),onPressed: onDownwardArrowClick,)):Container(width: 0,height: 0,),
                    Flexible(flex: 9,child:(question.grade == null) ? Text("بارم : 0.0",textDirection: TextDirection.rtl):Text("بارم : "+ question.grade.toString(),textDirection: TextDirection.rtl)),
                  ],
                ),
              ),
              //EditAndAddtoExamButton(onEditPressed: onEditButton,IsAddtoExamEnable: false)
              (widget.index != EditExamPage.questionList.length-1) ?
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
    Question previousQuestion = EditExamPage.questionList[widget.index-1].CopyQuestion();
    EditExamPage.questionList[widget.index-1] = widget.question.CopyQuestion();
    EditExamPage.questionList[widget.index] = previousQuestion.CopyQuestion();
    widget.parent.setState(() {
      // widget.question = previousQuestion.CopyQuestion();
    });
  }
  void onDownwardArrowClick()
  {
    Question nextQuestion = EditExamPage.questionList[widget.index+1].CopyQuestion();
    EditExamPage.questionList[widget.index+1] = widget.question.CopyQuestion();
    EditExamPage.questionList[widget.index] = nextQuestion.CopyQuestion();
    widget.parent.setState(() {
      //widget.question = nextQuestion.CopyQuestion();
    });
  }
  void onCloseButton() async
  {
    EditExamPage.questionList.remove(widget.question);
    widget.parent.setState(() {
      EditExamPageState.calculateTotalGrade(widget.parent);
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

class EditExamPage extends StatefulWidget {
  static List<Question> questionList = [];
  String classId;
  String examId;
  static double totalGrade = 0;
  EditExamPage({Key key,this.classId,this.examId}) : super(key: key);
  @override
  EditExamPageState createState() => EditExamPageState();
}

class EditExamPageState extends State<EditExamPage> {
  TextEditingController examTopic = new TextEditingController();
  TextEditingController examDate = new TextEditingController();
  TextEditingController examStartTime = new TextEditingController();
  TextEditingController examFinishTime = new TextEditingController();
  TextEditingController examDurationTime = new TextEditingController();

  final RoundedLoadingButtonController _editExamController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _createQuestionController = new RoundedLoadingButtonController();



  bool presedCreatedNewQuestion = false;
  Controllers controller = new Controllers();
  Question newQuestion = new Question();
  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  popupMenuData bookData = new popupMenuData("درس");
  popupMenuData chapterData = new popupMenuData("فصل");
  popupMenuData kindData = new popupMenuData("نوع سوال");
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");
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

  static void calculateTotalGrade(EditExamPageState state)
  {
    EditExamPage.totalGrade = 0;
    for (int i=0;i<EditExamPage.questionList.length;i++)
    {
      if (EditExamPage.questionList[i].grade != null)
      {
        EditExamPage.totalGrade += EditExamPage.questionList[i].grade;
      }
    }
    state.setState(() {

    });
  }
  void GetExamSpecification() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;

    var headers = {
      'accept': 'application/json',
      'Authorization': tokenplus,
    };
    String url = "https://parham-backend.herokuapp.com/class/" + widget.classId + "/exams/" + widget.examId;
    // print(widget.classId);
    // print(widget.examId);
    // print(url);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200)
    {
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());

      examTopic.text = responseJson["exam"]["name"];
      examDurationTime.text = responseJson["exam"]["examLength"].toString();
      Exam editExam = new Exam(responseJson["exam"]["_id"],responseJson["exam"]["name"],DateTime.parse(responseJson["exam"]["startDate"]),DateTime.parse(responseJson["exam"]["endDate"]),responseJson["exam"]["examLength"]);
      String jalaliDateTimeStart = editExam.GetJalaliOfServerGregorian(editExam.startDate);
      String jalaliDateTimeFinish = editExam.GetJalaliOfServerGregorian(editExam.endDate);
      examDate.text = jalaliDateTimeStart.split(" ")[0];
      examStartTime.text = jalaliDateTimeStart.split(" ")[1];
      examFinishTime.text = jalaliDateTimeFinish.split(" ")[1];
      for (int i=0;i<responseJson["exam"]["questions"].length;i++)
      {
        QuestionServer qs = new QuestionServer();
        qs.type = responseJson["exam"]["questions"][i]["question"]["type"];
        qs.question = responseJson["exam"]["questions"][i]["question"]["question"];
        qs.base = responseJson["exam"]["questions"][i]["question"]["base"];
        qs.course = responseJson["exam"]["questions"][i]["question"]["course"];
        qs.chapter = responseJson["exam"]["questions"][i]["question"]["chapter"];
        qs.hardness = responseJson["exam"]["questions"][i]["question"]["hardness"];
        qs.answer = responseJson["exam"]["questions"][i]["question"]["answers"];
        qs.options = responseJson["exam"]["questions"][i]["question"]["options"];
        qs.public = responseJson["exam"]["questions"][i]["question"]["public"];
        qs.id = responseJson["exam"]["questions"][i]["question"]["_id"];
        qs.imageQuestion = responseJson["exam"]["questions"][i]["question"]["imageQuestion"];
        qs.imageAnswer = responseJson["exam"]["questions"][i]["question"]["imageAnswer"];
        // if (responseJson["exam"]["questions"][i]["grade"] == 0)
        // {
        //   qs.grade = 0;
        // }
        if (responseJson["exam"]["questions"][i]["grade"] != null)
        {
          // print(qs.id);
          // print(responseJson["exam"]["questions"][i]["grade"]);
          qs.grade = double.tryParse(responseJson["exam"]["questions"][i]["grade"].toString());
        }

        Question q = Question.QuestionServerToQuestion(qs,qs.type);
        EditExamPage.questionList.add(q);
      }
      calculateTotalGrade(this);
      setState(() {

      });
    }
    else
    {
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      ShowCorrectnessDialog(false, context);

    }


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
    EditExamPage.questionList.add(addQuestion);
    calculateTotalGrade(this);
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
        builder: (context) => MyQuestionPage(IsAddtoExamEnable: true,parent2: this,),
      ),
    );
  }
  void ClickSearchQuestion()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchQuestionPage(IsAddtoExamEnable: true,parent2:this),
      ),
    );
    // Navigator.pop(context);
  }
  void EditExam() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {
      return;
    }
    String tokenplus = "Bearer" + " " + token;
    dynamic data;
    String url = "https://parham-backend.herokuapp.com/exam";
    List questionObjects = [];
    for (int i = 0;i<EditExamPage.questionList.length;i++)
    {
      dynamic questionObject = {};
      String ServerPaye = HomePage.maps.RSPayeMap[EditExamPage.questionList[i].paye];
      String ServerBook = HomePage.maps.RSBookMap[EditExamPage.questionList[i].book];
      String ServerChapter = HomePage.maps.RSChapterMap[EditExamPage.questionList[i].chapter];
      String ServerKind = HomePage.maps.RSKindMap[EditExamPage.questionList[i].kind];
      String ServerDifficulty = HomePage.maps.RSDifficultyMap[EditExamPage.questionList[i].difficulty];
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(EditExamPage.questionList[i],ServerKind);

      if (EditExamPage.questionList[i].kind == HomePage.maps.SKindMap["TEST"])
      {
        questionObject = {
          "type": ServerKind,
          "public": qs.public,
          if(EditExamPage.questionList[i].questionImage != null) "imageQuestion" : EditExamPage.questionList[i].questionImage,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness": ServerDifficulty,
          "course": ServerBook,
          "options": qs.options,
          "chapter": ServerChapter,
        };
      }
      else if (EditExamPage.questionList[i].kind == HomePage.maps.SKindMap["SHORTANSWER"])
      {
        questionObject = {
          "type": ServerKind,
          if(EditExamPage.questionList[i].questionImage != null) "imageQuestion" : EditExamPage.questionList[i].questionImage,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness": ServerDifficulty,
          "course": ServerBook,
          "chapter": ServerChapter,
        };
      }
      else if (EditExamPage.questionList[i].kind == HomePage.maps.SKindMap["MULTICHOISE"])
      {
        questionObject = {
          "type": ServerKind,
          if(EditExamPage.questionList[i].questionImage != null) "imageQuestion" : EditExamPage.questionList[i].questionImage,
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
      else if (EditExamPage.questionList[i].kind == HomePage.maps.SKindMap["LONGANSWER"])
      {
        questionObject = {
          "type": ServerKind,
          if(EditExamPage.questionList[i].questionImage != null) "imageQuestion" : EditExamPage.questionList[i].questionImage,
          if(EditExamPage.questionList[i].answerImage != null) "imageAnswer" : EditExamPage.questionList[i].answerImage,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness": ServerDifficulty,
          "course": ServerBook,
          "chapter": ServerChapter,
        };
      }

      //String id = EditExamPage.questionList[i].id;
      //print(EditExamPage.questionList[i].id);
      double grade = EditExamPage.questionList[i].grade;
      questionObjects.add({"question" : questionObject , "grade" : grade});
      //print(EditExamPage.questionList[i].id);
    }
    if (examDate.text.isEmpty || examStartTime.text.isEmpty || examFinishTime.text.isEmpty || examDurationTime.text.isEmpty)
    {
      ShowCorrectnessDialog(false, context);
      _editExamController.stop();
      return;
    }
    Exam newExam = new Exam(null,examTopic.text,null,null,int.tryParse(examDurationTime.text));
    DateTime startExamDatetime = newExam.CreateDateTimeFromJalali(examDate.text, examStartTime.text);
    DateTime endExamDatetime = newExam.CreateDateTimeFromJalali(examDate.text, examFinishTime.text);
    newExam.startDate = startExamDatetime;
    newExam.endDate = endExamDatetime;
    data = jsonEncode(<String, dynamic>{
      "examId":widget.examId,
      "name": newExam.name,//examTopic.text,
      "startDate": newExam.startDate.toIso8601String(),
      "endDate": newExam.endDate.toIso8601String(),
      "examLength": newExam.examLength,
      "questions": questionObjects,//[{"question" : "adsfasd","grade":3}],
      "useInClass": widget.classId,
    });

    // List<String> dates = examDate.text.split("/");
    // List<String> startTimes = examStartTime.text.split(":");
    // List<String> finishTimes = examFinishTime.text.split(":");
    // Jalali j = new Jalali(int.tryParse(dates[0]),int.tryParse(dates[1]),int.tryParse(dates[2]));
    // Gregorian g = j.toGregorian();
    // print(g.year.toString() + "-" + g.month.toString() + "-" + g.day.toString() + " " + examStartTime.text);
    // DateTime startExamDatetime;
    // DateTime endExamDatetime;
    // if (startTimes.length == 1)
    // {
    //   startExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(startTimes[0]),);
    // }
    // else
    // {
    //   startExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(startTimes[0]),int.tryParse(startTimes[1]));
    // }
    // if(finishTimes.length == 1)
    // {
    //   endExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(finishTimes[0]));
    // }
    // else
    // {
    //   endExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(finishTimes[0]),int.tryParse(finishTimes[1]));
    // }
    //print(startExamDatetime.toIso8601String());
    //print(endExamDatetime.toIso8601String());
    // data = jsonEncode(<String, dynamic>{
    //   "examId":widget.examId,
    //   "name": examTopic.text,
    //   "startDate": startExamDatetime.toIso8601String(),
    //   "endDate": endExamDatetime.toIso8601String(),
    //   "examLength": int.tryParse(examDurationTime.text),
    //   "questions": questionObjects,//[{"question" : "adsfasd","grade":3}],
    //   "useInClass": widget.classId,//"kuTwxu"//
    // });
    //print(data);
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
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      _editExamController.stop();
      // EditExamPage.questionList.clear();
      // EditExamPage.totalGrade = 0;
    }
    else
    {
      ShowCorrectnessDialog(false, context);
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      _editExamController.stop();
    }
  }
  @override
  void initState() {
    super.initState();
    EditExamPage.questionList = [];
    EditExamPage.totalGrade = 0;
    GetExamSpecification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 40),
          child: Text(
            "ویرایش آزمون",
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text( "جمع نمرات : "+EditExamPage.totalGrade.toStringAsPrecision(3) ,textDirection: TextDirection.rtl,),
                                RoundedLoadingButton(borderRadius: 0,
                                  width: 120,
                                  height: 40,
                                  onPressed: () => EditExam(),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('ویرایش آزمون',style: TextStyle(color: Colors.white),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                                      Icon(Icons.edit,color: Colors.white,),
                                    ],
                                  ),//Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                                  color: Color(0xFF3D5A80),
                                  controller:_editExamController,
                                ),
                                // RaisedButton(
                                //     textColor: Colors.white,
                                //     color: Color(0xFF3D5A80),//Color.fromRGBO(238, 108,77 ,1.0),//Color(0xFF3D5A80),
                                //     child: Row(
                                //       textDirection: TextDirection.rtl,
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         Text('ویرایش آزمون',style: TextStyle(color: Colors.white),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                                //         Icon(Icons.edit,color: Colors.white,),
                                //       ],
                                //     ),//Text("ویرایش آزمون",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                                //     onPressed: EditExam
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
                        itemCount:  EditExamPage.questionList.length,
                        itemBuilder: (BuildContext context, int index)
                        {
                          return QuestionViewInEditExam(question: EditExamPage.questionList[index],parent: this,index: index,);
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
                                  color: Color(0xFF3D5A80),
                                  child: Text("ایجاد سوال"),
                                  onPressed: ClickAddQuestion
                              ),
                              RaisedButton(
                                  textColor: Colors.white,
                                  color: Color(0xFF0e918c),
                                  child: Text("سوالات من"),
                                  onPressed: ClickMyQuestion
                              ),
                              RaisedButton(
                                  textColor: Colors.white,
                                  color: Color.fromRGBO(238, 108,77 ,1.0),
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
                              EditingTwoLineQuestionSpecification(question: newQuestion,payeData: payeData,bookData: bookData,chapterData: chapterData,kindData: kindData,difficultyData: difficultyData,parent2: this,),
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
                              //   child: Container(
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
