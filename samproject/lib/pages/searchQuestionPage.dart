import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:samproject/widgets/popumMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchQuestionPage extends StatefulWidget {
  @override
  _SearchQuestionPageState createState() => _SearchQuestionPageState();
}

class _SearchQuestionPageState extends State<SearchQuestionPage> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  List<String> payelist = ["دهم","یازدهم","دوازدهم"];
  popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = ["ریاضی","فیزیک","شیمی","زیست"];
  popupMenuData chapterData = new popupMenuData("فصل");
  List<String> cahpterlist = ["اول","دوم","سوم","چهارم","پنجم","ششم","هفتم","هشتم","نهم","دهم",];
  popupMenuData kindData = new popupMenuData("نوع سوال");
  List<String> kindlist = ["تستی","جایخالی","چند گزینه ای","تشریحی"];
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = ["آسان","متوسط","سخت"];
  
  Question newQuestion = new Question();
  Question newQuestion2 = new Question();
  Question newQuestion3 = new Question();
  Question newQuestion4 = new Question();

 @override
  void initState() {
    super.initState();
    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(cahpterlist);
    kindData.fillStringList(kindlist);
    difficultyData.fillStringList(difficultylist);

    newQuestion.paye = "دهم";
    newQuestion.book = "فیزیک";
    newQuestion.chapter = "چهارم";
    newQuestion.kind = "تشریحی";
    newQuestion.difficulty = "سخت";
    newQuestion.text = "هر میکرو معادل با 10 به توان چند است؟";
    //newQuestion.image1 = "عکس سوال";
    newQuestion.answerString = "منهای شش";
    //newQuestion.image2 = "عکس پاسخ";

    newQuestion2.paye = "دهم";
    newQuestion2.book = "فیزیک";
    newQuestion2.chapter = "چهارم";
    newQuestion2.kind = "چند گزینه ای";
    newQuestion2.difficulty = "سخت";
    newQuestion2.text = "هر میکرو معادل با 10 به توان چند است؟";
    newQuestion2.questinImage = "عکس سوال";
    newQuestion2.optionOne = "به توان یک";
    newQuestion2.optionTwo = "به توان دو";
    newQuestion2.optionThree = "به توان سه";
    newQuestion2.optionFour = "به توان چهار";
    newQuestion2.numberOne = 0;
    newQuestion2.numberTwo = 1;
    newQuestion2.numberThree = 1;
    newQuestion2.numberFour = 0;

    newQuestion3.paye = "دهم";
    newQuestion3.book = "فیزیک";
    newQuestion3.chapter = "چهارم";
    newQuestion3.kind = "تستی";
    newQuestion3.difficulty = "سخت";
    newQuestion3.text = "هر میکرو معادل با 10 به توان چند است؟";
    newQuestion3.questinImage = "عکس سوال";
    newQuestion3.optionOne = "به توان یک";
    newQuestion3.optionTwo = "به توان دو";
    newQuestion3.optionThree = "به توان سه";
    newQuestion3.optionFour = "به توان چهار";
    newQuestion3.numberOne = 2;

    newQuestion4.paye = "دهم";
    newQuestion4.book = "فیزیک";
    newQuestion4.chapter = "چهارم";
    newQuestion4.kind = "جایخالی";
    newQuestion4.difficulty = "سخت";
    newQuestion4.text = "هر میکرو معادل با 10 به توان چند است؟";
    newQuestion4.questinImage = "عکس سوال";
    newQuestion4.answerString = "منهای شش";

  }

  List<Question> questionList = [];
  int totalpage = 0;
  int thispage = 1;

  void searchQuestion() async
  {
    final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token");
    print("in searchQuestion");

    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyMTgwNzF9.wS8GHC67ZBswQjEisWkMgot3_r92PnRyvN5WlMmhG34";
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;

    var headers = {
      'accept': 'application/json',
      'Authorization': tokenplus,
    };

    var params = {
      'page': thispage.toString(),
      'limit': '1',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    Question temporaryQuestion = new Question();
    print("in searchQuestion 2");
    temporaryQuestion.paye = payeData.name;
    temporaryQuestion.book = bookData.name;
    temporaryQuestion.chapter = chapterData.name;
    temporaryQuestion.kind = kindData.name;
    temporaryQuestion.difficulty = difficultyData.name;
    print(temporaryQuestion.paye);
    print(temporaryQuestion.book);
    print(temporaryQuestion.chapter);
    print(temporaryQuestion.kind);
    print(temporaryQuestion.difficulty);
    QuestionServer qs = QuestionServer.QuestionToQuestionServer(temporaryQuestion);

    print(qs.type);
    print(qs.base);
    print(qs.hardness);
    print(qs.course);
    dynamic data = jsonEncode(<String,dynamic>{
      "type":[qs.type],
      "base": [qs.base],
      "hardness" : [qs.hardness],
      "course": [qs.course],
   //   "chapter" : [qs.chapter],
    });
    questionList = [];
    print("in searchQuestion 3");
    var response = await http.post('https://parham-backend.herokuapp.com/bank?$query',
        headers: headers,
      body: data
    );
    if (response.statusCode == 200){
      print("ok");
      final responseJson = jsonDecode(response.body);
      //print(responseJson.toString());

      totalpage = responseJson["totalPages"];
      print(responseJson["questions"].length);
      for (int i=0;i<responseJson["questions"].length;i++)
      {
        QuestionServer qs = new QuestionServer();
        qs.type = responseJson["questions"][i]["type"];
        qs.question = responseJson["questions"][i]["question"];
        qs.base = responseJson["questions"][i]["base"];
       // qs.course = responseJson["questions"][i]["course"];
        qs.chapter = responseJson["questions"][i]["chapter"];
        qs.hardness = responseJson["questions"][i]["hardness"];
        qs.answer = responseJson["questions"][i]["answers"].toString();
        qs.options = responseJson["questions"][i]["options"];
     //   qs.public = responseJson["questions"][i]["public"].toString();
    //    qs.id = responseJson["questions"][i]["_id"];

        // print(qs.type);
        // print(qs.public);
        // print(qs.question);
        // //print(qs.answer);
        // print(qs.base);
        // print(qs.hardness);
        // print(qs.course);
        // print("---");
        Question q = Question.QuestionServerToQuestion(qs);
        print(q.kind);
        print(q.isPublic);
        print(q.text);
        //print(qs.answer);
        print(q.paye);
        print(q.difficulty);
        print(q.book);
        questionList.add(q);
      }
      // for (int i=0;i<questionList.length;i++)
      // {
      //   print(questionList[i].text);
      // }
      _btnController.stop();
      setState(() {

      });
    }
    else{
      print("nokey");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      ShowCorrectnessDialog(false,context);
        _btnController.stop();
      //_showMyDialog(false);
      //_btnController.stop();
    }




    // print(payeData.name);
    // print(bookData.name);
    // print(chapterData.name);
    // print(kindData.name);
    // print(difficultyData.name);
    // setState(() {
    //   _btnController.stop();
    // });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: payeData,))),
                              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                              Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: bookData,))),
                              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                              Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: chapterData,)))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: kindData,))),
                              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                              Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: difficultyData,))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          // RaisedButton(
                          //   child: Text("asdfads"),
                          //   onPressed: submit,
                          // )

                          RoundedLoadingButton(
                            height: 30,
                            child: Text('جستجو',style: TextStyle(color: Colors.white),),
                            //  borderRadius: 0,
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
                      itemCount: (questionList.length == 0)? 0:1,
                      itemBuilder: (BuildContext context, int index)
                      {
                        if(questionList[index].kind == "جایخالی") return AnswerString(question: questionList[index]);
                        else if (questionList[index].kind == "تشریحی") return AnswerString(question: questionList[index],);
                        else if (questionList[index].kind == "تستی") return TestView(question: questionList[index],);
                        else if (questionList[index].kind == "چند گزینه ای") return MultiOptionView(question: questionList[index],);
                        else return Container();
                      }
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,//totalpage,
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
                            child: Text("$indexplus",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
                          ),
                        );
                      }
                  ),
                ),
                // MultiOptionView(question: newQuestion2,),
                // TestView(question: newQuestion3,),
                // AnswerString(question: newQuestion,),
                // AnswerString(question: newQuestion4,),
              ],
            ),
          ),
        ),
    );

  }
}

