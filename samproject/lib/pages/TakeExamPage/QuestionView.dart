import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samproject/domain/controllers.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/widgets/questionWidgets.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  Question UserAnswerQuestion;
  File _AnswerFile;
  bool registeredAnswer = false;
  // final picker = ImagePicker();
  // void getAnswerImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null ) {
  //       _AnswerImage = File(pickedFile.path);
  //      // widget.question.answerImage = base64Encode(_AnswerImage.readAsBytesSync());
  //     }
  //   });
  // }
  void chooseFile() async
  {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        _AnswerFile = File(pickedFile.path);
      }
    });
    // _AnswerFile = File("/sdcard/Download/Feasibility Study Phase.pdf");
    // setState(() {
    //
    // });
  }
  void sendAnswer() async
  {
     //final prefs = await SharedPreferences.getInstance();
     //String token = prefs.getString("token");
     String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmMxMjAwNTZlMTdmMDAwMTcwYzA1NDMiLCJpYXQiOjE2MDc5MjU1NDV9.jFuqcw14ftz2FIBXro1LA7dshwCZzFIxZv9Q4uAKuuk";
     //if (token == null) {ShowCorrectnessDialog(false, context);return;}
     String tokenplus = "Bearer" + " " + token;
     String answer = "";
     if (widget.question.kind == "تست")
     {
       answer = UserAnswerQuestion.numberOne.toString();
     }
     else if (widget.question.kind == "چند گزینه ای")
     {
       (UserAnswerQuestion.numberOne == 1) ? answer += "1," : null;
       (UserAnswerQuestion.numberTwo == 1) ? answer += "2," : null;
       (UserAnswerQuestion.numberThree == 1) ? answer += "3," : null;
       (UserAnswerQuestion.numberFour == 1) ? answer += "4," : null;
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
     else if (widget.question.kind == "پاسخ کوتاه")
     {
       answer = controllers.BlankTextController.text;
     }
     else if (widget.question.kind == "تشریحی")
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

    //upload from package
    //  final uploader = FlutterUploader();
    // final taskId = await uploader.enqueue(
    //     url: "https://parham-backend.herokuapp.com/user/avatar", //required: url to upload to
    //     files: [FileItem(filename: basename(_AnswerImage.path) , savedDir: _AnswerImage.parent.path, /*fieldname:"file"*/)], // required: list of files that you want to upload
    //     method: UploadMethod.PUT, // HTTP method  (POST or PUT or PATCH)
    //     headers: {"Authorization": tokenplus,},
    //     //data: {"name": "john"}, // any data you want to send in upload request
    //     showNotification: true, // send local notification (android only) for upload status
    //   //  tag: "upload 1", // unique tag for upload task
    // );
    //
    //  final subscription = uploader.result.listen((result) {
    //    print(result.statusCode);
    //  }, onError: (ex, stacktrace) {
    //    // ... code to handle error
    //  });
    //  print(subscription);

    //upload from http

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
      print(_AnswerFile.path);
      var file;
      if (extenstion == 'jpg')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('image', 'jpg'));
        print("in jpg");
      }
      else if (extenstion == 'jpeg')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('image', 'jpeg'));

      }
      else if (extenstion == 'png')
      {
        file = await http.MultipartFile.fromPath("answer", _AnswerFile.path,contentType: MediaType('image', 'png'));
        print("in png");
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
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("200" + responseString);
      setState(() {
        registeredAnswer = true;
      });
    }
    else
      {
        // final responseJson = jsonDecode(response.reasonPhrase);
        // print(responseJson.toString());
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print(responseString);

      }
  }
  void deleteAnswer(bool IsCompleteDelete) async
  {
    //final prefs = await SharedPreferences.getInstance();
    //String token = prefs.getString("token");
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmMxMjAwNTZlMTdmMDAwMTcwYzA1NDMiLCJpYXQiOjE2MDc5MjU1NDV9.jFuqcw14ftz2FIBXro1LA7dshwCZzFIxZv9Q4uAKuuk";
    //if (token == null) {ShowCorrectnessDialog(false, context);return;}
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
      setState(() {
        registeredAnswer = false;
        _AnswerFile = null;
      });
      
    }
    else
      {
        //ShowCorrectnessDialog(false, context)
      }

  }

  @override
  void initState() {
    super.initState();
    UserAnswerQuestion = widget.question.CopyQuestion();
    // UserAnswerQuestion.answerImage = null;
    // UserAnswerQuestion.answerString = null;
    // UserAnswerQuestion.isPublic = null;
    UserAnswerQuestion.numberOne = 0;
    UserAnswerQuestion.numberTwo = 0;
    UserAnswerQuestion.numberThree = 0;
    UserAnswerQuestion.numberFour = 0;

    //basename(_AnswerFile.path);
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
    return Card(
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text("بارم",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                    Text(widget.question.grade.toString(),textDirection: TextDirection.rtl,textAlign: TextAlign.center),
                  ],
                ),
              ),
              Expanded(flex: 10,child: NotEditingQuestionText(question: widget.question,)),
            ],
          ),
          //NotEditingQuestionSpecification(question: widget.question,),
         // NotEditingQuestionText(question: widget.question,),
          if (widget.question.kind == "چند گزینه ای"/*HomePage.maps.SKindMap["MULTICHOISE"]*/) NotEditingMultiChoiceOption(question: UserAnswerQuestion,isNull: false,)
          else if (widget.question.kind == "تست"/*HomePage.maps.SKindMap["TEST"]*/) NotEditingTest(question: UserAnswerQuestion,isNull: false,)
          else if (widget.question.kind == "پاسخ کوتاه"/*HomePage.maps.SKindMap["SHORTANSWER"]*/) EditingShortAnswer(question: UserAnswerQuestion,controllers: controllers,)
            else if (widget.question.kind == "تشریحی"/*HomePage.maps.SKindMap["LONGANSWER"]*/) EditingLongAnswer(question: UserAnswerQuestion,controllers: controllers,showChooseImage: false,),
          //RaisedButton(onPressed: filePicker,child: Text("انتخاب فایل"),)
          //IconButton(icon: Icon(Icons.camera),onPressed: getAnswerImage,tooltip: "می توان فقط عکس هم فرستاد",),
          // (_AnswerFile != null) ? Image.file(_AnswerFile) : Container(),
          (_AnswerFile != null) ? Row(
            children: [
              IconButton(icon: Icon(Icons.clear), onPressed: () => deleteAnswer(false),color: Colors.red,),
              Expanded(child: Container()),
              Text(basename(_AnswerFile.path),textDirection: TextDirection.rtl,),
            ],
          ) : Container(),
          if (registeredAnswer == false && widget.question.kind != "تشریحی") Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF3D5A80),textColor: Colors.white,),
            ],
          )
          else if (registeredAnswer == true && widget.question.kind != "تشریحی") Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ جدید",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color : Color(0xFF0e918c),textColor: Colors.white,),
              RaisedButton(onPressed: () => deleteAnswer(true),child: Text("حذف پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color.fromRGBO(238, 108,77 ,1.0),textColor: Colors.white,),
            ],
          )
          else if (registeredAnswer == false && widget.question.kind == "تشریحی") Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(onPressed: chooseFile,child: Text("انتخاب فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF3D5A80),textColor: Colors.white,),
                RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF0e918c),textColor: Colors.white,),
              ],
          )
          else if (registeredAnswer == true && widget.question.kind == "تشریحی") Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(onPressed: chooseFile,child: Text("انتخاب فایل",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF3D5A80),textColor: Colors.white,),
                  RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ جدید",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color(0xFF0e918c),textColor: Colors.white,),
                  RaisedButton(onPressed: () => deleteAnswer(true),child: Text("حذف پاسخ",textDirection: TextDirection.rtl,textAlign: TextAlign.center,),color: Color.fromRGBO(238, 108,77 ,1.0),textColor: Colors.white,),
                ],
          ),
          // (widget.question.kind == "تشریحی") ? RaisedButton(onPressed: chooseFile,child: Text("انتخاب فایل"),) : Container(),
          // RaisedButton(onPressed: sendAnswer,child: Text("ثبت پاسخ")),
        ],
      ),
    );
  }
}
