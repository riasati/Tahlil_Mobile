import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InsidClassPage.dart';

class ClassExams extends StatefulWidget {

  final insidClassPageSetState;

  ClassExams( {@required void toggleCoinCallback() }):
        insidClassPageSetState = toggleCoinCallback;

  @override
  _ClassExamsState createState() => _ClassExamsState();
}

class _ClassExamsState extends State<ClassExams> {

  String _getExamsOfClassInfoURL = "http://parham-backend.herokuapp.com/class/";
  String _removeExamURL = "http://parham-backend.herokuapp.com/class/";
  //List<Person> classMembers = [];

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
        // child: ListTile(
        //   leading: InsidClassPage.isAdmin?adminActions():Icon(Icons.more_vert),
        //   title: Text('حمیدرضا آذرباد', textAlign: TextAlign.right,),
        //
        //   trailing: Text("عنوان آزمون", textAlign: TextAlign.right,),
        // ),
        child: Row(
          children: [
            InsidClassPage.isAdmin?adminActions():memberActions(),
            Padding(child: AutoSizeText('حمیدرضا آذرباد', textAlign: TextAlign.right,), padding: EdgeInsets.only(right: 10),),
            Padding(child: AutoSizeText("عنوان آزمون", textAlign: TextAlign.right,), padding: EdgeInsets.only(right: 10),),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }

  Widget memberActions() {
    return Row(
      children: [
        FlatButton(
          onPressed: (){},
          child: Container(
            color: Color.fromRGBO(14, 145, 140, 1),
            child: Padding(
              child: Center(
                child: AutoSizeText(
                "شرکت در آزمون",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
          ),
              ),
              padding: EdgeInsets.only(left: 2, right: 7, top: 2, bottom: 2),
            ),
        ),
          padding: EdgeInsets.all(0),
        ),
      ],
    );
  }

  Widget adminActions() {
    return PopupMenuButton<String>(
      onSelected: (String value) {
      },
      child: Icon(
        Icons.more_vert,
        size: 35,
        color: Colors.red,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: FlatButton(
            child: Center(child: Text('حذف ازمون', style: TextStyle(color: Colors.red),)),
            padding: EdgeInsets.all(0),
            onPressed: () {
            },
          ),
        ),
        PopupMenuItem<String>(
          child: FlatButton(
            child: Center(child: Text('ویرایش آزمون', style: TextStyle(color: Colors.red),)),
            padding: EdgeInsets.all(0),
            onPressed: () {
            },
          ),
        ),
      ],
    );
  }
}

//   void _getExamsListFromServer() async {
//     InsidClassPage.isLoading = true;
//     widget?.insidClassPageSetState();
//     final prefs = await SharedPreferences.getInstance();
//     print(prefs.getString("token"));
//     String token = prefs.getString("token");
//     try {
//       if (token != null) {
//         token = "Bearer " + token;
//         var url = _getExamsOfClassInfoURL  + InsidClassPage.currentClass.classId + "exams";
//         final response = await get(url,
//             headers: {
//               'accept': 'application/json',
//               'Authorization': token,
//               'Content-Type': 'application/json',
//             });
//         classMembers = [];
//         if(response.statusCode == 200) {
//           var membersInfo = json.decode(
//               utf8.decode(response.bodyBytes))["members"];
//           for (var memberInfo in membersInfo) {
//             Person member = Person();
//             member.firstname = memberInfo["firstname"];
//             member.lastname = memberInfo["lastname"];
//             member.avatarUrl = memberInfo["avatar"];
//             member.username = memberInfo["username"];
//             member.email = memberInfo["email"];
//             classMembers.add(member);
//           }
//           membersListBottomSheet();
//         }else{
//           setState(() {
//             Alert(
//               context: context,
//               type: AlertType.error,
//               title: "عملیات ناموفق بود",
//               buttons: [
//               ],
//             ).show();
//           });
//         }
//       }
//     }on Exception catch(e){
//       print(e.toString());
//       setState(() {
//         Alert(
//           context: context,
//           type: AlertType.error,
//           title: "عملیات ناموفق بود",
//           buttons: [
//           ],
//         ).show();
//       });
//     }
//     InsidClassPage.isLoading = false;
//     widget?.insidClassPageSetState();
// }
