import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LastPage extends StatefulWidget {
  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: previousButton(),
                  width: 100,
                ),
                Container(
                  child: finishButton(),
                  width: 100,
                ),
              ],
            ),
          ),
          body: ListView(children: <Widget>[
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
              rows: dataRows(),
            ),
          ])),
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
        onPressed: () {},
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
        onPressed: () {},
      ),
    );
  }

  List<DataRow> dataRows(){
    List<DataRow> rows = [];
      for(int i = 1; i < 25 ; i++){
        rows.add(dataRow(i, true));
        rows.add(dataRow(25+i, false));
      }
      return rows;
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
