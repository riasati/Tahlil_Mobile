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
class QuestionViewInTakeExam extends StatefulWidget {
  Question question;
  QuestionViewInTakeExam({Key key, this.question,}) : super(key: key);
  @override
  _QuestionViewInTakeExamState createState() => _QuestionViewInTakeExamState();
}

class _QuestionViewInTakeExamState extends State<QuestionViewInTakeExam> {
  Controllers controllers = new Controllers();
  Question UserAnswerQuestion;
  File _AnswerFile;
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

  }
  void sendFile() async
  {
     //final prefs = await SharedPreferences.getInstance();
     //String token = prefs.getString("token");
     String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmMxMjAwNTZlMTdmMDAwMTcwYzA1NDMiLCJpYXQiOjE2MDc3MDY0ODZ9._T_RCoN7Bvb8y10Z8LZm72xSKZ54RcuEBzevjKpladc";
     //if (token == null) {ShowCorrectnessDialog(false, context);return;}
     String tokenplus = "Bearer" + " " + token;

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
   //  final prefs = await SharedPreferences.getInstance();
   //  String token = prefs.getString("token");
   //  //if (token == null) {ShowCorrectnessDialog(false, context);return;}
   //  String tokenplus = "Bearer" + " " + token;
   //  String url = "https://parham-backend.herokuapp.com/user/avatar";
   //  //http.MultipartFile('POST',Uri.parse(uri));
   //  var req = http.MultipartRequest('PUT', Uri.parse(url));
   //  req.headers.putIfAbsent("Authorization", () => tokenplus);
   //  print(_AnswerImage.path);
   //  var pic = await http.MultipartFile.fromPath("image", _AnswerImage.path);
   //  //add multipart to request
   //  req.files.add(pic);
   //  var response = await req.send();
   //  if (response.statusCode == 200)
   //  {
   //    // response.stream.transform(utf8.decoder).listen((value) {
   //    //   print(value);
   //    // });
   //    // final responseJson = jsonDecode(response.reasonPhrase);
   //    // print(responseJson.toString());
   //    var responseData = await response.stream.toBytes();
   //    var responseString = String.fromCharCodes(responseData);
   //    print("200" + responseString);
   //  }
   //  else
   //    {
   //      // final responseJson = jsonDecode(response.reasonPhrase);
   //      // print(responseJson.toString());
   //      var responseData = await response.stream.toBytes();
   //      var responseString = String.fromCharCodes(responseData);
   //      print(responseString);
   //    }
   // // req.files.add(http.MultipartFile())
  }

  @override
  void initState() {
    super.initState();
    UserAnswerQuestion = widget.question.CopyQuestion();
    UserAnswerQuestion.answerImage = null;
    UserAnswerQuestion.answerString = null;
    UserAnswerQuestion.isPublic = null;
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
    return Column(
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
            Expanded(flex: 10,child: NotEditingQuestionSpecification(question: widget.question,)),
          ],
        ),
        //NotEditingQuestionSpecification(question: widget.question,),
        NotEditingQuestionText(question: widget.question,),
        if (widget.question.kind == "چند گزینه ای"/*HomePage.maps.SKindMap["MULTICHOISE"]*/) NotEditingMultiChoiceOption(question: UserAnswerQuestion,isNull: false,)
        else if (widget.question.kind == "تست"/*HomePage.maps.SKindMap["TEST"]*/) NotEditingTest(question: UserAnswerQuestion,isNull: false,)
        else if (widget.question.kind == "پاسخ کوتاه"/*HomePage.maps.SKindMap["SHORTANSWER"]*/) EditingShortAnswer(question: UserAnswerQuestion,controllers: controllers,)
          else if (widget.question.kind == "تشریحی"/*HomePage.maps.SKindMap["LONGANSWER"]*/) EditingLongAnswer(question: UserAnswerQuestion,controllers: controllers,showChooseImage: false,),
        //RaisedButton(onPressed: filePicker,child: Text("انتخاب فایل"),)
        //IconButton(icon: Icon(Icons.camera),onPressed: getAnswerImage,tooltip: "می توان فقط عکس هم فرستاد",),
        (_AnswerFile != null) ? Text(basename(_AnswerFile.path),textDirection: TextDirection.rtl,) : Container(),
        (widget.question.kind == "تشریحی") ? RaisedButton(onPressed: chooseFile,child: Text("انتخاب فایل"),) : Container(),
        RaisedButton(onPressed: sendFile,child: Text("ثبت پاسخ")),
      ],
    );
  }
}
