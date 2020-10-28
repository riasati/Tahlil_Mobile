import 'package:flutter/material.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/widgets/drawerListTile.dart';
import 'package:samproject/domain/personProfile.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.rtl,
            child: UserAccountsDrawerHeader(
            //  onDetailsPressed: () => {},
              currentAccountPicture: (HomePage.user.avatarUrl == null) ? Icon(Icons.face , size: 48.0 , color: Colors.white,)
                  :Image.network(
                HomePage.user.avatarUrl,
                fit: BoxFit.cover
              ),
              // currentAccountPicture:Icon(Icons.face , size: 48.0 , color: Colors.white,),
              // accountName: HomePage.user == null ? Text('نام شما') : Text(HomePage.user.firstname + " " + HomePage.user.lastname),
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
          const DrawerListTile(),
        ],
      ),
    );
  }
}