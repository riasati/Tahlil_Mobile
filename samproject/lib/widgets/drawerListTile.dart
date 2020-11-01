import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/LoginSignupPage/LoginPage.dart';
import 'package:samproject/pages/editProfilePage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawerListTile extends StatefulWidget {
  String token;
  DrawerListTile({Key key, this.token}) : super(key: key);
  @override
  _DrawerListTileState createState() => _DrawerListTileState();
}
class _DrawerListTileState extends State<DrawerListTile> {
  @override
  void initState() {
    super.initState();
   // print("new page : " + widget.token);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (widget.token == null) ? ListTile(
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
        // (widget.token == null) ? ListTile(
        //   title:Row(
        //     textDirection: TextDirection.rtl,
        //     children: [
        //       Icon(Icons.exit_to_app),
        //       Padding(
        //         padding: const EdgeInsets.only(right: 5.0),
        //         child: Text('خروج'),
        //       ),
        //     ],
        //   ),
        //   onTap: () {
        //     HomePage.user.PersonLoggedout();
        //     setState(() {
        //       print('hello');
        //     });
        //     Navigator.pop(context);
        //   },
        // ): Container(),
      ],
    );
  }
}

/*class DrawerListTile extends StatelessWidget {
	const DrawerListTile({
    Key key,
  }) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
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
        ),
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
        ListTile(
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
            HomePage.user.isPersonLoggedout();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}*/