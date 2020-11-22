import 'package:flutter/material.dart';
import 'package:samproject/pages/addQuestionPage.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/insidClass/ClassMembers.dart';
//import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';

import 'InsidClassPage.dart';
import 'classInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InsidClassPage("l_z3DX");
  }
}
