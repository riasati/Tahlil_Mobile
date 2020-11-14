import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:samproject/pages/LoginSignupPage/LoginPage.dart';
import 'package:samproject/pages/editProfilePage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawerListTile extends StatefulWidget {
  final callHomePageBiuld;

  DrawerListTile( {@required void toggleCoinCallback() }):
    callHomePageBiuld = toggleCoinCallback;
    @override
    _DrawerListTileState createState() => _DrawerListTileState(toggleCoinCallback: callHomePageBiuld);
}
class _DrawerListTileState extends State<DrawerListTile> {
  final callHomePageBiuld;
  _DrawerListTileState( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;

  String token;
  void getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      this.token = prefs.getString("token");
    });
  }
  @override
  void initState() {
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    print(callHomePageBiuld);
    return Column(
      children: <Widget>[
        (this.token == null) ? ListTile(
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.cake),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text('ثبت نام و ورود'),
              ),
            ],
          ),
          onTap: () {
            Widget loginPage = LoginPage(toggleCoinCallback: callBuild);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => loginPage,
              ),
            );
          },
        ):Container(),
        ListTile(
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(FontAwesomeIcons.userGraduate),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text('تغییر مشخصات کاربری'),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(),
              ),
            );
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          //leading: Icon(Icons.alarm),
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.question_answer),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text('سوالات من'),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => MyQuestionPage(),
             ),
            );
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          title:Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.settings),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text('تنظیمات'),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(color: Colors.grey),
        (this.token != null) ? ListTile(
          title:Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.exit_to_app),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text('خروج'),
              ),
            ],
          ),
          onTap: () {
            PersonLoggedout();
            Navigator.pop(context);
          },
        ): Container(),
      ],
    );
  }

  void PersonLoggedout() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null) return;
    token = "Bearer " + token;
    final response = await post('https://parham-backend.herokuapp.com/user/logout',
      headers: {
        'accept': 'application/json',
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200){
      prefs.setString("token", null);
      HomePage.user.becomeNullPerson();
    }
    widget?.callHomePageBiuld();

  }

  callBuild(){
    widget?.callHomePageBiuld();
  }
}