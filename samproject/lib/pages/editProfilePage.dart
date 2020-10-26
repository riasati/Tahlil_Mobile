import 'package:flutter/material.dart';
import 'package:samproject/widgets/editProfileFormWidget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.all(25),
                shadowColor: Colors.lightBlue,
                child: Column(
                  children: [
                    EditProfileFormWidget(),
                  ],
                )
            ),
            ],
          ),
        ),
      ),
    );
  }
}
