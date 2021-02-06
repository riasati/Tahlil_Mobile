import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/pages/homePage.dart';

class PersonInfo extends StatefulWidget {
  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage:
              (HomePage.user.avatarUrl != null && HomePage.user.avatarUrl.isNotEmpty)?
              NetworkImage(HomePage.user.avatarUrl):
              AssetImage('assets/img/unnamed.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(
            HomePage.user.username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
