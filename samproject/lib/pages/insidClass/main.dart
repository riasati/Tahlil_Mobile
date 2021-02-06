// import 'package:flutter/material.dart';
// import 'package:samproject/pages/insidClass/ClassExams.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       child: new Column(
//         children: <Widget>[
//           new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
//           new InkWell(
//             child: new Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 new Text(
//                   flag ? "show more" : "show less",
//                   style: new TextStyle(color: Colors.blue),
//                 ),
//               ],
//             ),
//             onTap: () {
//               setState(() {
//                 flag = !flag;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
