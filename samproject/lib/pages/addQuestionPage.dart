import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/widgets/popumMenu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';

class AddQuestionPage extends StatefulWidget {
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
  List<String> payelist = ["دهم","یازدهم","دوازدهم"];
  popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = ["ریاضی","فیزیک","شیمی","زیست"];
  popupMenuData chapterData = new popupMenuData("فصل");
  List<String> cahpterlist = ["اول","دوم","سوم","چهارم","پنجم","ششم","هفتم","هشتم","نهم","دهم",];
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = ["آسان","متوسط","سخت"];

  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  bool focusOnMultiOption4 = true;
  void _focusChangeOnMultiOption4(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnMultiOption4 = true;
      });
    }
    else
    {
      setState(() {
        focusOnMultiOption4 = false;
      });
    }
  }

  bool focusOnMultiOption3 = true;
  void _focusChangeOnMultiOption3(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnMultiOption3 = true;
      });
    }
    else
    {
      setState(() {
        focusOnMultiOption3 = false;
      });
    }
  }

  bool focusOnMultiOption2 = true;
  void _focusChangeOnMultiOption2(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnMultiOption2 = true;
      });
    }
    else
    {
      setState(() {
        focusOnMultiOption2 = false;
      });
    }
  }

  bool focusOnMultiOption1 = true;
  void _focusChangeOnMultiOption1(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnMultiOption1 = true;
      });
    }
    else
    {
      setState(() {
        focusOnMultiOption1 = false;
      });
    }
  }

  bool focusOnTest4 = true;
  void _focusChangeOnTest4(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnTest4 = true;
      });
    }
    else
    {
      setState(() {
        focusOnTest4 = false;
      });
    }
  }

  bool focusOnTest3 = true;
  void _focusChangeOnTest3(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnTest3 = true;
      });
    }
    else
    {
      setState(() {
        focusOnTest3 = false;
      });
    }
  }


  bool focusOnTest2 = true;
  void _focusChangeOnTest2(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnTest2 = true;
      });
    }
    else
    {
      setState(() {
        focusOnTest2 = false;
      });
    }
  }

  bool focusOnTest1 = true;
  void _focusChangeOnTest1(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnTest1 = true;
      });
    }
    else
    {
      setState(() {
        focusOnTest1 = false;
      });
    }
  }

  bool focusOnBlank = true;
  void _focusChangeOnBlank(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnBlank = true;
      });
    }
    else
    {
      setState(() {
        focusOnBlank = false;
      });
    }
  }

  bool focusOnTashrihi = true;
  void _focusChangeOnTashrihi(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnTashrihi = true;
      });
    }
    else
      {
        setState(() {
          focusOnTashrihi = false;
        });
      }
  }

  bool focusOnQuestionText = true;
  void _focusChangeOnQuestionText(bool isChange)
  {
    if(isChange)
    {
      setState(() {
        focusOnQuestionText = true;
      });
    }
    else
    {
      setState(() {
        focusOnQuestionText = false;
      });
    }
  }
  Widget tashrihiWidget()
  {
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
                      Text("پاسخ سوال",textDirection: TextDirection.rtl,),
                      IconButton(icon: Icon(Icons.camera),onPressed: getAnswerImage,tooltip: "می توان فقط عکس هم فرستاد",)
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                     child: (focusOnTashrihi) ? TextFormField(
                       textDirection: TextDirection.rtl,
                       controller: TashrihiTextController,
                       keyboardType: TextInputType.multiline,
                       maxLines: 3,
                       decoration: InputDecoration(border: OutlineInputBorder()),
                     )
                        :TextFormField(
                        textDirection: TextDirection.rtl,
                        controller: TashrihiTextController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        readOnly: true,
                        decoration: InputDecoration(border: InputBorder.none),
                     ),
                     onFocusChange: (value) => _focusChangeOnTashrihi(value),
                   )
                ),
              ],
            ),
            (_AnswerImage != null) ? Container(child: InkWell(onTap:() => _deleteAnswerImage(),child: Image.file(_AnswerImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
                : Container(),
          ],
        ),
      ),
    );
  }
  Widget blankWidget()
  {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text("پاسخ سوال",textDirection: TextDirection.rtl,),
            Container(
              padding: EdgeInsets.all(4.0),
              width: 120,
              child: InkWell(
                child: (focusOnBlank) ?  TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: BlankTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
                  :TextFormField(
                   textDirection: TextDirection.rtl,
                   controller: BlankTextController,
                   keyboardType: TextInputType.text,
                   readOnly: true,
                   decoration: InputDecoration(border: InputBorder.none),
                    ),
                onFocusChange: (value) => _focusChangeOnBlank(value),
              )
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
  Widget testWidget()
  {
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
                  Radio(value: 1, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                    child: InkWell(
                      child: (focusOnTest1) ? TextFormField(
                        textDirection: TextDirection.rtl,
                        controller: TestText1Controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      )
                          :TextFormField(
                        textDirection: TextDirection.rtl,
                        controller: TestText1Controller,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                      onFocusChange: (value) => _focusChangeOnTest1(value),
                    )
                  )
                ],
              ),
            ),
           // Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(value: 2, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                      child: InkWell(
                        child: (focusOnTest2) ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TestText2Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        )
                            :TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TestText2Controller,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                        onFocusChange: (value) => _focusChangeOnTest2(value),
                      )
                  )
                ],
              ),
            ),
          //  Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(value: 3, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                      child: InkWell(
                        child: (focusOnTest3) ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TestText3Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        )
                            :TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TestText3Controller,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                        onFocusChange: (value) => _focusChangeOnTest3(value),
                      )
                  )
                ],
              ),
            ),
          //  Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Radio(value: 4, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index)),
                  Expanded(
                      child: InkWell(
                        child: (focusOnTest4) ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TestText4Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        )
                            :TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: TestText4Controller,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                        onFocusChange: (value) => _focusChangeOnTest4(value),
                      )
                  )
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

  Widget multiOption()
  {
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
                        child: (focusOnMultiOption1) ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText1Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        )
                            :TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText1Controller,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                        onFocusChange: (value) => _focusChangeOnMultiOption1(value),
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
                  Checkbox(value: optionTwo, onChanged: optionTwoChange),
                  Expanded(
                      child: InkWell(
                        child: (focusOnMultiOption2) ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText2Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        )
                            :TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText2Controller,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                        onFocusChange: (value) => _focusChangeOnMultiOption2(value),
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
                      child: InkWell(
                        child: (focusOnMultiOption3) ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText3Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        )
                            :TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText3Controller,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                        onFocusChange: (value) => _focusChangeOnMultiOption3(value),
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
                      child: InkWell(
                        child: (focusOnMultiOption4) ? TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText4Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        )
                            :TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: MultiOptionText4Controller,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                        onFocusChange: (value) => _focusChangeOnMultiOption4(value),
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int whichKind = 0;
  String kind;
  void onSelectedKindMenu(int value)
  {
    if (value == 1) {
      setState(() {
        kind = "تستی";
        whichKind = 1;
      });
    }
    else if (value == 2) {
      setState(() {
        kind = "جایخالی";
        whichKind = 2;
      });
    }
    else if (value == 3) {
      setState(() {
        kind = "چند گزینه ای";
        whichKind = 3;
      });
    }
    else if (value == 4) {
      setState(() {
        kind = "تشریحی";
        whichKind = 4;
      });
    }
  }
  List<PopupMenuItem<int>> kindList = [];
  PopupMenuItem<int> popupMenuItem (int value,String text)
  {
    return PopupMenuItem(
        value: value,
        child: Container(alignment: Alignment.centerRight,child: Text(text,textDirection: TextDirection.rtl,))
    );
  }

  @override
  void initState() {
    super.initState();

    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(cahpterlist);
    difficultyData.fillStringList(difficultylist);

    kindList..add(popupMenuItem(1, "تستی"))
    ..add(popupMenuItem(2, "جایخالی"))
    ..add(popupMenuItem(3, "چند گزینه ای"))
    ..add(popupMenuItem(4, "تشریحی"));

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


  void submit() async
  {
    newQuestion.text = QuestionTextController.text;
    //newQuestion.image1 =
    //newQuestion.image2 =
    newQuestion.paye = payeData.name;
    newQuestion.book = bookData.name;
    newQuestion.chapter = chapterData.name;
    newQuestion.difficulty = difficultyData.name;
    newQuestion.kind = kind;
    newQuestion.isPublic = addQuestionBankOption;

    final prefs = await SharedPreferences.getInstance();
   // String token = prefs.getString("token");

    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFkYWYxN2Q5YmZmYzAwMTc2ZGU0NDgiLCJpYXQiOjE2MDUyMTgwNzF9.wS8GHC67ZBswQjEisWkMgot3_r92PnRyvN5WlMmhG34";
    if (token == null) {return;}
    String tokenplus = "Bearer" + " " + token;
    dynamic data;
    String url = "https://parham-backend.herokuapp.com/question";

    if (newQuestion.kind == "تستی")
    {
      newQuestion.optionOne = TestText1Controller.text;
      newQuestion.optionTwo = TestText2Controller.text;
      newQuestion.optionThree = TestText3Controller.text;
      newQuestion.optionFour = TestText4Controller.text;
      newQuestion.numberOne = _radioGroupValue;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion);
      print(qs.type);
      print(qs.public);
      print(qs.question);
      print(qs.answer);
      print(qs.base);
      print(qs.hardness);
      print(qs.course);
      print(qs.options);
      print(qs.chapter);
      data = jsonEncode(<String,dynamic>{
        "type": qs.type,
        "public": qs.public,
        "question": qs.question,
        "answer": qs.answer.toString(),
        "base": qs.base,
        "hardness" : qs.hardness,
        "course": qs.course,
        "options" : qs.options,
        "chapter" : qs.chapter,
      });
      final response = await http.post(url,
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
        _btnController.stop();
        //final responseJson = jsonDecode(response.body);
        //HomePage.user.avatarUrl = responseJson['user']['avatar'];
        //_showMyDialog(true);
        //_btnController.stop();
      }
      else{
        print("Question failed int test");
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        ShowCorrectnessDialog(false,context);
        _btnController.stop();
        //_showMyDialog(false);
        //_btnController.stop();
      }
    }
    else if (newQuestion.kind == "جایخالی")
    {
      newQuestion.answerString = BlankTextController.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion);
      // print(qs.type);
      // print(qs.public);
      // print(qs.question);
      // print(qs.answer);
      // print(qs.base);
      // print(qs.hardness);
      // print(qs.course);
      data = jsonEncode(<String,String>{
        "type": qs.type,
        "public": qs.public,
        "question": qs.question,
        "answer": qs.answer,
        "base": qs.base,
        "hardness" : qs.hardness,
        "course": qs.course,
        "chapter" : qs.chapter,
      });
      final response = await http.post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data
      );
      if(response.statusCode == 200)
      {
        print("Question Created in jayekhali");
        ShowCorrectnessDialog(true,context);
        _btnController.stop();
      }
      else
        {
          print("Question failed in jayekhali");
          ShowCorrectnessDialog(false,context);
          _btnController.stop();
        }
    }
    else if (newQuestion.kind == "چند گزینه ای")
    {
      newQuestion.optionOne = MultiOptionText1Controller.text;
      newQuestion.optionTwo = MultiOptionText2Controller.text;
      newQuestion.optionThree = MultiOptionText3Controller.text;
      newQuestion.optionFour = MultiOptionText4Controller.text;
      newQuestion.numberOne = (optionOne) ? 1: 0;
      newQuestion.numberTwo = (optionTwo) ? 1: 0;
      newQuestion.numberThree = (optionThree) ? 1: 0;
      newQuestion.numberFour = (optionFour) ? 1: 0;

      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion);
      // print(qs.type);
      // print(qs.public);
      // print(qs.question);
      // print(qs.answer);
      // print(qs.base);
      // print(qs.hardness);
      // print(qs.course);
      // print(qs.options);
      data = jsonEncode(<String,dynamic>{
        "type": qs.type,
        "public": qs.public,
        "question": qs.question,
        "answer": qs.answer,
        "base": qs.base,
        "hardness" : qs.hardness,
        "course": qs.course,
        "options" : qs.options,
        "chapter" : qs.chapter,
      });
      final response = await http.post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data
      );
      if(response.statusCode == 200)
      {
        print("Question Created in multiChoice");
        ShowCorrectnessDialog(true,context);
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      }
      else
      {
        print("Question failed in multiChoice");
        ShowCorrectnessDialog(false,context);
        final responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        _btnController.stop();
      }
    }
    else if (newQuestion.kind == "تشریحی")
    {
      //newQuestion.image2 =
      newQuestion.answerString = TashrihiTextController.text;
      QuestionServer qs = QuestionServer.QuestionToQuestionServer(newQuestion);
      data = jsonEncode(<String,String>{
        "type": qs.type,
        "public": qs.public,
        "question": qs.question,
        "answer": qs.answer,
        "base": qs.base,
        "hardness" : qs.hardness,
        "course": qs.course,
        "chapter" : qs.chapter,
      });
      final response = await http.post(url,
          headers: {
            'accept': 'application/json',
            'Authorization': tokenplus,
            'Content-Type': 'application/json',
          },
          body: data
      );
      if(response.statusCode == 200)
      {
        print("Question Created in tashrihi");
        ShowCorrectnessDialog(true,context);
        _btnController.stop();
      }
      else
      {
        print("Question failed in tashrihi");
        ShowCorrectnessDialog(false,context);
        _btnController.stop();
      }
    }
    print("etmam");
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
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "ایجاد سوال",
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
                                  Text("متن سوال",textDirection: TextDirection.rtl,),
                                  IconButton(icon: Icon(Icons.camera),onPressed: getQuestionImage,tooltip: "می توان فقط عکس هم فرستاد",)
                                ],
                              ),
                            ),
                            //TextFieldWithFocus(focusOnText: true,maxLine: 3,TextController: QuestionTextController,textInputType: TextInputType.multiline,)
                            Expanded(
                              child: InkWell(
                                child: (focusOnQuestionText) ? TextFormField(
                                  autofocus: true,
                                  textDirection: TextDirection.rtl,
                                  controller: QuestionTextController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(border: OutlineInputBorder()),
                                )
                                    :TextFormField(
                                  textDirection: TextDirection.rtl,
                                  controller: QuestionTextController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  readOnly: true,
                                  decoration: InputDecoration(border: InputBorder.none),
                                ),
                                onFocusChange: (value) => _focusChangeOnQuestionText(value),
                              )
                            ),
                          ],
                        ),
                        (_QuestionImage != null) ? Container(child: InkWell(onTap:() => _deleteQuestionImage(),child: Image.file(_QuestionImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
                            : Container(),
                      ],
                    ),
                  ),
                ),
                //TextFormField(),
                Card(
                  child: Column(
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PopupMenu(Data: payeData,)
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:PopupMenu(Data: bookData,)
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PopupMenu(Data: chapterData,)
                          ),
                        ],
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PopupMenuButton(
                              //padding: EdgeInsets.all(50.0),
                              child: (kind == null) ? Text("نوع سوال") : Text(kind),
                              onSelected: onSelectedKindMenu,
                              itemBuilder: (context) => kindList,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PopupMenu(Data: difficultyData,)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (whichKind == 1) testWidget()
                else if (whichKind == 2) blankWidget()
                else if (whichKind == 3) multiOption()
                else if (whichKind == 4) tashrihiWidget(),

                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Checkbox(value: addQuestionBankOption, onChanged: addQuestionBankOptionChange),
                    Text("افزودن به بانک سوال",textDirection: TextDirection.rtl,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  // FlatButton(
                  //   color: Color(0xFF3D5A80),
                  //   onPressed: submit,
                  //   child: Text("اضافه کردن"),
                  //   textColor: Colors.white,
                  // ),
                  RoundedLoadingButton(
                    height: 40,
                    child: Text('اضافه کردن',style: TextStyle(color: Colors.white),),
                      //borderRadius: 0,
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
    );
  }
}

