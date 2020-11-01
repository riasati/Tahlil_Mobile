import 'package:flutter/material.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/widgets/drawerListTile.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String token;
  void getToken() async
  {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    print(token);
  }
  @override
  void initState() {
    super.initState();
    getToken();
  }
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
                  :CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.network(
                      HomePage.user.avatarUrl,
                      fit: BoxFit.cover
                  ),
                ),
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
          DrawerListTile(token: token,),
        ],
      ),
    );
  }
}

// class DrawerWidget extends StatelessWidget {
//   // DrawerWidget({
//   //   Key key,
//   // }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           Directionality(
//             textDirection: TextDirection.rtl,
//             child: UserAccountsDrawerHeader(
//             //  onDetailsPressed: () => {},
//               currentAccountPicture: (HomePage.user.avatarUrl == null) ? Icon(Icons.face , size: 48.0 , color: Colors.white,)
//                   :CircleAvatar(
//                 radius: 70,
//                     child: ClipOval(
//                       child: Image.network(
//                 HomePage.user.avatarUrl,
//                 fit: BoxFit.cover
//               ),
//                     ),
//                   ),
//               // currentAccountPicture:Icon(Icons.face , size: 48.0 , color: Colors.white,),
//               // accountName: HomePage.user == null ? Text('نام شما') : Text(HomePage.user.firstname + " " + HomePage.user.lastname),
//               accountName: HomePage.user.username == null ? Text('نام شما') : Text(HomePage.user.username),
//               accountEmail: HomePage.user.email == null ? Text('آدرس ایمیل شما') : Text(HomePage.user.email),
//               otherAccountsPictures: <Widget>[
//                 Icon(
//                   Icons.bookmark_border,
//                   color: Colors.white,
//                 )
//               ],
//               // decoration: BoxDecoration(
//               //   image: DecorationImage(
//               //     image: AssetImage('assets/images/home_top_mountain.jpg'),
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//             ),
//           ),
//            DrawerListTile(token: token,),
//         ],
//       ),
//     );
//   }
// }