import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClassExams extends StatefulWidget {
  @override
  _ClassExamsState createState() => _ClassExamsState();
}

class _ClassExamsState extends State<ClassExams> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        //color: Colors.black45,
        child: FlatButton(
          onPressed: () {
            examsListBottomSheet();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    FontAwesomeIcons.users,
                    size: 50,
                    color: Color(0xFF3D5A80),
                  ),
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: AutoSizeText(
                    "لیست آزمون ها",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void examsListBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )
      ),
      barrierColor: Color(0xFF3D5A80).withOpacity(0.8),
      builder: (context) => Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Icon(FontAwesomeIcons.gripLines),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
          ),
          Expanded(child: examsList()),
        ],
      ));

  Widget examsList(){
    return ListView(
      children:  <Widget>[
        eachExamCard(),
        eachExamCard(),
        eachExamCard(),
        eachExamCard(),
      ],
    );
  }

  Widget eachExamCard(){
    return Card(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        minWidth: double.infinity,
        onPressed: () {},
        child: ListTile(
          leading: Icon(Icons.more_vert),
          title: Text('حمیدرضا آذرباد', textAlign: TextAlign.right,),
          //trailing: FlutterLogo(size: 45,),
          trailing: Text("عنوان آزمون", textAlign: TextAlign.right,),
        ),
      ),
    );
  }

  void _getExamsListFromServer() {
  }
}
