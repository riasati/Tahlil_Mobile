import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/domain/searchFilters.dart';
import 'package:samproject/pages/createExamPage.dart';
import 'package:samproject/pages/editExamPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:samproject/widgets/questionWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QuestionView extends StatefulWidget {
  Question question;
  bool IsAddtoExamEnable;
  CreateExamPageState parent;
  EditExamPageState parent2;
  QuestionView({Key key,this.question,this.IsAddtoExamEnable = false,this.parent,this.parent2}) : super(key: key);
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  bool viewAnswerbool = false;
  void viewAnswer()
  {
    setState(() {
      (viewAnswerbool) ? viewAnswerbool = false : viewAnswerbool = true;
    });
  }

  int _radioGroupValue = 0;
  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
    });
  }
  void viewTestAnswer()
  {
    setState(() {
      _radioGroupValue = widget.question.numberOne;
    });
  }
  bool optionOne = false;
  void optionOneChange(bool newValue) {
    setState(() {
      optionOne = newValue;
    });
  }
  bool optionTwo = false;
  void optionTwoChange(bool newValue) {
    setState(() {
      optionTwo = newValue;
    });
  }
  bool optionThree = false;
  void optionThreeChange(bool newValue) {
    setState(() {
      optionThree = newValue;
    });
  }
  bool optionFour = false;
  void optionFourChange(bool newValue) {
    setState(() {
      optionFour = newValue;
    });
  }

  void viewMultiOptionAnswer()
  {
    setState(() {
      (widget.question.numberOne == 1) ? optionOne = true : optionOne = false;
      (widget.question.numberTwo == 1) ? optionTwo = true : optionTwo = false;
      (widget.question.numberThree == 1) ? optionThree = true : optionThree = false;
      (widget.question.numberFour == 1) ? optionFour = true : optionFour = false;
    });
  }
  void onAddtoExamButton()
  {
    if (widget.parent != null)
    {
      CreateExamPage.questionList.add(widget.question);
      widget.parent.setState(() {
        //_contents.add(dragAndDrop());
      });
    }
    if (widget.parent2 != null)
    {
      EditExamPage.questionList.add(widget.question);
      widget.parent2.setState(() {
        //_contents.add(dragAndDrop());
      });
    }
    Navigator.pop(context);
  }

  Widget TestView()
  {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 1, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 2, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 3, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 4, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
            ],
          ),
        ],
      ),
    );
  }
  Widget MultiChoiseView()
  {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionOne, onChanged: optionOneChange),
              Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionTwo, onChanged: optionTwoChange),
              Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionThree, onChanged: optionThreeChange),
              Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionFour, onChanged: optionFourChange),
              Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
            ],
          ),
        ],
      ),
    );
  }
  Widget AnswerStringView()
  {
    return (viewAnswerbool) ?
    NotEditingAnswerString(question: widget.question,)
        :Container();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            NotEditingQuestionSpecification(question: widget.question,),
            NotEditingQuestionText(question: widget.question,),
            if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"]) MultiChoiseView()
            else if (widget.question.kind == HomePage.maps.SKindMap["TEST"]) TestView()
            else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"]) AnswerStringView()
            else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]) AnswerStringView(),
            if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"]) VisitAnswerAndAddtoExamButton(onVisitAnswerPressed: viewMultiOptionAnswer,IsAddtoExamEnable: widget.IsAddtoExamEnable,onAddtoExamPressed: onAddtoExamButton,)
            else if (widget.question.kind == HomePage.maps.SKindMap["TEST"]) VisitAnswerAndAddtoExamButton(onVisitAnswerPressed: viewTestAnswer,IsAddtoExamEnable: widget.IsAddtoExamEnable,onAddtoExamPressed: onAddtoExamButton,)
            else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"]) VisitAnswerAndAddtoExamButton(onVisitAnswerPressed: viewAnswer,IsAddtoExamEnable: widget.IsAddtoExamEnable,onAddtoExamPressed: onAddtoExamButton,)
            else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]) VisitAnswerAndAddtoExamButton(onVisitAnswerPressed: viewAnswer,IsAddtoExamEnable: widget.IsAddtoExamEnable,onAddtoExamPressed: onAddtoExamButton,),
          ],
        ),
      ),
    );
  }
}


class SearchQuestionPage extends StatefulWidget {
  bool IsAddtoExamEnable;
  CreateExamPageState parent;
  EditExamPageState parent2;
  SearchQuestionPage({Key key,this.IsAddtoExamEnable = false,this.parent,this.parent2}) : super(key: key);
  @override
  _SearchQuestionPageState createState() => _SearchQuestionPageState();
}