// class TextFieldWithFocus extends StatefulWidget {
//   bool focusOnText;
//   TextEditingController TextController;
//   int maxLine;
//   TextInputType textInputType;
//   TextFieldWithFocus({Key key, this.focusOnText, this.TextController,this.maxLine,this.textInputType}) : super(key: key);
//   @override
//   _TextFieldWithFocusState createState() => _TextFieldWithFocusState();
// }
//
// class _TextFieldWithFocusState extends State<TextFieldWithFocus> {
//   void _focusChangeOnText(bool isChange)
//   {
//     if(isChange)
//     {
//       setState(() {
//         widget.focusOnText = true;
//       });
//     }
//     else
//     {
//       setState(() {
//         widget.focusOnText = false;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: (widget.focusOnText) ? TextFormField(
//         textDirection: TextDirection.rtl,
//         controller: widget.TextController,
//         keyboardType: widget.textInputType,
//         //keyboardType: TextInputType.multiline,
//         maxLines: widget.maxLine,
//         decoration: InputDecoration(border: OutlineInputBorder()),
//       )
//           :TextFormField(
//         textDirection: TextDirection.rtl,
//         controller: widget.TextController,
//         keyboardType: widget.textInputType,
//         maxLines: widget.maxLine,
//         readOnly: true,
//         decoration: InputDecoration(border: InputBorder.none),
//       ),
//       onFocusChange: (value) => _focusChangeOnText(value),
//     );
//   }
// }
//
