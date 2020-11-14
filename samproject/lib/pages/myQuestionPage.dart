import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:samproject/widgets/popumMenu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyQuestionPage extends StatefulWidget {
  @override
  _MyQuestionPageState createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  // Question newQuestion = new Question();
  // Question newQuestion2 = new Question();
  // Question newQuestion3 = new Question();
  // Question newQuestion4 = new Question();

  List<Question> questionList = [];
  int totalpage = 0;
  int thispage = 1;

  void getMyQuestion() async
  {
    final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token");

    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyMTgwNzF9.wS8GHC67ZBswQjEisWkMgot3_r92PnRyvN5WlMmhG34";
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;

    var headers = {
      'accept': 'application/json',
      'Authorization': tokenplus,
    };

    var params = {
      'page': thispage.toString(),
      'limit': '2',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var response = await http.get('https://parham-backend.herokuapp.com/question?$query', headers: headers);
    questionList = [];
    if (response.statusCode == 200)
    {
      print("ok");
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
        qs.answer = responseJson["questions"][i]["answers"].toString();
        qs.options = responseJson["questions"][i]["options"];
        qs.public = responseJson["questions"][i]["public"].toString();
        qs.id = responseJson["questions"][i]["_id"];

        // print(qs.type);
        // print(qs.public);
        // print(qs.question);
        // //print(qs.answer);
        // print(qs.base);
        // print(qs.hardness);
        // print(qs.course);
        // print("---");
        Question q = Question.QuestionServerToQuestion(qs);
        // print(q.kind);
        // print(q.isPublic);
        // print(q.text);
        // //print(qs.answer);
        // print(q.paye);
        // print(q.difficulty);
        // print(q.book);
        questionList.add(q);
      }
      // for (int i=0;i<questionList.length;i++)
      // {
      //   print(questionList[i].text);
      // }
      setState(() {

      });
    }
    else
      {
        print("nokey");
      }

  }
  @override
  void initState() {
    super.initState();
    getMyQuestion();

    //
    // newQuestion.paye = "دهم";
    // newQuestion.book = "فیزیک";
    // newQuestion.chapter = "چهارم";
    // newQuestion.kind = "تشریحی";
    // newQuestion.difficulty = "سخت";
    // newQuestion.text = "هر میکرو معادل با 10 به توان چند است؟";
    // //newQuestion.questionImage = "عکس سوال";
    // newQuestion.answerString = "منهای شش";
    // //newQuestion.image2 = "عکس پاسخ";
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
    //
    // newQuestion4.paye = "دهم";
    // newQuestion4.book = "فیزیک";
    // newQuestion4.chapter = "چهارم";
    // newQuestion4.kind = "جایخالی";
    // newQuestion4.difficulty = "سخت";
    // newQuestion4.text = "هر میکرو معادل با 10 به توان چند است؟";
    // newQuestion4.questinImage = "عکس سوال";
    // newQuestion4.answerString = "منهای شش";
  }

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
          child: //AnswerStringCard(question: questionList[0],)
          Column(
            children: [
              Flexible(
                flex: 11,
                child: ListView.builder(
                  itemCount: questionList.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    if(questionList[index].kind == "جایخالی") return AnswerStringCard(question: questionList[index]);
                    else if (questionList[index].kind == "تشریحی") return AnswerStringCard(question: questionList[index],);
                    else if (questionList[index].kind == "تستی") return TestCard(question: questionList[index],);
                    else if (questionList[index].kind == "چند گزینه ای") return MultiOptionCard(question: questionList[index],);
                    else return Container();
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
                       // width: 20,
                       // height: 20,
                        color: Color(0xFF3D5A80),
                        child: Text("$indexplus",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
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

class MultiOptionCard extends StatefulWidget {
  Question question;
 // bool IsEditing;
  MultiOptionCard({Key key, this.question}) : super(key: key);
  @override
  _MultiOptionCardState createState() => _MultiOptionCardState();
}

class _MultiOptionCardState extends State<MultiOptionCard> {
  bool IsDelete = false;
  bool IsEditing = false;
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
  void onEditButton() async
  {
    if (IsEditing == true)
    {
      final prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token");
      String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyNTk1OTR9.TyJbkffE4_lqj2CUEKoBbI7kapvtBl0OI8VvfVkF6uk";
      if (token == null) {return;}
      String tokenplus = "Bearer" + " " + token;
      Question temporaryQuestion = new Question();
      temporaryQuestion.paye = payeData.name;
      temporaryQuestion.book = bookData.name;
      temporaryQuestion.chapter = chapterData.name;
      temporaryQuestion.kind = kindData.name;
      temporaryQuestion.difficulty = difficultyData.name;

      temporaryQuestion.isPublic = addQuestionBankOption;
      temporaryQuestion.id = widget.question.id;

      temporaryQuestion.text = QuestionTextController.text;
      temporaryQuestion.optionOne =  MultiOptionText1Controller.text;
      temporaryQuestion.optionTwo = MultiOptionText2Controller.text;
      temporaryQuestion.optionThree = MultiOptionText3Controller.text;
      temporaryQuestion.optionFour = MultiOptionText4Controller.text;

      temporaryQuestion.numberOne = (optionOne) ? 1 : 0;
      temporaryQuestion.numberTwo = (optionTwo) ? 1 : 0;
      temporaryQuestion.numberThree = (optionThree) ? 1 : 0;
      temporaryQuestion.numberFour = (optionFour) ? 1 : 0;

      QuestionServer qs = QuestionServer.QuestionToQuestionServer(temporaryQuestion);

      dynamic data = jsonEncode(<String,dynamic>{
        "questionId":qs.id,
        "type": qs.type,
        "public": qs.public,
        "question": qs.question,
        "answer": qs.answer.toString(),
        "base": qs.base,
        "hardness" : qs.hardness,
        "course": qs.course,
        "options" : qs.options.toString(),
        "chapter" : qs.chapter,
      });
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
        print("Question Created in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());

        widget.question.paye = payeData.name;
        widget.question.book = bookData.name;
        widget.question.chapter = chapterData.name;
        widget.question.kind = kindData.name;
        widget.question.difficulty = difficultyData.name;

        widget.question.text = QuestionTextController.text;
        widget.question.optionOne = MultiOptionText1Controller.text;
        widget.question.optionTwo = MultiOptionText2Controller.text;
        widget.question.optionThree = MultiOptionText3Controller.text;
        widget.question.optionFour = MultiOptionText4Controller.text;

        widget.question.numberOne = (optionOne) ? 1 : 0;
        widget.question.numberTwo = (optionTwo) ? 1 : 0;
        widget.question.numberThree = (optionThree) ? 1 : 0;
        widget.question.numberFour = (optionFour) ? 1 : 0;

        //  _btnController.stop();
        //final responseJson = jsonDecode(response.body);
        //HomePage.user.avatarUrl = responseJson['user']['avatar'];
        //_showMyDialog(true);
        //_btnController.stop();
      }
      else{
        print("Question failed in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        ShowCorrectnessDialog(false,context);
        //  _btnController.stop();
        //_showMyDialog(false);
        //_btnController.stop();
      }

      setState(() {
        IsEditing = false;
      });
    }
    else
      {
        setState(() {
          IsEditing = true;
        });
      }
  }
  void onCloseButton() async
  {
    final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token");
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyNTk1OTR9.TyJbkffE4_lqj2CUEKoBbI7kapvtBl0OI8VvfVkF6uk";
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;
    print(widget.question.id);
    final response = await http.delete('https://parham-backend.herokuapp.com/question',
      headers: {
        'accept': 'application/json',
        'Authorization': tokenplus,
        'Content-Type': 'application/json',
        'questionId' : widget.question.id,
      },

    );
    if (response.statusCode == 200){
      ShowCorrectnessDialog(true,context);
      print("Question Created in test");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      setState(() {
        IsDelete = true;
      });
      //  _btnController.stop();
      //final responseJson = jsonDecode(response.body);
      //HomePage.user.avatarUrl = responseJson['user']['avatar'];
      //_showMyDialog(true);
      //_btnController.stop();
    }
    else{
      print("Question failed in test");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      ShowCorrectnessDialog(false,context);
      setState(() {
        IsDelete = false;
      });
      //  _btnController.stop();
      //_showMyDialog(false);
      //_btnController.stop();
    }
  }


  Widget notEditingCard()
  {
    return Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Checkbox(value: (widget.question.numberOne == 1) ? true: false, onChanged: null),
                  Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(value: (widget.question.numberTwo == 1) ? true: false, onChanged: null),
                  Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(value: (widget.question.numberThree == 1) ? true: false, onChanged: null),
                  Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(value: (widget.question.numberFour == 1) ? true: false, onChanged: null),
                  Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

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

  File _QuestionImage;
  final picker = ImagePicker();
  void getQuestionImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        _QuestionImage = File(pickedFile.path);
      }
    });
  }
  void _deleteQuestionImage()
  {
    setState(() {
      _QuestionImage = null;
    });
  }

  TextEditingController QuestionTextController = new TextEditingController();
  TextEditingController MultiOptionText1Controller = new TextEditingController();
  TextEditingController MultiOptionText2Controller = new TextEditingController();
  TextEditingController MultiOptionText3Controller = new TextEditingController();
  TextEditingController MultiOptionText4Controller = new TextEditingController();

  bool addQuestionBankOption = false;
  void addQuestionBankOptionChange(bool newValue) {
    setState(() {
      addQuestionBankOption = newValue;
    });
  }

  Widget EditingCard()
  {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: payeData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: bookData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: chapterData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: kindData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: difficultyData,))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text("متن سوال",textDirection: TextDirection.rtl,),
                    IconButton(icon: Icon(Icons.camera),onPressed: getQuestionImage,tooltip: "می توان فقط عکس هم فرستاد",)
                  ],
                ),
              ),
              Expanded(
                  child: TextFormField(
                    autofocus: true,
                    textDirection: TextDirection.rtl,
                    controller: QuestionTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              ),
            ],
          ),
        ),
        (_QuestionImage != null) ? Container(child: InkWell(onTap:() => _deleteQuestionImage(),child: Image.file(_QuestionImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
            : Container(),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionOne, onChanged: optionOneChange),
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: MultiOptionText1Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionTwo, onChanged: optionTwoChange),
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: MultiOptionText2Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionThree, onChanged: optionThreeChange),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: MultiOptionText3Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionFour, onChanged: optionFourChange),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: MultiOptionText4Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Checkbox(value: addQuestionBankOption, onChanged: addQuestionBankOptionChange),
            Text("افزودن به بانک سوال",textDirection: TextDirection.rtl,),
          ],
        ),
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    (widget.question.numberOne == 1) ? optionOne = true : optionOne = false;
    (widget.question.numberTwo == 1) ? optionTwo = true : optionTwo = false;
    (widget.question.numberThree == 1) ? optionThree = true : optionThree = false;
    (widget.question.numberFour == 1) ? optionFour = true : optionFour = false;

    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(cahpterlist);
    kindData.fillStringList(kindlist);
    difficultyData.fillStringList(difficultylist);

    payeData.name = widget.question.paye;
    bookData.name = widget.question.book;
    chapterData.name = widget.question.chapter;
    kindData.name = widget.question.kind;
    difficultyData.name = widget.question.difficulty;

    QuestionTextController.text = widget.question.text;
    MultiOptionText1Controller.text = widget.question.optionOne;
    MultiOptionText2Controller.text = widget.question.optionTwo;
    MultiOptionText3Controller.text = widget.question.optionThree;
    MultiOptionText4Controller.text = widget.question.optionFour;

  }
  @override
  Widget build(BuildContext context) {
    return (IsDelete == false) ? Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            (IsEditing == false) ? notEditingCard() : EditingCard(),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  color: Color(0xFF3D5A80),
                  onPressed: onEditButton,
                  child: Text("ويرايش"),
                  textColor: Colors.white,
                ),
                FlatButton(
                  color: Color(0xFF3D5A80),
                  onPressed: onCloseButton,
                  child: Text("حذف"),
                  textColor: Colors.white,
                ),
              ],
            )
          ],
        )
      ),
    ) : Container();
  }
}