class _SearchQuestionPageState extends State<SearchQuestionPage> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  SearchFilters searchFilters = new SearchFilters();
 @override
  void initState() {
    super.initState();
    getFirstQuestions();
  }

  List<Question> questionList = [];
  int totalpage = 0;
  int thispage = 1;

  void getFirstQuestions() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;

    var headers = {
      'accept': 'application/json',
      'Authorization': tokenplus,
      "content-type": "application/json"
    };

    var params = {
      'page': '1',
      'limit': '5',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    dynamic data = jsonEncode(<String,dynamic>{
      "type":[],
      "base": [],
      "hardness" : [],
      "course": [],
      "chapter" : [],
    });
    questionList = [];
    String url = 'https://parham-backend.herokuapp.com/bank?$query';
    var response = await http.post(url,
      headers: headers,
      body: data,
    );
    if (response.statusCode == 200){
      //print("ok");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      totalpage = responseJson["totalPages"];

      // print(responseJson["questions"].length);
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
        qs.imageQuestion = responseJson["questions"][i]["imageQuestion"];
        qs.imageAnswer = responseJson["questions"][i]["imageAnswer"];
        qs.id = responseJson["questions"][i]["qId"];

        Question q = Question.QuestionServerToQuestion(qs,qs.type);
        questionList.add(q);
      }
      setState(() {

      });
    }
    else{
      print("not okey");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      ShowCorrectnessDialog(false,context);
    }

  }
  void searchQuestion() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;

    var headers = {
      'accept': 'application/json',
      'Authorization': tokenplus,
      "content-type": "application/json"
    };

    var params = {
      'page': thispage.toString(),
      'limit': '5',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    SearchFilters SF = searchFilters.SearchFilterForServer();
    dynamic data = jsonEncode(<String,dynamic>{
      "type":SF.kindList,
      "base": SF.payeList,
      "hardness" : SF.difficultyList,
      "course": SF.bookList,
      "chapter" : SF.chapterList,
    });
    questionList = [];
    String url = 'https://parham-backend.herokuapp.com/bank?$query';
    var response = await http.post(url,
        headers: headers,
      body: data,
    );
    // print(url);
    // print(headers);
    // print(data);
    if (response.statusCode == 200){
      print("ok");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      if (responseJson["message"] == "nothing found")
      {
        ShowCorrectnessDialog(true, context);
        totalpage = 0;
        thispage = 1;
        questionList = [];
        setState(() {

        });
        print("not found");
        _btnController.stop();
        return;
      }
      totalpage = responseJson["totalPages"];

     // print(responseJson["questions"].length);
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
        qs.imageQuestion = responseJson["questions"][i]["imageQuestion"];
        qs.imageAnswer = responseJson["questions"][i]["imageAnswer"];
        qs.id = responseJson["questions"][i]["qId"];

        Question q = Question.QuestionServerToQuestion(qs,qs.type);
        questionList.add(q);
      }

      _btnController.stop();
      setState(() {

      });
    }
    else{
      print("not okey");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      ShowCorrectnessDialog(false,context);
        _btnController.stop();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.IsAddtoExamEnable) ? AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 40),
          child: Text(
            "بانک سوال",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )
          : null,
      body: Container(
        child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(padding: const EdgeInsets.all(4.0),alignment: Alignment.centerRight,child: Text("جستجو بر اساس",textDirection: TextDirection.rtl,)),
                          SearchFilterWidget(searchFilters: searchFilters ,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoundedLoadingButton(
                              height: 30,
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('جستجو',style: TextStyle(color: Colors.white),),
                                  Icon(Icons.search,color: Colors.white,),
                                ],
                              ),
                              controller: _btnController,
                              color: Color.fromRGBO(238, 108,77 ,1.0), //Color.(0xFF3D5A80),
                              onPressed: () => searchQuestion(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: questionList.length,
                        itemBuilder: (BuildContext context, int index)
                        {
                          return QuestionView(question: questionList[index],IsAddtoExamEnable: widget.IsAddtoExamEnable,parent: widget.parent,parent2:widget.parent2);
                        }
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        //physics: NeverScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: totalpage,
                        itemBuilder: (BuildContext context, int index)
                        {
                          int indexplus = index+1;
                          return InkWell(
                            onTap: ()
                            {
                              thispage = indexplus;
                              searchQuestion();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              // width: 20,
                              // height: 20,
                              color: Color(0xFF3D5A80),
                              child: (indexplus == thispage) ? Text("$indexplus",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.amber),) : Text("$indexplus",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );

  }
}