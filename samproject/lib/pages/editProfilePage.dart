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
          //    padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          //  color: Colors.purple,
          child: Text(
            "تغییر مشخصات کاربری",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.red,
              fontSize: 20.0,
              //backgroundColor: Colors.purple,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        leading: BackButton(
          color: Colors.orange,
          //  onPressed: () => Navigator.pop(context),
        ),
      ),
      //backgroundColor: ,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                // color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  /* gradient: RadialGradient(colors: [
                      Colors.amber,
                      Colors.orange,
                    ],
                      radius: 1,
                    )*/
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.amber,
                      Colors.orange,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade800,
                      blurRadius: 10.0,
                      offset: Offset(5.0, 5.0),
                    )
                  ]
              ),
              child: EditProfileFormWidget(),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
