import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateClassButton extends StatefulWidget {
  @override
  _CreateClassButtonState createState() => _CreateClassButtonState();
}

class _CreateClassButtonState extends State<CreateClassButton> {
  final TextEditingController classTitleController = TextEditingController();
  final TextEditingController classDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Gradient _gradient = LinearGradient(colors: [Colors.green, Colors.green]);
    return Container(
      width: double.infinity,
      height: 40,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(40.0)),
              gradient: _gradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ]),
          child: Material(
            color: Colors.transparent,
            borderRadius: new BorderRadius.all(Radius.circular(40.0)),
            child: FlatButton(
                onPressed: createBottomSheet,
                child: Center(
                  child: Text(
                    "ساخت کلاس جدید",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  void createBottomSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      )),
      barrierColor: Colors.green.withOpacity(0.8),
      builder: (context) => Column(
            children: [
              Expanded(
                child: Padding(padding: EdgeInsets.only(top: 10),child: Image.asset("assets/img/login_logo.png")),

              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          controller: classTitleController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color(0xFF3D5A80), width: 3)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF3D5A80)),
                              ),
                              suffixIcon: Icon(
                                FontAwesomeIcons.chalkboard,
                                color: Colors.black,
                              ),
                              labelText: 'عنوان کلاس',
                              labelStyle: TextStyle(color: Color(0xFF3D5A80))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        controller: classDescriptionController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            focusedBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color(0xFF3D5A80), width: 3)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF3D5A80)),
                            ),
                            suffixIcon: Icon(
                              FontAwesomeIcons.fileSignature,
                              // FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            labelText: 'توضیحات',
                            labelStyle: TextStyle(color: Color(0xFF3D5A80))),
                      ),
                    ),
                  ),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                    child: RoundedLoadingButton(
                  color: Color(0xFF3D5A80),
                  //controller: btnJoin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "ساخت کلاس",
                      style: TextStyle(
                        color: Colors.white,
                        // fontSize: MediaQuery.of(context).size.width * 0.045,
                        // fontFamily: "WorkSansBold"
                      ),
                    ),
                  ),
                  onPressed: _pressCreate,
                )),
              ))
            ],
          ));

  void _pressCreate() {}
}