class TestCard extends StatefulWidget {
  Question question;
  TestCard({Key key, this.question}) : super(key: key);
  @override
  _TestCardState createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {

  bool IsEditing = false;
  bool IsDelete = false;

  TextEditingController QuestionTextController = new TextEditingController();
  TextEditingController TestText1Controller = new TextEditingController();
  TextEditingController TestText2Controller = new TextEditingController();
  TextEditingController TestText3Controller = new TextEditingController();
  TextEditingController TestText4Controller = new TextEditingController();

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

  File _QuestionImage;
  final picker = ImagePicker();
  void getQuestionImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        _QuestionImage = File(pickedFile.path);
      }
    });
  }
  void _deleteQuestionImage()
  {
    setState(() {
      _QuestionImage = null;
    });
  }

  void onEditButton() async
  {
    if (IsEditing == true)
    {
      final prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token");
      String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyNTk1OTR9.TyJbkffE4_lqj2CUEKoBbI7kapvtBl0OI8VvfVkF6uk";
      if (token == null) {return;}
      String tokenplus = "Bearer" + " " + token;
      // print(widget.question.id);
      Question temporaryQuestion = new Question();
      temporaryQuestion.paye = payeData.name;
      temporaryQuestion.book = bookData.name;
      temporaryQuestion.chapter = chapterData.name;
      temporaryQuestion.kind = kindData.name;
      temporaryQuestion.difficulty = difficultyData.name;

      temporaryQuestion.isPublic = addQuestionBankOption;
      temporaryQuestion.id = widget.question.id;

      temporaryQuestion.text = QuestionTextController.text;
      temporaryQuestion.optionOne = TestText1Controller.text;
      temporaryQuestion.optionTwo = TestText2Controller.text;
      temporaryQuestion.optionThree = TestText3Controller.text;
      temporaryQuestion.optionFour = TestText4Controller.text;

      temporaryQuestion.numberOne = _radioGroupValue;

      QuestionServer qs = QuestionServer.QuestionToQuestionServer(temporaryQuestion);

      dynamic data = jsonEncode(<String,dynamic>{
        "questionId":qs.id,
        "type": qs.type,
        "public": qs.public,
        "question": qs.question,
        "answer": qs.answer.toString(),
        "base": qs.base,
        "hardness" : qs.hardness,
        "course": qs.course,
        "options" : qs.options.toString(),
        "chapter" : qs.chapter,
      });
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
        print("Question Created in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());

        widget.question.paye = payeData.name;
        widget.question.book = bookData.name;
        widget.question.chapter = chapterData.name;
        widget.question.kind = kindData.name;
        widget.question.difficulty = difficultyData.name;

        widget.question.text = QuestionTextController.text;
        widget.question.optionOne = TestText1Controller.text;
        widget.question.optionTwo = TestText2Controller.text;
        widget.question.optionThree = TestText3Controller.text;
        widget.question.optionFour = TestText4Controller.text;

        widget.question.numberOne = _radioGroupValue;

        //  _btnController.stop();
        //final responseJson = jsonDecode(response.body);
        //HomePage.user.avatarUrl = responseJson['user']['avatar'];
        //_showMyDialog(true);
        //_btnController.stop();
      }
      else{
        print("Question failed in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        ShowCorrectnessDialog(false,context);
        //  _btnController.stop();
        //_showMyDialog(false);
        //_btnController.stop();
      }

      setState(() {
        IsEditing = false;
      });
    }
    else
    {
      setState(() {
        IsEditing = true;
      });
    }
  }
  void onCloseButton() async
  {
    final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token");
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyNTk1OTR9.TyJbkffE4_lqj2CUEKoBbI7kapvtBl0OI8VvfVkF6uk";
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;
    print(widget.question.id);
    final response = await http.delete('https://parham-backend.herokuapp.com/question',
      headers: {
        'accept': 'application/json',
        'Authorization': tokenplus,
        'Content-Type': 'application/json',
        'questionId' : widget.question.id,
      },

    );
    if (response.statusCode == 200){
      ShowCorrectnessDialog(true,context);
      print("Question Created in test");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      setState(() {
        IsDelete = true;
      });
      //  _btnController.stop();
      //final responseJson = jsonDecode(response.body);
      //HomePage.user.avatarUrl = responseJson['user']['avatar'];
      //_showMyDialog(true);
      //_btnController.stop();
    }
    else{
      print("Question failed in test");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      ShowCorrectnessDialog(false,context);
      setState(() {
        IsDelete = false;
      });
      //  _btnController.stop();
      //_showMyDialog(false);
      //_btnController.stop();
    }
  }

  int _radioGroupValue = 0;
  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
    });
  }

  Widget notEditingCard()
  {
    return Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Radio(visualDensity: VisualDensity.compact,value: 1, groupValue: _radioGroupValue, onChanged: null),
                  Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(visualDensity: VisualDensity.compact,value: 2, groupValue: _radioGroupValue, onChanged: null),
                  Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(visualDensity: VisualDensity.compact,value: 3, groupValue: _radioGroupValue, onChanged: null),
                  Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(visualDensity: VisualDensity.compact,value: 4, groupValue: _radioGroupValue, onChanged: null),
                  Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool addQuestionBankOption = false;
  void addQuestionBankOptionChange(bool newValue) {
    setState(() {
      addQuestionBankOption = newValue;
    });
  }

  Widget EditingCard()
  {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: payeData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: bookData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: chapterData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: kindData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: difficultyData,))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text("متن سوال",textDirection: TextDirection.rtl,),
                    IconButton(icon: Icon(Icons.camera),onPressed: getQuestionImage,tooltip: "می توان فقط عکس هم فرستاد",)
                  ],
                ),
              ),
              Expanded(
                  child: TextFormField(
                    autofocus: true,
                    textDirection: TextDirection.rtl,
                    controller: QuestionTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              ),
            ],
          ),
        ),
        (_QuestionImage != null) ? Container(child: InkWell(onTap:() => _deleteQuestionImage(),child: Image.file(_QuestionImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
            : Container(),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 1, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: TestText1Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 2, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: TestText2Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 3, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: TestText3Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 4, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: TestText4Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Checkbox(value: addQuestionBankOption, onChanged: addQuestionBankOptionChange),
            Text("افزودن به بانک سوال",textDirection: TextDirection.rtl,),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _radioGroupValue = widget.question.numberOne;

    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(cahpterlist);
    kindData.fillStringList(kindlist);
    difficultyData.fillStringList(difficultylist);

    payeData.name = widget.question.paye;
    bookData.name = widget.question.book;
    chapterData.name = widget.question.chapter;
    kindData.name = widget.question.kind;
    difficultyData.name = widget.question.difficulty;

    QuestionTextController.text = widget.question.text;
    TestText1Controller.text = widget.question.optionOne;
    TestText2Controller.text = widget.question.optionTwo;
    TestText3Controller.text = widget.question.optionThree;
    TestText4Controller.text = widget.question.optionFour;

  }

  @override
  Widget build(BuildContext context) {
    return (IsDelete == false) ? Card(
      child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: [
              (IsEditing == false) ? notEditingCard() : EditingCard(),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    color: Color(0xFF3D5A80),
                    onPressed: onEditButton,
                    child: Text("ويرايش"),
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    color: Color(0xFF3D5A80),
                    onPressed: onCloseButton,
                    child: Text("حذف"),
                    textColor: Colors.white,
                  ),
                ],
              )
            ],
          )
      ),
    ) : Container();
  }
}
class AnswerStringCard extends StatefulWidget {
  Question question;
  AnswerStringCard({Key key, this.question}) : super(key: key);
  @override
  _AnswerStringCardState createState() => _AnswerStringCardState();
}

