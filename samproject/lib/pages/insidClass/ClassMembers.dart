
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:samproject/pages/insidClass/InsidClassPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassMembers extends StatefulWidget {

  final insidClassPageSetState;

  ClassMembers( {@required void toggleCoinCallback() }):
        insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassMembersState createState() => _ClassMembersState();
}

class _ClassMembersState extends State<ClassMembers> {
  bool isLoading = false;
  String _getMembersOfClassInfoURL = "http://parham-backend.herokuapp.com/class/";
  String _removeMemberURL = "http://parham-backend.herokuapp.com/class/";
  List<Person> classMembers = [];

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
            _getMembersListFromServer();
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

  void _getMembersListFromServer() async {
    InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _getMembersOfClassInfoURL  + InsidClassPage.currentClass.classId + "/members";
        final response = await get(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        classMembers = [];
        if(response.statusCode == 200) {
          var membersInfo = json.decode(
              utf8.decode(response.bodyBytes))["members"];
          for (var memberInfo in membersInfo) {
            Person member = Person();
            member.firstname = memberInfo["firstname"];
            member.lastname = memberInfo["lastname"];
            member.avatarUrl = memberInfo["avatar"];
            member.username = memberInfo["username"];
            member.email = memberInfo["email"];
            classMembers.add(member);
          }
          membersListBottomSheet();
        }else{
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
    InsidClassPage.isLoading = false;
    widget?.insidClassPageSetState();
  }

  void membersListBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )
      ),
      barrierColor: Colors.black45.withOpacity(0.8),
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
    return ListView.builder(
      itemCount: classMembers.length,
        itemBuilder: (BuildContext context, int index) {
          return eachMemberCard(classMembers[index]);
        }
    );
  }

  Widget eachMemberCard(Person member){
    return Card(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        minWidth: double.infinity,
        onPressed: () {
          if(InsidClassPage.isAdmin)
            _showCompleteUserInfo(member);
        },
        child: ListTile(
          leading: InsidClassPage.isAdmin?_userFunctionForAdmin(member):Text(""),
          title: Text(member.firstname + " " + member.lastname, textAlign: TextAlign.right,),
          //trailing: FlutterLogo(size: 45,),
          trailing: eachMemberCardAvatar(member.avatarUrl),
        ),
      ),
    );
  }

  Widget _userFunctionForAdmin(Person member){
    return PopupMenuButton<String>(
      onSelected: (String value) {
      },
      child: Icon(
        Icons.more_vert,
        size: 35,
        color: Colors.red,
        //size: 1,
        // onPressed: () {
        //   print('Hello world');
        // },
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
         PopupMenuItem<String>(
          child: FlatButton(
            child: Center(child: Text('حذف کاربر', style: TextStyle(color: Colors.red),)),
            padding: EdgeInsets.all(0),
            onPressed: () {
              _checkRemoveMember( member);
            },
          ),
        ),
      ],
    );
  }

  void _checkRemoveMember( Person member){
    setState(() {
      Alert(
          context: context,
          type: AlertType.warning,
          title: "مایل به ادامه کار هستید؟",
          // content: Column(
          //   children: [
          //     Text(member.username),
          //     Text(member.firstname + " " + member.lastname , textAlign: TextAlign.end,)
          //   ],
          // ),
          buttons: [
            DialogButton(
              child: Text("بله"),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop();
                _removeMember(member);
              },
              color: Colors.amber,
            ),
            //DialogButton(child: Text("خیر"), onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, color: Colors.amber,),

          ]
      ).show();
    });
  }

  void _removeMember(Person member) async {
    Navigator.pop(context);
    Navigator.pop(context);
    InsidClassPage.isLoading = true;
    widget?.insidClassPageSetState();
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    String token = prefs.getString("token");
    try {
      if (token != null) {
        token = "Bearer " + token;
        var url = _removeMemberURL  + InsidClassPage.currentClass.classId + "/members/" + member.username;
        print(url);
        final response = await delete(url,
            headers: {
              'accept': 'application/json',
              'Authorization': token,
              'Content-Type': 'application/json',
            });
        if(response.statusCode == 200){
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "عملیات موفق بود",
              buttons: [
              ],
            ).show();
          });
        }
        else{
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
    InsidClassPage.isLoading = false;
    widget?.insidClassPageSetState();
  }

  Widget eachMemberCardAvatar(String avatarUrl){
    if(avatarUrl == null){
      return CircleAvatar(
        radius: 30.0,
        backgroundImage:
        AssetImage("assets/img/unnamed.png"),
        backgroundColor: Colors.transparent,
      );
    }
    try{
      return CircleAvatar(
        radius: 30.0,
        backgroundImage:
        NetworkImage(avatarUrl),
        backgroundColor: Colors.transparent,
      );
    }on Exception catch(e){
      return CircleAvatar(
        radius: 30.0,
        backgroundImage:
        AssetImage("assets/img/unnamed.png"),
        backgroundColor: Colors.transparent,
      );
    }

  }

  Future<void> _showCompleteUserInfo(Person member) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image(
            image: AssetImage("assets/img/unnamed.png"),
            height: 100,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AutoSizeText(member.username + " :نام کاربری", style: TextStyle(), textAlign: TextAlign.right, maxLines: 1,),
                AutoSizeText(member.email + ' :ایمیل', style: TextStyle(), textAlign: TextAlign.right,maxLines: 1,),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     style: ButtonStyle(
          //
          //     ),
          //     child: Text('Approve'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

}