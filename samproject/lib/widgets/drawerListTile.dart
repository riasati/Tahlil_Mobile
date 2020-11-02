import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/LoginSignupPage/LoginPage.dart';
import 'package:samproject/pages/editProfilePage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawerListTile extends StatefulWidget {
  @override
  _DrawerListTileState createState() => _DrawerListTileState();
}
class _DrawerListTileState extends State<DrawerListTile> {
  String token;
  void getToken() async
  {
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
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
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
        ListTile(
          //leading: Icon(Icons.alarm),
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.cake),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text('آیتم'),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            //Navigator.push(
            //  context,
            //  MaterialPageRoute(
            //    builder: (context) => Reminders(),
            //  ),
            //);
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
            HomePage.user.PersonLoggedout();
            Navigator.pop(context);
          },
        ): Container(),
      ],
    );
  }
}