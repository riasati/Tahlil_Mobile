import 'package:flutter/material.dart';
import 'package:samproject/widgets/editProfileFormWidget.dart';

class EditProfilePage extends StatefulWidget {
  final callHomePageBiuld;

  EditProfilePage( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;
  @override
  _EditProfilePageState createState() => _EditProfilePageState(toggleCoinCallback: callHomePageBiuld);
}

class _EditProfilePageState extends State<EditProfilePage> {
  final callHomePageBiuld;

  _EditProfilePageState( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "تغییر مشخصات کاربری",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        leading: BackButton(
          color: Colors.white,
          //  onPressed: () => Navigator.pop(context),
        ),
      ),
      //backgroundColor: ,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  EditProfileFormWidget(toggleCoinCallback: callHomePageBiuld,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
