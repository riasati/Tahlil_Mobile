import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/UserAnswerLong.dart';
import 'package:samproject/domain/UserAnswerMultipleChoice.dart';
import 'package:samproject/domain/UserAnswerShort.dart';
import 'package:samproject/domain/UserAnswerTest.dart';
import 'package:samproject/domain/controllers.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:samproject/widgets/questionWidgets.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
class QuestionViewInTakeExam extends StatefulWidget {
  Question question;
  String ExamId;
  int questionIndex;
  QuestionViewInTakeExam({Key key, this.question,this.ExamId,this.questionIndex}) : super(key: key);
  @override
  _QuestionViewInTakeExamState createState() => _QuestionViewInTakeExamState();
}

class _QuestionViewInTakeExamState extends State<QuestionViewInTakeExam> {
  Controllers controllers = new Controllers();
  File _AnswerFile;
  bool registeredAnswer = false;
  bool hasAnsweFile = false;
  String fileName;
  final RoundedLoadingButtonController _registerBtnController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _deleteBtnController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _chooseBtnController = new RoundedLoadingButtonController();
  void chooseFile() async
  {
    _chooseBtnController.stop();
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (pickedFile != null ) {
        _AnswerFile = File(pickedFile.path);
        hasAnsweFile = true;
        fileName = basename(_AnswerFile.path);
        prefs.setString("FileNameQuestion"+ widget.questionIndex.toString(), fileName);
      }
    });
  }
  void sendAnswer(BuildContext context) async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {ShowCorrectnessDialog(false, context);return;}
    String tokenplus = "Bearer" + " " + token;
    String answer = "";
    if (widget.question.kind == "TEST")
    {
      answer = widget.question.numberOne.toString();
    }
    else if (widget.question.kind == "MULTICHOISE")
    {
      (widget.question.numberOne == 1) ? answer += "1," : null;
      (widget.question.numberTwo == 1) ? answer += "2," : null;
      (widget.question.numberThree == 1) ? answer += "3," : null;
      (widget.question.numberFour == 1) ? answer += "4," : null;
      if (answer.endsWith(","))
      {
        String answerPlus = "";
        for (int i = 0;i<answer.length-1;i++)
        {
          answerPlus += answer[i];
        }
        answer = answerPlus;
      }
    }
    else if (widget.question.kind == "SHORTANSWER")
    {
      answer = controllers.BlankTextController.text;
    }
    else if (widget.question.kind == "LONGANSWER")
    {
      answer = controllers.TashrihiTextController.text;
      print(answer);
    }

    //download
    //   WidgetsFlutterBinding.ensureInitialized();
    //   await FlutterDownloader.initialize(
    //       debug: true // optional: set false to disable printing logs to console
    //   );
    //   final taskId = await FlutterDownloader.enqueue(
    //     url: 'http://parham-backend.herokuapp.com/uploads/avatar/avatar-1607709050880avatar5fc120056e17f000170c0543.png',
    //     savedDir: "/storage/emulated/0",
    //     showNotification: true, // show download progress in status bar (for Android)
    //     openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    //   );

    var params = {
      'answer': answer,
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    String url = "https://parham-backend.herokuapp.com/exam/" + widget.ExamId + "/questions/" + widget.questionIndex.toString() + "/answer?" + query;
    var req = http.MultipartRequest('POST', Uri.parse(url));
    req.headers.putIfAbsent("Authorization", () => tokenplus);
    req.headers.putIfAbsent("accept", () => "application/json");
    if (_AnswerFile != null)
    {
      String extenstion = _AnswerFile.path.split('.').last;
      //print(_AnswerFile.path);
      var file;
      if (extenstion == 'jpg')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('image', 'jpg'));
        //print("in jpg");
      }
      else if (extenstion == 'jpeg')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('image', 'jpeg'));

      }
      else if (extenstion == 'png')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('image', 'png'));
        //print("in png");
      }
      else if (extenstion == 'pdf')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('application', 'pdf'));
      }
      else if (extenstion == 'zip')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('application', 'zip'));
      }
      else return;

      req.files.add(file);
    }
    var response = await req.send();
    if (response.statusCode == 200)
    {
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      // final responseJson = jsonDecode(response.reasonPhrase);
      // print(responseJson.toString());
      if (widget.question.kind == "TEST")
      {
        UserAnswerTest userAnswerTest = new UserAnswerTest();
        userAnswerTest.userChoice = widget.question.numberOne;
        widget.question.userAnswer = userAnswerTest;
      }
      else if (widget.question.kind == "MULTICHOISE")
      {
        UserAnswerMultipleChoice userAnswerMultipleChoice = new UserAnswerMultipleChoice();
        (widget.question.numberOne == 1) ? userAnswerMultipleChoice.userChoices.add(1) : null;
        (widget.question.numberTwo == 1) ? userAnswerMultipleChoice.userChoices.add(2) : null;
        (widget.question.numberThree == 1) ? userAnswerMultipleChoice.userChoices.add(3) : null;
        (widget.question.numberFour == 1) ? userAnswerMultipleChoice.userChoices.add(4) : null;
        widget.question.userAnswer = userAnswerMultipleChoice;
      }
      else if (widget.question.kind == "SHORTANSWER")
      {
        UserAnswerShort userAnswerShort = new UserAnswerShort();
        userAnswerShort.answerText = controllers.BlankTextController.text;
        widget.question.userAnswer = userAnswerShort;
      }
      else if (widget.question.kind == "LONGANSWER")
      {
        UserAnswerLong userAnswerLong = new UserAnswerLong();
        userAnswerLong.answerText = controllers.TashrihiTextController.text;
        widget.question.userAnswer = userAnswerLong;
      }


      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("200" + responseString);
      setState(() {
        _registerBtnController.stop();
        if (_AnswerFile != null)
        {
          UserAnswerLong userAnswerLong = new UserAnswerLong();//widget.question.userAnswer;
          userAnswerLong.answerFile = "notNull";
          userAnswerLong.answerText = answer;
          widget.question.userAnswer = userAnswerLong;
        }
        // if (isRegisterBtn)
        // {
        //   _registerBtnController.stop();
        //   print("here1");
        // }
        // else
        //   {
        //     _reRegisterBtnController.stop();
        //     print("here2");
        //   }
        //(isRegisterBtn) ? _registerBtnController.stop() : _reRegisterBtnController.stop();
        registeredAnswer = true;
      });
    }
    else
    {
      // final responseJson = jsonDecode(response.reasonPhrase);
      // print(responseJson.toString());
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      _registerBtnController.stop();
      ShowCorrectnessDialog(false, context);
      widget.question.numberOne = null;
      widget.question.numberTwo = null;
      widget.question.numberThree = null;
      widget.question.numberFour = null;
      print(responseString);

    }
  }
  void deleteAnswer(bool IsCompleteDelete,BuildContext context) async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {ShowCorrectnessDialog(false, context);return;}
    String tokenplus = "Bearer" + " " + token;
    var headers = {
      'accept': 'application/json',
      'Authorization': tokenplus,
    };
    var params;
    if (IsCompleteDelete)
    {
      params = {
        'deleteFile': 'true',
        'deleteText': 'true',
      };
    }
    else
    {
      params = {
        'deleteFile': 'true',
        'deleteText': 'false',
      };
    }

    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    String url = "https://parham-backend.herokuapp.com/exam/" + widget.ExamId + "/questions/" + widget.questionIndex.toString() + "/answer?" + query;
    var res = await http.delete(url, headers: headers);
    if (res.statusCode == 200)
    {
      final responseJson = jsonDecode(res.body);
      print(responseJson.toString());
      setState(() {
        _deleteBtnController.stop();
        if (IsCompleteDelete)
        {
          registeredAnswer = false;
        }
        _AnswerFile = null;
        hasAnsweFile = false;
        fileName = null;
        widget.question.numberOne = null;
        widget.question.numberTwo = null;
        widget.question.numberThree = null;
        widget.question.numberFour = null;
        if (widget.question.kind == "LONGANSWER")
        {
          UserAnswerLong userAnswerLong = widget.question.userAnswer;
          userAnswerLong.answerFile = null;
          widget.question.userAnswer = userAnswerLong;
        }
      });

    }
    else
      {
        _deleteBtnController.stop();
        ShowCorrectnessDialog(false, context);
      }

  }
  void initLongAnswer() async
  {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("FileNameQuestion"+ widget.questionIndex.toString()) != null)
    {
      fileName = prefs.getString("FileNameQuestion"+ widget.questionIndex.toString());
      print(fileName);
      setState(() {

      });
    }
  }
  @override
  void initState() {
    super.initState();
    print(widget.question);
    if (widget.question.kind == "TEST")
    {
      if (widget.question.numberOne != null)
      {
        registeredAnswer = true;
      }
    }
    if (widget.question.kind == "MULTICHOISE")
    {
      if (widget.question.numberOne != null || widget.question.numberTwo != null || widget.question.numberThree != null || widget.question.numberFour != null)
      {
        registeredAnswer = true;
      }
    }
    if (widget.question.kind == "LONGANSWER")
    {
      //initLongAnswer();
      if (widget.question.userAnswer != null)
      {
        UserAnswerLong userAnswerLong = widget.question.userAnswer;
        if (userAnswerLong.answerText != null)
        {
          controllers.TashrihiTextController.text = userAnswerLong.answerText;
          registeredAnswer = true;
          if (userAnswerLong.answerFile != null)
          {
            if (userAnswerLong.answerFile != "http://parham-backend.herokuapp.com/undefined")
            {
              hasAnsweFile = true;
              // final prefs = await SharedPreferences.getInstance();
              // fileName = prefs.getString("FileNameQuestion"+ widget.questionIndex.toString());
              fileName = userAnswerLong.answerFile.split('/').last;
              initLongAnswer();
            }

          }
        }
      }
    }
    if (widget.question.kind == "SHORTANSWER")
    {
      if (widget.question.userAnswer != null)
      {
        UserAnswerShort userAnswerShort = widget.question.userAnswer;
        if (userAnswerShort.answerText != null)
        {
          controllers.BlankTextController.text = userAnswerShort.answerText;
          registeredAnswer = true;
        }
      }
    }
  }
  // void filePicker()async
  // {
  //   FilePickerResult result = await FilePicker.platform.pickFiles();
  //
  //   if(result != null) {
  //     File file = File(result.files.single.path);
  //   } else {
  //     // User canceled the picker
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    var questionKind;
    var answerRow;
    var shortAnswer = Card(
      margin: EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.all(4.0),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              textDirection: TextDirection.rtl,
              controller: controllers.BlankTextController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "پاسخ سوال"
              ),
            )
        ),
      ),
    );
    var longAnswer = Card(
      margin: EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.all(4.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textDirection: TextDirection.rtl,
            controller: controllers.TashrihiTextController,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "پاسخ سوال"
            ),
          ),
        ),
      ),
    );

    if (widget.question.kind == "MULTICHOISE") questionKind = Card(child: NotEditingMultiChoiceOption(question: widget.question,isNull: false,));
    else if (widget.question.kind == "TEST") questionKind = Card(child: NotEditingTest(question: widget.question,isNull: false,));
    else if (widget.question.kind == "SHORTANSWER") questionKind = shortAnswer;
    else if (widget.question.kind == "LONGANSWER") questionKind = longAnswer;

    if (registeredAnswer == false && widget.question.kind != "LONGANSWER") answerRow = Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedLoadingButton(borderRadius: 0,
          width: 100,
          height: 40,
          onPressed: () => sendAnswer(context),
          child: Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
          color: Color(0xFF3D5A80),
          controller:_registerBtnController,
        ),
      //  RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF3D5A80),textColor: Colors.white,),
      ],
    );
    else if (registeredAnswer == true && widget.question.kind != "LONGANSWER") answerRow = Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedLoadingButton(
          borderRadius: 0,
          width: 100,
          height: 40,
          onPressed: () => sendAnswer(context),
          child:Text("ثبت پاسخ جدید",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
          color : Color(0xFF0e918c),
          controller: _registerBtnController,
        ),
        RoundedLoadingButton(
            borderRadius: 0,
            width: 100,
            height: 40,
            onPressed: () => deleteAnswer(true,context),
            child: Text("حذف پاسخ",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
            color: Color.fromRGBO(238, 108, 77, 1.0),
            controller: _deleteBtnController,
          ),
          // RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ جدید",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color : Color(0xFF0e918c),textColor: Colors.white,),
      //  RaisedButton(onPressed: () => deleteAnswer(true),child: Text("حذف پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color.fromRGBO(238, 108,77 ,1.0),textColor: Colors.white,),
      ],
    );
    else if (registeredAnswer == false && widget.question.kind == "LONGANSWER") answerRow = Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedLoadingButton(borderRadius: 0,
          width: 100,
          height: 40,
          onPressed: () => chooseFile(),
          child: Text("انتخاب فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
          color: Color(0xFF3D5A80),
          controller:_chooseBtnController,
        ),
        //RaisedButton(onPressed: chooseFile,child: Text("انتخاب فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF3D5A80),textColor: Colors.white,),
        RoundedLoadingButton(borderRadius: 0,
          width: 100,
          height: 40,
          onPressed: () => sendAnswer(context),
          child: Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
          color: Color(0xFF0e918c),
          controller:_registerBtnController,
        ),
   //     RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF0e918c),textColor: Colors.white,),
      ],
    );
    else if (registeredAnswer == true && widget.question.kind == "LONGANSWER") answerRow = Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedLoadingButton(borderRadius: 0,
          width: 100,
          height: 40,
          onPressed: () => chooseFile(),
          child: Text("انتخاب فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
          color: Color(0xFF3D5A80),
          controller:_chooseBtnController,
        ),
        //RaisedButton(onPressed: chooseFile,child: Text("انتخاب فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF3D5A80),textColor: Colors.white,),
        RoundedLoadingButton(
          borderRadius: 0,
          width: 100,
          height: 40,
          onPressed: () => sendAnswer(context),
          child:Text("ثبت پاسخ جدید",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
          color : Color(0xFF0e918c),
          controller: _registerBtnController,
        ),
      //  RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ جدید",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF0e918c),textColor: Colors.white,),
        RoundedLoadingButton(
          borderRadius: 0,
          width: 100,
          height: 40,
          onPressed: () => deleteAnswer(true,context),
          child: Text("حذف پاسخ",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          color: Color.fromRGBO(238, 108, 77, 1.0),
          controller: _deleteBtnController,
        ),
        //RaisedButton(onPressed: () => deleteAnswer(true),child: Text("حذف پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color.fromRGBO(238, 108,77 ,1.0),textColor: Colors.white,),
      ],
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Container(
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(4, 15, 4, 4),
                        padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
                        child: Column(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(alignment: Alignment.centerRight,child: Text(widget.question.text,textDirection: TextDirection.rtl,)),
                            (widget.question.questionImage != null) ? Image.memory(base64Decode(widget.question.questionImage),fit: BoxFit.cover,height: 200,) : Container(),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 10,
                      child: Container(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        color: Colors.white,
                        child: Text("سوال",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),),
                      )
                  ),
                  Positioned(
                    top: 0,
                    left: 4,
                    child: Card(
                      child: Column(
                        children: [
                          Text("بارم",textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),),
                          Text(widget.question.grade.toString(),textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              questionKind,
              (hasAnsweFile) ? Row(
                children: [
                  IconButton(icon: Icon(Icons.clear), onPressed: () => deleteAnswer(false,context),color: Colors.red,),
                  Expanded(child: Container()),
                  Text(fileName,textDirection: TextDirection.rtl,),
                ],
              ) : Container(),
              answerRow,
            ],
          ),
        ),
      ),
    );
  }
}