class TestView extends StatefulWidget {
  Question question;
  TestView({Key key, this.question}) : super(key: key);
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
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
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.question.paye),
                  Text(widget.question.book),
                  Text(widget.question.chapter),
                  Text(widget.question.kind),
                  Text(widget.question.difficulty),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text(widget.question.text,textDirection: TextDirection.rtl)),
                  (widget.question.questinImage != null) ? Text(widget.question.questinImage) : Container(),
                ],
              ),
            ),
            Padding(
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
            ),
            FlatButton(
              color: Color(0xFF3D5A80),
              onPressed: viewTestAnswer,
              child: Text("دیدن پاسخ"),
              textColor: Colors.white,
            ),
            // RoundedLoadingButton(
            //   color: Color(0xFF3D5A80),
            //   child: Text("دیدن پاسخ"),
            //   onPressed: viewTestAnswer,
            // )
            // RaisedButton(
            //     textColor: Colors.white,
            //     //color: Colors.lightBlue,
            //     child: Text("دیدن پاسخ"),
            //     onPressed: viewTestAnswer)

          ],
        ),
      ),
    );
  }
}


class MultiOptionView extends StatefulWidget {
  Question question;
  MultiOptionView({Key key, this.question}) : super(key: key);
  @override
  _MultiOptionViewState createState() => _MultiOptionViewState();
}

