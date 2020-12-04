import 'dart:convert';

import 'package:flutter/material.dart';
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
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token == null) {return;}
      String tokenplus = "Bearer" + " " + token;
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

      String ServerPaye = HomePage.maps.RSPayeMap[changedQuestion.paye];
      String ServerBook = HomePage.maps.RSBookMap[changedQuestion.book];
      String ServerChapter = HomePage.maps.RSChapterMap[changedQuestion.chapter];
      String ServerKind = HomePage.maps.RSKindMap[changedQuestion.kind];
      String ServerDifficulty = HomePage.maps.RSDifficultyMap[changedQuestion.difficulty];

      dynamic data;

      //if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"])
      if (changedQuestion.kind == HomePage.maps.SKindMap["MULTICHOISE"])
      {
        // widget.question.optionOne = controllers.MultiOptionText1Controller.text;
        // widget.question.optionTwo = controllers.MultiOptionText2Controller.text;
        // widget.question.optionThree = controllers.MultiOptionText3Controller.text;
        // widget.question.optionFour = controllers.MultiOptionText4Controller.text;
        changedQuestion.optionOne = controllers.MultiOptionText1Controller.text;
        changedQuestion.optionTwo = controllers.MultiOptionText2Controller.text;
        changedQuestion.optionThree = controllers.MultiOptionText3Controller.text;
        changedQuestion.optionFour = controllers.MultiOptionText4Controller.text;
        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": ServerKind,
          "public": qs.public,
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness" : ServerDifficulty,
          "course": ServerBook,
          "options" : qs.options,
          "chapter" : ServerChapter,
        });
      }
      //else if (widget.question.kind == HomePage.maps.SKindMap["TEST"])
      else if (changedQuestion.kind == HomePage.maps.SKindMap["TEST"])
      {
        // widget.question.optionOne = controllers.TestText1Controller.text;
        // widget.question.optionTwo = controllers.TestText2Controller.text;
        // widget.question.optionThree = controllers.TestText3Controller.text;
        // widget.question.optionFour = controllers.TestText4Controller.text;
        changedQuestion.optionOne = controllers.TestText1Controller.text;
        changedQuestion.optionTwo = controllers.TestText2Controller.text;
        changedQuestion.optionThree = controllers.TestText3Controller.text;
        changedQuestion.optionFour = controllers.TestText4Controller.text;

        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": ServerKind,
          "public": qs.public,
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness" : ServerDifficulty,
          "course": ServerBook,
          "options" : qs.options,
          "chapter" : ServerChapter,
        });
      }
      else if (changedQuestion.kind == HomePage.maps.SKindMap["LONGANSWER"]){
     // else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]){
        //widget.question.answerString = controllers.TashrihiTextController.text;
        changedQuestion.answerString = controllers.TashrihiTextController.text;
        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": ServerKind,
          "public": qs.public,
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          if(changedQuestion.answerImage != null) "imageAnswer" : changedQuestion.answerImage,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness" : ServerDifficulty,
          "course": ServerBook,
          "chapter" : ServerChapter,
        });
      }
      else if (changedQuestion.kind == HomePage.maps.SKindMap["SHORTANSWER"]){
        changedQuestion.answerString = controllers.BlankTextController.text;
        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": ServerKind,
          "public": qs.public,
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness" : ServerDifficulty,
          "course": ServerBook,
          "chapter" : ServerChapter,
        });
     // else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"])
      //{
      //  widget.question.answerString = controllers.BlankTextController.text;
      }
      final response = await http.put('https://parham-backend.herokuapp.com/question',
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data
      );
      if (response.statusCode == 200){
       // ShowCorrectnessDialog(true,context);
        print("Question changed ");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());

        widget.question = changedQuestion.CopyQuestion();

      }
      else{
        ShowCorrectnessDialog(false,context);
        print("Question failed");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());

      }

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
                    (widget.index != CreateExamPage.questionList.length-1)? Flexible(flex: 1,child: IconButton(icon: Icon(Icons.arrow_downward),onPressed: onDownwardArrowClick,)):Container(width: 0,height: 0,),
                    Flexible(flex: 9,child:(question.grade == null) ? Text("بارم : 0.0",textDirection: TextDirection.rtl):Text("بارم : "+ question.grade.toString(),textDirection: TextDirection.rtl)),
                  ],
                ),
              ),
              EditAndAddtoExamButton(onEditPressed: onEditButton,IsAddtoExamEnable: false)
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
    widget.parent.setState(() {
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

  bool presedCreatedNewQuestion = false;
  Controllers controller = new Controllers();
  Question newQuestion = new Question();
  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  popupMenuData bookData = new popupMenuData("درس");
  popupMenuData chapterData = new popupMenuData("فصل");
  popupMenuData kindData = new popupMenuData("نوع سوال");
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");


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
      //_btnController.stop();
    } else {
      ShowCorrectnessDialog(false, context);
      print("Question failed");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
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
      String id = CreateExamPage.questionList[i].id;
      print(CreateExamPage.questionList[i].id);
      double grade = CreateExamPage.questionList[i].grade;
      questionObjects.add({"question" : id , "grade" : grade});
      //print(CreateExamPage.questionList[i].id);
    }
    if (examDate.text.isEmpty || examStartTime.text.isEmpty || examFinishTime.text.isEmpty || examDurationTime.text.isEmpty)
    {
      ShowCorrectnessDialog(false, context);
      return;
    }
    List<String> dates = examDate.text.split("/");
    List<String> startTimes = examStartTime.text.split(":");
    List<String> finishTimes = examFinishTime.text.split(":");
    Jalali j = new Jalali(int.tryParse(dates[0]),int.tryParse(dates[1]),int.tryParse(dates[2]));
    Gregorian g = j.toGregorian();
    print(g.year.toString() + "-" + g.month.toString() + "-" + g.day.toString() + " " + examStartTime.text);
    DateTime startExamDatetime;
    DateTime endExamDatetime;
    if (startTimes.length == 1)
    {
      startExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(startTimes[0]),);
    }
    else
      {
        startExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(startTimes[0]),int.tryParse(startTimes[1]));
      }
    if(finishTimes.length == 1)
    {
      endExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(finishTimes[0]));
    }
    else
      {
        endExamDatetime = new DateTime(g.year,g.month,g.day,int.tryParse(finishTimes[0]),int.tryParse(finishTimes[1]));
      }
    //print(startExamDatetime.toIso8601String());
    //print(endExamDatetime.toIso8601String());
    data = jsonEncode(<String, dynamic>{
      "name": examTopic.text,
      "startDate": startExamDatetime.toIso8601String(),
      "endDate": endExamDatetime.toIso8601String(),
      "examLength": int.tryParse(examDurationTime.text),
      "questions": questionObjects,//[{"question" : "adsfasd","grade":3}],
      "useInClass": widget.classId,
    });
    //print(data);
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
      CreateExamPage.questionList.clear();
    }
    else
      {
        ShowCorrectnessDialog(false, context);
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
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
                                            keyboardType: TextInputType.datetime,
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
                                          keyboardType: TextInputType.number,
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
                                          keyboardType: TextInputType.number,
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
                              color: Color(0xFF3D5A80),
                              child: Text("ایجاد سوال"),
                              onPressed: ClickAddQuestion
                             ),
                            RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xFF3D5A80),
                                child: Text("سوالات من"),
                                onPressed: ClickMyQuestion
                            ),
                            RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xFF3D5A80),
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
                            RaisedButton(
                              textColor: Colors.white,
                              color: Color(0xFF3D5A80),
                              child: Text("ایجاد سوال"),
                              onPressed: onCreateQuestion,
                            ),
                          ],
                        ) : Container(),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF3D5A80),
                    child: Text("ایجاد آزمون"),
                    onPressed: CreateExam
                ),
              ],
            ),
          ),
        )),
    );
  }
}