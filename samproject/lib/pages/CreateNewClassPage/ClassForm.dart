import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/pages/CreateNewClassPage/ComponentOfClassForm/ClassDescription.dart';
import 'package:samproject/pages/CreateNewClassPage/ComponentOfClassForm/ClassPassword.dart';
import 'ComponentOfClassForm/ClassTitle.dart';


class ClassForm extends StatefulWidget {
  @override
  _ClassFormState createState() => _ClassFormState();
}

class _ClassFormState extends State<ClassForm> {
  String _selectionGrade;

  final TextEditingController classPasswordController = TextEditingController();
  final TextEditingController classDescriptionController = TextEditingController();
  final TextEditingController classTitleController = TextEditingController();
  final TextEditingController classIdController = TextEditingController();

  final RoundedLoadingButtonController btnCreate = new RoundedLoadingButtonController();

  bool _obscureTextClassPassword = true;
  bool _passwordAlarmVisible = false;

  @override
  void initState() {
    super.initState();
    classPasswordController.addListener(_classPasswordController);
    classDescriptionController.addListener(_classDescriptionController);
    classTitleController.addListener(_classTitleController);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ClassTitle(),
            Padding(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _ClassGrade()),
                ],
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            _ClassId(),
            _ClassPassword(),
            _ClassDescription(),
            _CreateButton(),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ClassTitle(){
    return Padding(
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
              style: TextStyle(
                  color: Colors.black),
              decoration: InputDecoration(
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0xFF3D5A80) , width: 3)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3D5A80)),
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.chalkboard,
                    color: Colors.black,
                  ),
                  labelText: 'عنوان کلاس',
                  labelStyle: TextStyle(
                      color: Color(0xFF3D5A80)
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ClassDescription(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              textAlign: TextAlign.right,
              maxLines: 4,
              controller: classDescriptionController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: Colors.black),
              decoration: InputDecoration(
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0xFF3D5A80) , width: 3)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3D5A80)),
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.fileSignature,
                    // FontAwesomeIcons.envelope,
                    color: Colors.black,
                  ),
                  labelText: 'توضیحات',
                  labelStyle: TextStyle(
                      color: Color(0xFF3D5A80)
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ClassPassword(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              textAlign: TextAlign.right,
              maxLines: 1,
              obscureText: _obscureTextClassPassword,
              controller: classPasswordController,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  color: Colors.black),
              decoration: InputDecoration(
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: _passwordAlarmVisible?Colors.red:Color(0xFF3D5A80) , width: 3)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3D5A80)),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: _toggleSignupConfirm,
                    child: Icon(
                      _obscureTextClassPassword
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      color: Colors.black,
                    ),
                  ),
                  helperText: _passwordAlarmVisible == true?'رمز عبور باید حداقل ۶ کاراکتر باشد':"",
                  helperStyle: TextStyle(
                    color: Colors.red,
                  ),
                  labelText: 'رمز عبور',
                  labelStyle: TextStyle(
                      color: Color(0xFF3D5A80)
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ClassId(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              textAlign: TextAlign.right,
              maxLines: 1,
              controller: classIdController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: Colors.black),
              decoration: InputDecoration(
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Color(0xFF3D5A80) , width: 3)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3D5A80)),
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.fingerprint,
                    color: Colors.black,
                  ),
                  labelText: 'شناسه کلاس',
                  labelStyle: TextStyle(
                      color: Color(0xFF3D5A80)
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ClassGrade(){
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          _selectionGrade = value;
        });
      },
      child: Container(
        color: Color(0xFF3D5A80),
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.add_alarm,
                  //size: 1,
                  // onPressed: () {
                  //   print('Hello world');
                  // },
                ),
              ),
              Text(_selectionGrade == null ? 'پایه تحصیلی' : _selectionGrade.toString()),
            ],
            // subtitle: Column(
            //   children: <Widget>[
            //     Text('Sub title'),
            //     Text(),
            //   ],
            // ),
          ),
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Value1',
          child: Text('Choose value 1'),
        ),
        const PopupMenuItem<String>(
          value: 'Value2',
          child: Text('Choose value 2'),
        ),
        const PopupMenuItem<String>(
          value: 'Value3',
          child: Text('Choose value 3'),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names,
  Widget _CreateButton(){
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
          //width: MediaQuery.of(context).size.width * 0.5,
          //margin: EdgeInsets.only(top: 200.0),
          // decoration: new BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //   gradient: new LinearGradient(
          //       colors: [
          //         // Theme.Colors.loginGradientEnd,
          //         // Theme.Colors.loginGradientStart
          //         Colors.orange[900],
          //         Colors.orange[900],
          //       ],
          //       begin: const FractionalOffset(0.2, 0.2),
          //       end: const FractionalOffset(1.0, 1.0),
          //       stops: [0.0, 1.0],
          //       tileMode: TileMode.clamp),
          // ),
          child: RoundedLoadingButton(
            // curve: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
            color: Color(0xFF3D5A80),
            controller: btnCreate,
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
          )
      ),
    );
  }

  void _classPasswordController() {
    if(!_checkPassword(classPasswordController.text)){
      setState(() {
        _passwordAlarmVisible = true;
      });
    }
    else{
      setState(() {
        _passwordAlarmVisible = false;
      });

    }
  }

  bool _checkPassword(String text) {
    if(text.length < 6)
      return false;
    else
      return true;
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextClassPassword = !_obscureTextClassPassword;
    });
  }

  void _classDescriptionController() {
  }

  void _classTitleController() {
  }

  void _pressCreate() {
  }
}