class _MultiOptionViewState extends State<MultiOptionView> {
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.question.paye),
                  Text(widget.question.book),
                  Text(widget.question.chapter),
                  Text(widget.question.kind),
                  Text(widget.question.difficulty),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text(widget.question.text,textDirection: TextDirection.rtl)),
                  (widget.question.questinImage != null) ? Text(widget.question.questinImage) : Container(),
                ],
              ),
            ),
            Padding(
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
            ),
            FlatButton(
              color: Color(0xFF3D5A80),
              onPressed: viewMultiOptionAnswer,
              child: Text("دیدن پاسخ"),
              textColor: Colors.white,
            ),
            // RaisedButton(
            //     textColor: Colors.white,
            //     //color: Colors.lightBlue,
            //     child: Text("دیدن پاسخ"),
            //     onPressed: viewMultiOptionAnswer)
          ],
        ),
      ),
    );
  }
}


class AnswerString extends StatefulWidget {
  Question question;
  AnswerString({Key key, this.question}) : super(key: key);
  @override
  _AnswerStringState createState() => _AnswerStringState();
}

class _AnswerStringState extends State<AnswerString> {
  bool viewAnswerbool = false;
  void viewAnswer(bool viewAnswer)
  {
    setState(() {
      (viewAnswer) ? viewAnswerbool = false : viewAnswerbool = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.question.paye),
                  Text(widget.question.book),
                  Text(widget.question.chapter),
                  Text(widget.question.kind),
                  Text(widget.question.difficulty),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text("سوال : " + widget.question.text,textDirection: TextDirection.rtl)),
                  (widget.question.questinImage != null) ? Text(widget.question.questinImage) : Container(),
                ],
              ),
            ),
            (viewAnswerbool) ? Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text("جواب : "+ widget.question.answerString,textDirection: TextDirection.rtl)),
                  (widget.question.questinImage != null) ? Text(widget.question.questinImage) : Container(),
                ],
              ),
            ):Container(),
            FlatButton(
              onPressed: () => viewAnswer(viewAnswerbool),
              child: Text("دیدن پاسخ"),
              textColor: Colors.white,
              color: Color(0xFF3D5A80),
            )
            // RaisedButton(
            //     textColor: Colors.white,
            //     //color: Colors.lightBlue,
            //     child: Text("دیدن پاسخ"),
            //     onPressed: () => viewAnswer(viewAnswerbool))
          ],
        ),
      ),
    );
  }
}

