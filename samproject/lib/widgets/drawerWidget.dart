import 'package:flutter/material.dart';
import 'package:samproject/widgets/drawerListTile.dart';
import 'package:samproject/domain/personProfile.dart';

class DrawerWidget extends StatelessWidget {
  Person person = null ;
  DrawerWidget({
    Key key,
    @required this.person
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
              onDetailsPressed: () => {},
              currentAccountPicture: Icon(
                Icons.face,
                size: 48.0,
                color: Colors.white,
              ),
              accountName: person == null ? Text('نام شما') : Text(person.firstname + " " + person.lastname),
              accountEmail: person == null ? Text('آدرس ایمیل شما') : Text(person.email),
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