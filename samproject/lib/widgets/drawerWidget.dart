import 'package:flutter/material.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/widgets/drawerListTile.dart';

class DrawerWidget extends StatefulWidget {
  final callHomePageBiuld;

  DrawerWidget( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState(toggleCoinCallback: callHomePageBiuld);
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final callHomePageBiuld;
  _DrawerWidgetState( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.rtl,
            child: UserAccountsDrawerHeader(
              currentAccountPicture: (HomePage.user.avatarUrl == null) ? Icon(Icons.face , size: 48.0 , color: Colors.white,)
                  :CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.network(
                      HomePage.user.avatarUrl,
                      fit: BoxFit.cover
                  ),
                ),
              ),
              accountName: HomePage.user.username == null ? Text('نام شما') : Text(HomePage.user.username),
              accountEmail: HomePage.user.email == null ? Text('آدرس ایمیل شما') : Text(HomePage.user.email),
              otherAccountsPictures: <Widget>[
                Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                )
              ],
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/images/home_top_mountain.jpg'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
          ),
          DrawerListTile(toggleCoinCallback: callHomePageBiuld,),
        ],
      ),
    );
  }
}
