import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/widgets/popumMenu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';

class AddQuestionPage extends StatefulWidget {
  AddQuestionPage({Key key}) : super(key: key);
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  Question newQuestion = new Question();

  TextEditingController QuestionTextController = new TextEditingController();
  TextEditingController TashrihiTextController = new TextEditingController();
  TextEditingController BlankTextController = new TextEditingController();
  TextEditingController TestText1Controller = new TextEditingController();
  TextEditingController TestText2Controller = new TextEditingController();
  TextEditingController TestText3Controller = new TextEditingController();
  TextEditingController TestText4Controller = new TextEditingController();
  TextEditingController MultiOptionText1Controller = new TextEditingController();
  TextEditingController MultiOptionText2Controller = new TextEditingController();
  TextEditingController MultiOptionText3Controller = new TextEditingController();
  TextEditingController MultiOptionText4Controller = new TextEditingController();

  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  List<String> payelist = [];
  popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = [];
  popupMenuData chapterData = new popupMenuData("فصل");
  List<String> chapterlist = [];
  popupMenuData kindData = new popupMenuData("نوع سوال");
  List<String> kindlist = [];
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = [];

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  bool focusOnMultiOption4 = true;

  void _focusChangeOnMultiOption4(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnMultiOption4 = true;
      });
    } else {
      setState(() {
        focusOnMultiOption4 = false;
      });
    }
  }

  bool focusOnMultiOption3 = true;

  void _focusChangeOnMultiOption3(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnMultiOption3 = true;
      });
    } else {
      setState(() {
        focusOnMultiOption3 = false;
      });
    }
  }

  bool focusOnMultiOption2 = true;

  void _focusChangeOnMultiOption2(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnMultiOption2 = true;
      });
    } else {
      setState(() {
        focusOnMultiOption2 = false;
      });
    }
  }

  bool focusOnMultiOption1 = true;

  void _focusChangeOnMultiOption1(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnMultiOption1 = true;
      });
    } else {
      setState(() {
        focusOnMultiOption1 = false;
      });
    }
  }

  bool focusOnTest4 = true;

  void _focusChangeOnTest4(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnTest4 = true;
      });
    } else {
      setState(() {
        focusOnTest4 = false;
      });
    }
  }

  bool focusOnTest3 = true;

  void _focusChangeOnTest3(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnTest3 = true;
      });
    } else {
      setState(() {
        focusOnTest3 = false;
      });
    }
  }

  bool focusOnTest2 = true;

  void _focusChangeOnTest2(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnTest2 = true;
      });
    } else {
      setState(() {
        focusOnTest2 = false;
      });
    }
  }

  bool focusOnTest1 = true;

  void _focusChangeOnTest1(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnTest1 = true;
      });
    } else {
      setState(() {
        focusOnTest1 = false;
      });
    }
  }

  bool focusOnBlank = true;

  void _focusChangeOnBlank(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnBlank = true;
      });
    } else {
      setState(() {
        focusOnBlank = false;
      });
    }
  }

  bool focusOnTashrihi = true;

  void _focusChangeOnTashrihi(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnTashrihi = true;
      });
    } else {
      setState(() {
        focusOnTashrihi = false;
      });
    }
  }

  bool focusOnQuestionText = true;

  void _focusChangeOnQuestionText(bool isChange) {
    if (isChange) {
      setState(() {
        focusOnQuestionText = true;
      });
    } else {
      setState(() {
        focusOnQuestionText = false;
      });
    }
  }

  Widget tashrihiWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Text(
                        "پاسخ سوال",
                        textDirection: TextDirection.rtl,
                      ),
                      IconButton(
                        icon: Icon(Icons.camera),
                        onPressed: getAnswerImage,
                        tooltip: "می توان فقط عکس هم فرستاد",
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: InkWell(
                  child: (focusOnTashrihi)
                      ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TashrihiTextController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        )
                      : TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TashrihiTextController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                  onFocusChange: (value) => _focusChangeOnTashrihi(value),
                )),
              ],
            ),
            (_AnswerImage != null)
                ? Container(
                    child: InkWell(
                        onTap: () => _deleteAnswerImage(),
                        child: Image.file(_AnswerImage, fit: BoxFit.cover)),
                    height: 200,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.0),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget blankWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              "پاسخ سوال",
              textDirection: TextDirection.rtl,
            ),
            Expanded(
              child: InkWell(
                child: (focusOnBlank)
                    ? TextFormField(
                        textDirection: TextDirection.rtl,
                        controller: BlankTextController,
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      )
                    : TextFormField(
                        textDirection: TextDirection.rtl,
                        controller: BlankTextController,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                onFocusChange: (value) => _focusChangeOnBlank(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _radioGroupValue = 0;

  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
    });
  }

  Widget testWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(
                      value: 1,
                      groupValue: _radioGroupValue,
                      onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                      child: InkWell(
                    child: (focusOnTest1)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText1Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText1Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnTest1(value),
                  ))
                ],
              ),
            ),
            // Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(
                      value: 2,
                      groupValue: _radioGroupValue,
                      onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                      child: InkWell(
                    child: (focusOnTest2)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText2Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText2Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnTest2(value),
                  ))
                ],
              ),
            ),
            //  Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(
                      value: 3,
                      groupValue: _radioGroupValue,
                      onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                      child: InkWell(
                    child: (focusOnTest3)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText3Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText3Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnTest3(value),
                  ))
                ],
              ),
            ),
            //  Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(
                      value: 4,
                      groupValue: _radioGroupValue,
                      onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                      child: InkWell(
                    child: (focusOnTest4)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText4Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: TestText4Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnTest4(value),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget multiOption() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(value: optionOne, onChanged: optionOneChange),
                  Expanded(
                      child: InkWell(
                    child: (focusOnMultiOption1)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText1Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText1Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnMultiOption1(value),
                  ))
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
                      child: InkWell(
                    child: (focusOnMultiOption2)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText2Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText2Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnMultiOption2(value),
                  ))
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
                      child: InkWell(
                    child: (focusOnMultiOption3)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText3Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText3Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnMultiOption3(value),
                  ))
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
                      child: InkWell(
                    child: (focusOnMultiOption4)
                        ? TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText4Controller,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )
                        : TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: MultiOptionText4Controller,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                    onFocusChange: (value) => _focusChangeOnMultiOption4(value),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void FillLists()
  {
    HomePage.maps.SPayeMap.forEach((k,v) => payelist.add(v.toString()));
    HomePage.maps.SBookMap.forEach((k,v) => booklist.add(v.toString()));
    HomePage.maps.SChapterMap.forEach((k,v) => chapterlist.add(v.toString()));
    HomePage.maps.SKindMap.forEach((k,v) => kindlist.add(v.toString()));
    HomePage.maps.SDifficultyMap.forEach((k,v) => difficultylist.add(v.toString()));

    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(chapterlist);
    kindData.fillStringList(kindlist);
    difficultyData.fillStringList(difficultylist);

    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    FillLists();
  }

  void _deleteQuestionImage() {
    setState(() {
      _QuestionImage = null;
    });
  }

  void _deleteAnswerImage() {
    setState(() {
      _AnswerImage = null;
    });
  }

  File _QuestionImage;
  File _AnswerImage;

  final picker = ImagePicker();

  void getQuestionImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _QuestionImage = File(pickedFile.path);
      }
    });
  }

  void getAnswerImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _AnswerImage = File(pickedFile.path);
      }
    });
  }

  void submit() async {
    newQuestion.text = QuestionTextController.text;
    newQuestion.paye = payeData.name;
    newQuestion.book = bookData.name;
    newQuestion.chapter = chapterData.name;
    newQuestion.difficulty = difficultyData.name;
    newQuestion.kind = kindData.name;
    newQuestion.isPublic = addQuestionBankOption;

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
    if (_QuestionImage != null)
    {
      newQuestion.questionImage = base64Encode(_QuestionImage.readAsBytesSync());
    }
    if(_AnswerImage != null)
    {
      newQuestion.answerImage = base64Encode(_AnswerImage.readAsBytesSync());
    }
    if (newQuestion.kind == HomePage.maps.SKindMap["TEST"]) {
      newQuestion.optionOne = TestText1Controller.text;
      newQuestion.optionTwo = TestText2Controller.text;
      newQuestion.optionThree = TestText3Controller.text;
      newQuestion.optionFour = TestText4Controller.text;
      newQuestion.numberOne = _radioGroupValue;
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
      //print(data);
      final response = await http.post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data);
      if (response.statusCode == 200) {
        ShowCorrectnessDialog(true, context);
        print("Question Created in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      } else {
        ShowCorrectnessDialog(false, context);
        print("Question failed in test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      }
    } else if (newQuestion.kind == HomePage.maps.SKindMap["SHORTANSWER"]) {
      newQuestion.answerString = BlankTextController.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion,ServerKind);

      data = jsonEncode(<String, dynamic>{
        "type": ServerKind,
        if(newQuestion.questionImage != null) "imageQuestion" : newQuestion.questionImage,
        "public": qs.public,
        "question": qs.question,
        "answers": qs.answer,
        "base": ServerPaye,
        "hardness": ServerDifficulty,
        "course": ServerBook,
        "chapter": ServerChapter,
      });
      //print(data);
      final response = await http.post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data);
      if (response.statusCode == 200) {
        ShowCorrectnessDialog(true, context);
        print("Question Created in jayekhali");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      } else {
        ShowCorrectnessDialog(false, context);
        print("Question failed in jayekhali");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      }
    } else if (newQuestion.kind == HomePage.maps.SKindMap["MULTICHOISE"]) {
      newQuestion.optionOne = MultiOptionText1Controller.text;
      newQuestion.optionTwo = MultiOptionText2Controller.text;
      newQuestion.optionThree = MultiOptionText3Controller.text;
      newQuestion.optionFour = MultiOptionText4Controller.text;
      newQuestion.numberOne = (optionOne) ? 1 : 0;
      newQuestion.numberTwo = (optionTwo) ? 1 : 0;
      newQuestion.numberThree = (optionThree) ? 1 : 0;
      newQuestion.numberFour = (optionFour) ? 1 : 0;

      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion,ServerKind);
      data = jsonEncode(<String, dynamic>{
        "type": ServerKind,
        if(newQuestion.questionImage != null) "imageQuestion" : newQuestion.questionImage,
        "public": qs.public,
        "question": qs.question,
        "answers": qs.answer,
        "base": ServerPaye,
        "hardness": ServerDifficulty,
        "course": ServerBook,
        "options": qs.options,
        "chapter": ServerChapter,
      });
      //print(data);
      final response = await http.post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data);
      if (response.statusCode == 200) {
        ShowCorrectnessDialog(true, context);
        print("Question Created in multiChoice");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      } else {
        ShowCorrectnessDialog(false, context);
        print("Question failed in multiChoice");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      }
    } else if (newQuestion.kind == HomePage.maps.SKindMap["LONGANSWER"]) {
      newQuestion.answerString = TashrihiTextController.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion,ServerKind);
      data = jsonEncode(<String, dynamic>{
        "type": ServerKind,
        if(newQuestion.questionImage != null) "imageQuestion" : newQuestion.questionImage,
        if(newQuestion.answerImage != null) "imageAnswer" : newQuestion.answerImage,
        "public": qs.public,
        "question": qs.question,
        "answers": qs.answer,
        "base": ServerPaye,
        "hardness": ServerDifficulty,
        "course": ServerBook,
        "chapter": ServerChapter,
      });
      print(data);
      final response = await http.post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data);
      if (response.statusCode == 200) {
        ShowCorrectnessDialog(true, context);
        print("Question Created in tashrihi");
        _btnController.stop();
      } else {
        ShowCorrectnessDialog(false, context);
        print("Question failed in tashrihi");
        _btnController.stop();
      }
    }
  }

  bool addQuestionBankOption = false;

  void addQuestionBankOptionChange(bool newValue) {
    setState(() {
      addQuestionBankOption = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "متن سوال",
                                      textDirection: TextDirection.rtl,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.camera),
                                      onPressed: getQuestionImage,
                                      tooltip: "می توان فقط عکس هم فرستاد",
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: InkWell(
                                child: (focusOnQuestionText)
                                    ? TextFormField(
                                        autofocus: true,
                                        textDirection: TextDirection.rtl,
                                        controller: QuestionTextController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      )
                                    : TextFormField(
                                        textDirection: TextDirection.rtl,
                                        controller: QuestionTextController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                onFocusChange: (value) =>
                                    _focusChangeOnQuestionText(value),
                              )),
                            ],
                          ),
                          (_QuestionImage != null)
                              ? Container(
                                  child: InkWell(
                                      onTap: () => _deleteQuestionImage(),
                                      child: Image.file(_QuestionImage,
                                          fit: BoxFit.cover)),
                                  height: 200,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8.0),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  //TextFormField(),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: (payelist.length == 0) ? Text(payeData.popupMenuBottonName,textDirection: TextDirection.rtl,) : PopupMenu(Data: payeData,))),
                                SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: (booklist.length == 0) ? Text(bookData.popupMenuBottonName,textDirection: TextDirection.rtl,) : PopupMenu(Data: bookData,))),
                                SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: (chapterlist.length == 0) ? Text(chapterData.popupMenuBottonName,textDirection: TextDirection.rtl,) : PopupMenu(Data: chapterData,))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: (kindlist.length == 0) ? Text(kindData.popupMenuBottonName,textDirection: TextDirection.rtl,) :PopupMenu(Data: kindData,))),
                                SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: (difficultylist.length == 0) ? Text(difficultyData.popupMenuBottonName,textDirection: TextDirection.rtl,) :PopupMenu(Data: difficultyData,))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (kindData.name == HomePage.maps.SKindMap["TEST"])
                    testWidget()
                  else if (kindData.name == HomePage.maps.SKindMap["SHORTANSWER"])
                    blankWidget()
                  else if (kindData.name == HomePage.maps.SKindMap["MULTICHOISE"])
                    multiOption()
                  else if (kindData.name == HomePage.maps.SKindMap["LONGANSWER"])
                    tashrihiWidget(),

                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(
                          value: addQuestionBankOption,
                          onChanged: addQuestionBankOptionChange),
                      Text(
                        "افزودن به بانک سوال",
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        RoundedLoadingButton(
                          height: 40,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ایجاد سوال', style: TextStyle(color: Colors.white),),
                              Icon(Icons.create,color: Colors.white,),
                            ],
                          ),
                      controller: _btnController,
                      color: Color(0xFF3D5A80),
                      onPressed: () => submit(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}