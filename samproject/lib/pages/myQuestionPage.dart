import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samproject/widgets/questionWidgets.dart';
import 'package:samproject/domain/controllers.dart';


class QuestionView extends StatefulWidget {
  Question question;
  QuestionView({Key key,this.question}) : super(key: key);
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  Controllers controllers = new Controllers();
  bool IsDelete = false;
  bool IsEdit = false;

  Widget Editing(Question question,VoidCallback onCloseButton,Controllers controllers)//VoidCallback onEditButton,VoidCallback onCloseButton
  {
    Question changedQuestion = widget.question.CopyQuestion();

    popupMenuData payeData = new popupMenuData("پایه تحصیلی");
    popupMenuData bookData = new popupMenuData("درس");
    popupMenuData chapterData = new popupMenuData("فصل");
    popupMenuData kindData = new popupMenuData("نوع سوال");
    popupMenuData difficultyData = new popupMenuData("دشواری سوال");

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
      dynamic data;
      if (widget.question.kind == "چند گزینه ای")
      {
        changedQuestion.optionOne = controllers.MultiOptionText1Controller.text;
        changedQuestion.optionTwo = controllers.MultiOptionText2Controller.text;
        changedQuestion.optionThree = controllers.MultiOptionText3Controller.text;
        changedQuestion.optionFour = controllers.MultiOptionText4Controller.text;

        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": qs.type,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": qs.base,
          "hardness" : qs.hardness,
          "course": qs.course,
          "options" : qs.options,
          "chapter" : qs.chapter,
        });
      }
      else if (widget.question.kind == "تستی")
      {
        changedQuestion.optionOne = controllers.TestText1Controller.text;
        changedQuestion.optionTwo = controllers.TestText2Controller.text;
        changedQuestion.optionThree = controllers.TestText3Controller.text;
        changedQuestion.optionFour = controllers.TestText4Controller.text;

        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": qs.type,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": qs.base,
          "hardness" : qs.hardness,
          "course": qs.course,
          "options" : qs.options,
          "chapter" : qs.chapter,
        });
      }
      else {
        changedQuestion.answerString = controllers.TashrihiTextController.text;

        QuestionServer qs = QuestionServer.QuestionToQuestionServer(changedQuestion);
        data = jsonEncode(<String,dynamic>{
          "questionId":qs.id,
          "type": qs.type,
          "public": qs.public,
          "question": qs.question,
          "answers": qs.answer,
          "base": qs.base,
          "hardness" : qs.hardness,
          "course": qs.course,
          "chapter" : qs.chapter,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            EditingOneLineQuestionSpecification(question: changedQuestion,payeData: payeData,bookData: bookData,kindData: kindData,chapterData: chapterData,difficultyData: difficultyData,),
            EditingQuestionText(controllers: controllers,question: changedQuestion,),
            if (widget.question.kind == "چند گزینه ای") EditingMultiChoiceOption(controllers: controllers,question: changedQuestion,)
            else if (widget.question.kind == "تستی") EditingTest(question: changedQuestion,controllers: controllers,)
            else if (widget.question.kind == "جایخالی") EditingAnswerString(question: changedQuestion,controllers: controllers,)
            else if (widget.question.kind == "تشریحی") EditingAnswerString(question: changedQuestion,controllers: controllers,),
            AddInBankOption(question: changedQuestion,),
            EditAndEliminateButton(onEditPressed: onEditButton,onEliminatePressed: onCloseButton,),
          ],
        ),
      ),
    );
  }
  Widget NotEditing(Question question,VoidCallback onCloseButton,)
  {
    void onEditButton()
    {
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
                  NotEditingQuestionSpecification(question: question,),
                  NotEditingQuestionText(question: question,),
                  if (widget.question.kind == "چند گزینه ای") NotEditingMultiChoiceOption(question: question,isNull: true,)
                  else if (widget.question.kind == "تستی") NotEditingTest(question: question)
                  else if (widget.question.kind == "جایخالی") NotEditingAnswerString(question: question)
                  else if (widget.question.kind == "تشریحی") NotEditingAnswerString(question: question),
                ],
              ),
              EditAndEliminateButton(onEditPressed: onEditButton,onEliminatePressed: onCloseButton,),
            ],
          )
      ),
    );
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
  @override
  _MyQuestionPageState createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  Question newQuestion = new Question();
  Question newQuestion2 = new Question();
  Question newQuestion3 = new Question();
  Question newQuestion4 = new Question();

  List<Question> questionList = [];
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

        Question q = Question.QuestionServerToQuestion(qs);
        questionList.add(q);
      }
      setState(() {

      });
    }
    else
    {
      ShowCorrectnessDialog(false, context);
    }

  }
  @override
  void initState() {
    super.initState();
   getMyQuestion();
    // newQuestion.paye = "دهم";
    // newQuestion.book = "فیزیک";
    // newQuestion.chapter = "چهارم";
    // newQuestion.kind = "تشریحی";
    // newQuestion.difficulty = "سخت";
    // newQuestion.text = "هر میکرو معادل با 10 به توان چند است؟";
    // //newQuestion.questionImage = "عکس سوال";
    // newQuestion.answerString = "منهای شش";
    // //newQuestion.image2 = "عکس پاسخ";
    // newQuestion.isPublic = false;
    //
    // newQuestion2.paye = "دهم";
    // newQuestion2.book = "فیزیک";
    // newQuestion2.chapter = "چهارم";
    // newQuestion2.kind = "چند گزینه ای";
    // newQuestion2.difficulty = "سخت";
    // newQuestion2.text = "هر میکرو معادل با 10 به توان چند است؟";
    // newQuestion2.questinImage = "عکس سوال";
    // newQuestion2.optionOne = "به توان یک";
    // newQuestion2.optionTwo = "به توان دو";
    // newQuestion2.optionThree = "به توان سه";
    // newQuestion2.optionFour = "به توان چهار";
    // newQuestion2.numberOne = 0;
    // newQuestion2.numberTwo = 1;
    // newQuestion2.numberThree = 1;
    // newQuestion2.numberFour = 0;
    // newQuestion2.isPublic = true;
    //
    // newQuestion3.paye = "دهم";
    // newQuestion3.book = "فیزیک";
    // newQuestion3.chapter = "چهارم";
    // newQuestion3.kind = "تستی";
    // newQuestion3.difficulty = "سخت";
    // newQuestion3.text = "هر میکرو معادل با 10 به توان چند است؟";
    // newQuestion3.questinImage = "عکس سوال";
    // newQuestion3.optionOne = "به توان یک";
    // newQuestion3.optionTwo = "به توان دو";
    // newQuestion3.optionThree = "به توان سه";
    // newQuestion3.optionFour = "به توان چهار";
    // newQuestion3.numberOne = 2;
    // newQuestion.isPublic = true;
    //
    // newQuestion4.paye = "دهم";
    // newQuestion4.book = "فیزیک";
    // newQuestion4.chapter = "چهارم";
    // newQuestion4.kind = "جایخالی";
    // newQuestion4.difficulty = "سخت";
    // newQuestion4.text = "هر میکرو معادل با 10 به توان چند است؟";
    // newQuestion4.questinImage = "عکس سوال";
    // newQuestion4.answerString = "منهای شش";
    // newQuestion4.isPublic = false;

  }

  bool IsDelete = false;
  bool IsEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
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
                      return QuestionView(question: questionList[index]);
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