class _AnswerStringCardState extends State<AnswerStringCard> {

  bool IsEditing = false;
  bool IsDelete = false;

  TextEditingController QuestionTextController = new TextEditingController();
  TextEditingController TashrihiTextController = new TextEditingController();

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

  File _QuestionImage;
  File _AnswerImage;
  final picker = ImagePicker();
  void getQuestionImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        _QuestionImage = File(pickedFile.path);
      }
    });
  }
  void getAnswerImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        _AnswerImage = File(pickedFile.path);
      }
    });
  }
  void _deleteQuestionImage()
  {
    setState(() {
      _QuestionImage = null;
    });
  }
  void _deleteAnswerImage()
  {
    setState(() {
      _AnswerImage = null;
    });
  }

  void onEditButton() async
  {
    if (IsEditing == true)
    {
      final prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token");
      String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyNTk1OTR9.TyJbkffE4_lqj2CUEKoBbI7kapvtBl0OI8VvfVkF6uk";
      if (token == null) {return;}
      String tokenplus = "Bearer" + " " + token;
     // print(widget.question.id);
      Question temporaryQuestion = new Question();
      temporaryQuestion.paye = payeData.name;
      temporaryQuestion.book = bookData.name;
      temporaryQuestion.chapter = chapterData.name;
      temporaryQuestion.kind = kindData.name;
      temporaryQuestion.difficulty = difficultyData.name;

      temporaryQuestion.isPublic = addQuestionBankOption;
      temporaryQuestion.id = widget.question.id;

      temporaryQuestion.text = QuestionTextController.text;
      temporaryQuestion.answerString = TashrihiTextController.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(temporaryQuestion);

      dynamic data = jsonEncode(<String,dynamic>{
        "questionId":qs.id,
        "type": qs.type,
        "public": qs.public,
        "question": qs.question,
        "answer": qs.answer.toString(),
        "base": qs.base,
        "hardness" : qs.hardness,
        "course": qs.course,
        "chapter" : qs.chapter,
      });
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
        print("Question Created in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());

        widget.question.paye = payeData.name;
        widget.question.book = bookData.name;
        widget.question.chapter = chapterData.name;
        widget.question.kind = kindData.name;
        widget.question.difficulty = difficultyData.name;

        widget.question.isPublic = addQuestionBankOption;

        widget.question.text = QuestionTextController.text;
        widget.question.answerString = TashrihiTextController.text;

        //  _btnController.stop();
        //final responseJson = jsonDecode(response.body);
        //HomePage.user.avatarUrl = responseJson['user']['avatar'];
        //_showMyDialog(true);
        //_btnController.stop();
      }
      else{
        print("Question failed in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        ShowCorrectnessDialog(false,context);
        //  _btnController.stop();
        //_showMyDialog(false);
        //_btnController.stop();
      }

      setState(() {
        IsEditing = false;
      });
    }
    else
    {
      setState(() {
        IsEditing = true;
      });
    }
  }
  void onCloseButton() async
  {
    final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token");
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyNTk1OTR9.TyJbkffE4_lqj2CUEKoBbI7kapvtBl0OI8VvfVkF6uk";
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;
    print(widget.question.id);
    final response = await http.delete('https://parham-backend.herokuapp.com/question',
        headers: {
          'accept': 'application/json',
          'Authorization': tokenplus,
          'Content-Type': 'application/json',
          'questionId' : widget.question.id,
        },

    );
    if (response.statusCode == 200){
      ShowCorrectnessDialog(true,context);
      print("Question Created in test");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      setState(() {
        IsDelete = true;
      });
    //  _btnController.stop();
      //final responseJson = jsonDecode(response.body);
      //HomePage.user.avatarUrl = responseJson['user']['avatar'];
      //_showMyDialog(true);
      //_btnController.stop();
    }
    else{
      print("Question failed in test");
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      ShowCorrectnessDialog(false,context);
      setState(() {
        IsDelete = false;
      });
    //  _btnController.stop();
      //_showMyDialog(false);
      //_btnController.stop();
    }

  }

  Widget notEditingCard()
  {
    return Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Container(alignment: Alignment.centerRight,child: Text("سوال : "+widget.question.text,textDirection: TextDirection.rtl)),
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
              Container(alignment: Alignment.centerRight,child: Text("جواب : "+ widget.question.answerString,textDirection: TextDirection.rtl)),
              (widget.question.answerImage != null) ? Text(widget.question.answerImage) : Container(),
            ],
          ),
        ),
      ],
    );
  }

  bool addQuestionBankOption = false;
  void addQuestionBankOptionChange(bool newValue) {
    setState(() {
      addQuestionBankOption = newValue;
    });
  }
  Widget EditingCard()
  {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: payeData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: bookData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: chapterData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: kindData,))),
              Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: difficultyData,))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text("متن سوال",textDirection: TextDirection.rtl,),
                    IconButton(icon: Icon(Icons.camera),onPressed: getQuestionImage,tooltip: "می توان فقط عکس هم فرستاد",)
                  ],
                ),
              ),
              Expanded(
                  child: TextFormField(
                    autofocus: true,
                    textDirection: TextDirection.rtl,
                    controller: QuestionTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              ),
            ],
          ),
        ),
        (_QuestionImage != null) ? Container(child: InkWell(onTap:() => _deleteQuestionImage(),child: Image.file(_QuestionImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
            : Container(),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text("پاسخ سوال",textDirection: TextDirection.rtl,),
                  (widget.question.kind != "جایخالی") ? IconButton(icon: Icon(Icons.camera),onPressed: getAnswerImage,tooltip: "می توان فقط عکس هم فرستاد",): Container(),
                ],
              ),
            ),
            Expanded(
                child: (widget.question.kind != "جایخالی") ? TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: TashrihiTextController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
                    :Container(
                  padding: EdgeInsets.all(4.0),
                  width: 120,
                      child: TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: TashrihiTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                    )
            ),
          ],
        ),
        (_AnswerImage != null) ? Container(child: InkWell(onTap:() => _deleteAnswerImage(),child: Image.file(_AnswerImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
            : Container(),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Checkbox(value: addQuestionBankOption, onChanged: addQuestionBankOptionChange),
            Text("افزودن به بانک سوال",textDirection: TextDirection.rtl,),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(cahpterlist);
    kindData.fillStringList(kindlist);
    difficultyData.fillStringList(difficultylist);

    payeData.name = widget.question.paye;
    bookData.name = widget.question.book;
    chapterData.name = widget.question.chapter;
    kindData.name = widget.question.kind;
    difficultyData.name = widget.question.difficulty;

    QuestionTextController.text = widget.question.text;
    TashrihiTextController.text = widget.question.answerString;

    //print(widget.question.kind);

  }

  @override
  Widget build(BuildContext context) {
    return (IsDelete == false) ? Card(
      child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: [
              (IsEditing == false) ? notEditingCard() : EditingCard(),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    color: Color(0xFF3D5A80),
                    onPressed: onEditButton,
                    child: Text("ويرايش"),
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    color: Color(0xFF3D5A80),
                    onPressed: onCloseButton,
                    child: Text("حذف"),
                    textColor: Colors.white,
                  ),
                ],
              )
            ],
          )
      ),
    ) : Container();
  }
}
