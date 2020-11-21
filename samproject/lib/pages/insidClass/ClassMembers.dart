import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClassMembers extends StatefulWidget {
  @override
  _ClassMembersState createState() => _ClassMembersState();
}

class _ClassMembersState extends State<ClassMembers> {
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
            membersListBottomSheet();
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
                    "لیست اعضا",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 8),
                //   child: Container(
                //     alignment: Alignment.centerRight,
                //     child: AutoSizeText(
                //       "تعداد: 10",
                //       maxLines: 1,
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // )

              ],
            ),
          ),
        ),
      ),
    );
  }

  void membersListBottomSheet() => showModalBottomSheet(
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
          Expanded(child: memberList()),
        ],
      ));

  Widget memberList(){
    return ListView(
      children:  <Widget>[
        eachMemberCard(),
      ],
    );
  }

  Widget eachMemberCard(){
    return Card(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        minWidth: double.infinity,
        onPressed: () {
          _getCustomUserInfo();
        },
        child: ListTile(
          //leading: Icon(Icons.more_vert),
          title: Text('حمیدرضا آذرباد', textAlign: TextAlign.right,),
          //trailing: FlutterLogo(size: 45,),
          trailing: eachMemberCardAvatar(),
        ),
      ),
    );
  }

  Widget eachMemberCardAvatar(){
    return CircleAvatar(
      radius: 30.0,
      backgroundImage:
      AssetImage("assets/img/unnamed.png"),
      backgroundColor: Colors.transparent,
    );
  }

  void _getCustomUserInfo() {
  }
}
