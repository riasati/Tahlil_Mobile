import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/pages/createExamPage.dart';
import 'package:samproject/pages/editExamPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samproject/widgets/questionWidgets.dart';
import 'package:samproject/domain/controllers.dart';


class QuestionViewInMyQuestion extends StatefulWidget {
  Question question;
  CreateExamPageState parent;
  bool IsAddtoExamEnable;
  MyQuestionPageState parent2;
  EditExamPageState parent3;
  QuestionViewInMyQuestion({Key key,this.question,this.IsAddtoExamEnable = false,this.parent,this.parent2,this.parent3}) : super(key: key);
  @override
  QuestionViewInMyQuestionState createState() => QuestionViewInMyQuestionState();
}

class QuestionViewInMyQuestionState extends State<QuestionViewInMyQuestion> {
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
      if (changedQuestion.kind == HomePage.maps.SKindMap["MULTICHOISE"])
      {
        changedQuestion.optionOne = controllers.MultiOptionText1Controller.text;
        changedQuestion.optionTwo = controllers.MultiOptionText2Controller.text;
        changedQuestion.optionThree = controllers.MultiOptionText3Controller.text;
        changedQuestion.optionFour = controllers.MultiOptionText4Controller.text;

        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": ServerKind,
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness" : ServerDifficulty,
          "course": ServerBook,
          "options" : qs.options,
          "chapter" : ServerChapter,
        });
      }
      else if (changedQuestion.kind == HomePage.maps.SKindMap["TEST"])
      {
        changedQuestion.optionOne = controllers.TestText1Controller.text;
        changedQuestion.optionTwo = controllers.TestText2Controller.text;
        changedQuestion.optionThree = controllers.TestText3Controller.text;
        changedQuestion.optionFour = controllers.TestText4Controller.text;

        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": ServerKind,
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          "public": qs.public,
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
        changedQuestion.answerString = controllers.TashrihiTextController.text;

        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion,ServerKind);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": ServerKind,
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          if(changedQuestion.answerImage != null) "imageAnswer" : changedQuestion.answerImage,
          "public": qs.public,
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
          if(changedQuestion.questionImage != null) "imageQuestion" : changedQuestion.questionImage,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": ServerPaye,
          "hardness" : ServerDifficulty,
          "course": ServerBook,
          "chapter" : ServerChapter,
        });
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
        ShowCorrectnessDialog(true,context);
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
                Flexible(flex: 1,child: IconButton(icon: Icon(Icons.clear),onPressed: onCloseButton,)),
                Flexible(flex: 12,child: EditingOneLineQuestionSpecification(question: changedQuestion,payeData: payeData,bookData: bookData,kindData: kindData,chapterData: chapterData,difficultyData: difficultyData,parent: this,)),
              ],
            ),
            EditingQuestionText(controllers: controllers,question: changedQuestion,),
            if (kindData.name == HomePage.maps.SKindMap["MULTICHOISE"]) EditingMultiChoiceOption(controllers: controllers,question: changedQuestion,)
            else if (kindData.name == HomePage.maps.SKindMap["TEST"]) EditingTest(question: changedQuestion,controllers: controllers,)
            else if (kindData.name == HomePage.maps.SKindMap["SHORTANSWER"]) EditingShortAnswer(question: changedQuestion,controllers: controllers,)
              else if (kindData.name == HomePage.maps.SKindMap["LONGANSWER"]) EditingLongAnswer(question: changedQuestion,controllers: controllers,),
            AddInBankOption(question: changedQuestion,),
            EditAndAddtoExamButton(onEditPressed: onEditButton,onCancelPressed: onCancelClick,IsEditing: true,IsAddtoExamEnable: widget.IsAddtoExamEnable,onAddtoExamPressed: onAddtoExamButton,),
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
                      Flexible(flex: 12,child: NotEditingQuestionSpecification(question: question,)),
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
              EditAndAddtoExamButton(onEditPressed: onEditButton,IsAddtoExamEnable: widget.IsAddtoExamEnable,onAddtoExamPressed: onAddtoExamButton,),
            ],
          )
      ),
    );
  }
  void onAddtoExamButton()
  {
    if (widget.parent != null)
    {
      CreateExamPage.questionList.add(widget.question);
      widget.parent.setState(() {

      });
    }
    if (widget.parent3 != null)
    {
      EditExamPage.questionList.add(widget.question);
      widget.parent3.setState(() {

      });
    }


    Navigator.pop(context);
  }
  void onCloseButton() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;
    String id = widget.question.id;
    final response = await http.delete('https://parham-backend.herokuapp.com/question/$id',
      headers: {
        'accept': 'application/json',
        'Authorization': tokenplus,
        'Content-Type': 'application/json',
      },

    );
    if (response.statusCode == 200){
      ShowCorrectnessDialog(true,context);
      print("Question eliminated");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      setState(() {
        IsDelete = true;
      });
      MyQuestionPageState.questionList.remove(widget.question);
      widget.parent2.setState(() {

      });
    }
    else{
      ShowCorrectnessDialog(false,context);
      print("Question failed");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      setState(() {
        IsDelete = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
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

    payeData = new popupMenuData("پایه تحصیلی");
    bookData = new popupMenuData("درس");
    chapterData = new popupMenuData("فصل");
    kindData = new popupMenuData("نوع سوال");
    difficultyData = new popupMenuData("دشواری سوال");
    kindData.name = widget.question.kind;

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


class MyQuestionPage extends StatefulWidget {
  bool IsAddtoExamEnable;
  CreateExamPageState parent;
  EditExamPageState parent2;
  MyQuestionPage({Key key,this.IsAddtoExamEnable = false,this.parent,this.parent2}) : super(key: key);
  @override
  MyQuestionPageState createState() => MyQuestionPageState();
}

class MyQuestionPageState extends State<MyQuestionPage> {

  static List<Question> questionList = [];
  int totalpage = 0;
  int thispage = 1;
  void getMyQuestion() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;

    var headers = {
      'accept': 'application/json',
      'Authorization': tokenplus,
    };

    var params = {
      'page': thispage.toString(),
      'limit': '5',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var response = await http.get('https://parham-backend.herokuapp.com/question?$query', headers: headers);
    questionList = [];
    if (response.statusCode == 200)
    {
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      totalpage = responseJson["totalPages"];
      for (int i=0;i<responseJson["questions"].length;i++)
      {
        QuestionServer qs = new QuestionServer();
        qs.type = responseJson["questions"][i]["type"];
        qs.question = responseJson["questions"][i]["question"];
        qs.base = responseJson["questions"][i]["base"];
        qs.course = responseJson["questions"][i]["course"];
        qs.chapter = responseJson["questions"][i]["chapter"];
        qs.hardness = responseJson["questions"][i]["hardness"];
        qs.answer = responseJson["questions"][i]["answers"];
        qs.options = responseJson["questions"][i]["options"];
        qs.public = responseJson["questions"][i]["public"];
        qs.id = responseJson["questions"][i]["_id"];
        qs.imageQuestion = responseJson["questions"][i]["imageQuestion"];
        qs.imageAnswer = responseJson["questions"][i]["imageAnswer"];

        Question q = Question.QuestionServerToQuestion(qs,qs.type);
        questionList.add(q);
      }
      setState(() {

      });
    }
    else
    {
      final responseJson = jsonDecode(response.body);
      if (responseJson["error"] == "nothing found")
      {
        ShowCorrectnessDialog(true, context);
      }
      else
      {
        ShowCorrectnessDialog(false, context);
      }

    }

  }

  @override
  void initState() {
    super.initState();
    getMyQuestion();
  }

  bool IsDelete = false;
  bool IsEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          padding: EdgeInsets.only(right: 40),
          alignment: Alignment.center,
          child: Text(
            "سوالات من",
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
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Flexible(
                flex: 11,
                child: ListView.builder(
                    itemCount: questionList.length,
                    itemBuilder: (BuildContext context, int index)
                    {
                      return QuestionViewInMyQuestion(question: questionList[index],IsAddtoExamEnable: widget.IsAddtoExamEnable,parent : widget.parent,parent2: this,parent3:widget.parent2);
                    }
                ),
              ),

              Flexible(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: totalpage,
                    itemBuilder: (BuildContext context, int index)
                    {
                      int indexplus = index+1;
                      return InkWell(
                        onTap: ()
                        {
                          thispage = indexplus;
                          getMyQuestion();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          color: Color(0xFF3D5A80),
                          child: (indexplus == thispage) ? Text("$indexplus",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.amber),) : Text("$indexplus",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),//Text("$indexplus",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
                        ),
                      );
                    }
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
