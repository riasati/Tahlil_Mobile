import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/Exam.dart';
import 'package:samproject/pages/TakeExamPage/TakeExamPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastPage extends StatefulWidget {
  String examId;
  bool finish;
  Exam exam;


  LastPage(this.examId, this.finish,this.exam);

  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  List<DataRow> statuses = [];
  bool lastPageLoading = false;

  @override
  void initState() {
    super.initState();
    getExamStatus();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black
                  )
                )
                ),
            height: 70,
            child: Row(
              mainAxisAlignment: widget.finish?MainAxisAlignment.center:MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: widget.finish?Text(""):previousButton(),
                  width: widget.finish?1:100,
                ),
                Container(
                  child: finishButton(),
                  width: 100,
                ),
              ],
            ),
          ),
          body: LoadingOverlay(
            child: ListView(children: <Widget>[
              DataTable(
                columns: [
                  DataColumn(
                      label: Center(
                        child: Text('شماره سوال',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      )),
                  DataColumn(
                      label: Center(
                        child: Text('پاسخ داده اید',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      )),
                ],
                rows: statuses,
              ),
            ]),
            isLoading: lastPageLoading,
          )),
    );
  }

  Widget previousButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(14, 145, 140, 1),
      ),
      width: 50,
      margin: EdgeInsets.only(left: 3),
      child: MaterialButton(
        child: Text(
          "بازگشت",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TakeExamPage(widget.exam)));
        },
      ),
    );
  }

  Widget finishButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF3D5A80),
      ),
      margin: EdgeInsets.only(right: 3),
      width: 50,
      child: MaterialButton(
        child: Text(
          "پایان",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
        //  Navigator.pop(context);
        },
      ),
    );
  }

  void getExamStatus() async{
    lastPageLoading = true;
    print(widget.examId);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = "http://parham-backend.herokuapp.com/exam/" + widget.examId + "/questions/status";
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        if(response.statusCode == 200) {
          var statusesInfo = json.decode(
              utf8.decode(response.bodyBytes))["status"];
          for (var statusInfo in statusesInfo) {
            statuses.add(dataRow(statusInfo["questionIndex"],
                statusInfo["hasAnswerText"]));
          }
          setState(() {

          });
        }else{
          print(response.body);
          setState(() {
            Alert(
              context: context,
              type: AlertType.error,
              title: "زمان آزمون فرانرسیده",
              buttons: [
              ],
            ).show();
          });
        }
      }
    }on Exception catch(e){
      print(e.toString());
      setState(() {
        Alert(
          context: context,
          type: AlertType.error,
          title: "عملیات ناموفق بود",
          buttons: [
          ],
        ).show();
      });
    }
    lastPageLoading = false;
  }

  DataRow dataRow(int index, bool isAnswered) {
    return DataRow(cells: [
      DataCell(Center(
        child: Text(
          index.toString(),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: isAnswered?Colors.black:Colors.red,

          ),
        ),
      )),
      DataCell(Center(
        child: isAnswered?Icon(
          FontAwesomeIcons.checkCircle,
          color: Color.fromRGBO(14, 145, 140, 1),
          size: 30,
        ):Container(child: Text(""),),
      )),
    ]);
  }
}
