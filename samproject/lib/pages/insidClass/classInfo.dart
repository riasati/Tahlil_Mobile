import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';

import 'EditAndRemoveButtons.dart';

class ClassInfoCard extends StatefulWidget {
  final insidClassPageSetState;


  ClassInfoCard({@required void toggleCoinCallback()})
      : insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassInfoCardState createState() => _ClassInfoCardState();
}

class _ClassInfoCardState extends State<ClassInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Padding(
                //       child: FlatButton(
                //         onPressed: () {
                //           //Navigator.pop(context);
                //         },
                //         child: Icon(
                //           FontAwesomeIcons.arrowLeft,
                //           color: Colors.white,
                //         ),
                //       ),
                //       padding: EdgeInsets.only(top: 25),
                //     )
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 45),
                  child: AutoSizeText(
                    InsidClassPage.currentClass.className,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "استاد: " + InsidClassPage.currentClass.ownerFullName,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/classroom.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        InsidClassPage.isAdmin?EditAndRemoveButtons(toggleCoinCallback: classInfoSetSate,):Container(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 20),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      child:
                          SelectableText(InsidClassPage.currentClass.classId, style: TextStyle(fontWeight: FontWeight.bold),),
                      padding: EdgeInsets.only(right: 10),
                    ),
                    Icon(FontAwesomeIcons.key, color:Color(0xFF3D5A80)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        child:
                        SelectableText(InsidClassPage.admin.email, style: TextStyle(fontWeight: FontWeight.bold),),
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Icon(Icons.email, color:Color(0xFF3D5A80)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        child:
                        Text("توضیحات:", textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold),),
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Icon(FontAwesomeIcons.solidClipboard, color:Color(0xFF3D5A80)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Padding(
                    child:
                    AutoSizeText(InsidClassPage.currentClass.classDescription, textDirection: TextDirection.rtl, maxLines: 10,),
                    padding: EdgeInsets.only(right: 10),
                  ),
                ),
              ],
            ),
          ),
          flex: 3,
        )
      ],
    );
  }

  void classInfoSetSate(){
    setState(() {
      widget?.insidClassPageSetState();
    });
  }
}
