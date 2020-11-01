import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditProfileFormWidget extends StatefulWidget {
  @override
  _EditProfileFormWidgetState createState() => _EditProfileFormWidgetState();
}

class _EditProfileFormWidgetState extends State<EditProfileFormWidget> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  TextEditingController _textFormFirstNameController = new TextEditingController();
  TextEditingController _textFormLastNameController = new TextEditingController();
  TextEditingController _textFormUsernameController = new TextEditingController();
  TextEditingController _textFormEmailController = new TextEditingController();
  TextEditingController _textFormPasswordController = new TextEditingController();
  TextEditingController _textFormBirthdayController = new TextEditingController();

  void sendData(File profileImage) async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {_showMyDialog(false);return;}
    String tokenplus = "Bearer" + " " + token;
    dynamic data;

    if (profileImage == null)
    {
      data = jsonEncode(<String,String>{"username": HomePage.user.username,
        "password": HomePage.user.password,
        "firstname": HomePage.user.firstname,
        "lastname": HomePage.user.lastname,
        "email": HomePage.user.email,});
    }
    else
      {
        String base64Image = base64Encode(profileImage.readAsBytesSync());
        data = jsonEncode(<String,String>{
          "username": HomePage.user.username,
          "password": HomePage.user.password,
          "firstname": HomePage.user.firstname,
          "lastname": HomePage.user.lastname,
          "email": HomePage.user.email,
          "avatar" : base64Image,
        });
      }

    final response = await http.put('https://parham-backend.herokuapp.com/user/update',
      headers: {
        'accept': 'application/json',
        'Authorization': tokenplus,
        'Content-Type': 'application/json',
      },
      //
       body: data
    );
    if (response.statusCode == 200){
      final responseJson = jsonDecode(response.body);
      HomePage.user.avatarUrl = responseJson['user']['avatar'];
      _showMyDialog(true);
    }
    else{
      _showMyDialog(false);
    }
  }


  @override
  void initState() {
    super.initState();
    initializeTextForm();
  }

  void initializeTextForm()
  {
    if (HomePage.user.username == null || HomePage.user.email == null) return;
    _textFormUsernameController.text = HomePage.user.username;
    _textFormEmailController.text = HomePage.user.email;
    if (HomePage.user.firstname == null) return;
    _textFormFirstNameController.text = HomePage.user.firstname;
    if (HomePage.user.lastname == null) return;
    _textFormLastNameController.text = HomePage.user.lastname;
  }

  String _validateUsername(String value) {
    return value.length < 6 ? 'نام کاربری باید حداقل 6 کاراکتر باشد' : null;
  }
  String _validatePassword(String value)
  {
    return value.length < 6 ? "رمز ورود باید حداقل 6 کاراکتر باشد" : null;
  }

  String _validateEmail(String value)
  {
    String emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailRegex);
    return !regExp.hasMatch(value) ? "ایمیل صحیح نیست" : null;
  }
  void _submitUser() {
    if(_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();
    sendData(_ProfileImage);
    }
  }
  Future<void> _showMyDialog(bool good) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (good) ? Text('صحیح',textDirection: TextDirection.rtl,) : Text('خطا',textDirection: TextDirection.rtl,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                (good)? Text("اطلاعات با موفقیت ثبت شدند",textDirection: TextDirection.rtl,) : Text("مشکلی وجود دارد امکان دارد ثبت نام و ورود نکرده باشید",textDirection: TextDirection.rtl,),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('باشه',textDirection: TextDirection.rtl,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  File _ProfileImage;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _ProfileImage = File(pickedFile.path);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formStateKey,
      autovalidate: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
                onPressed: () => getImage(),
                 child: CircleAvatar(
                   radius: 70,
                   backgroundColor: Colors.white,
                   child: Stack(
                     children: [
                       if (_ProfileImage == null && HomePage.user.avatarUrl == null) Image(image: AssetImage("assets/img/unnamed.png"),alignment: Alignment.bottomLeft,)
                       else if (_ProfileImage != null  && HomePage.user.avatarUrl == null) ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),)
                       else if (_ProfileImage == null  && HomePage.user.avatarUrl != null) ClipOval(child:Image.network(HomePage.user.avatarUrl,fit: BoxFit.cover,alignment: Alignment.center,width: 200,))
                       else if (_ProfileImage != null && HomePage.user.avatarUrl != null) ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),),
                     ],
                   ),
                 )
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textFormFirstNameController,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.right,
                style: TextStyle(
                  locale: Locale('fa'),
                ),
                textAlignVertical: TextAlignVertical.center,
                //toolbarOptions: ToolbarOptions(copy: true,cut: true,paste: true,selectAll: true),
                 decoration: InputDecoration(
                  // filled: true,
                   isCollapsed: true,
                  // fillColor: Colors.amber,
                   hintText: "نام",
                    prefixIcon: Icon(FontAwesomeIcons.userGraduate),
                    // labelText: "نام",
                    // alignLabelWithHint: true,
                   //border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
                   border: InputBorder.none
                 ),
                onSaved: (value) => HomePage.user.firstname = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textFormLastNameController,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.right,
                style: TextStyle(
                  locale: Locale('fa'),
                ),
                decoration: InputDecoration(
                  labelText: "نام خانوادگی",
                ),
                onSaved: (value) => HomePage.user.lastname = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textFormEmailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "ایمیل",
                    filled: true,
                    //isCollapsed: true,
                    fillColor: Colors.amber,
                //  isCollapsed: true,
                    border: InputBorder.none
                ),
                validator: (value) => _validateEmail(value),
                onSaved: (value) => HomePage.user.email = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textFormBirthdayController,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.right,
                // style: TextStyle(
                //   fontSize: 20,
                // ),
                decoration: InputDecoration(
                  labelText: "تاریخ تولد",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => HomePage.user.birthday = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textFormUsernameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "نام کاربری",
                ),
                validator: (value) => _validateUsername(value),
                onSaved: (value) => HomePage.user.username = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textFormPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "رمز ورود",
                ),
                validator: (value) => _validatePassword(value),
                onSaved: (value) => HomePage.user.password = value,
              ),
            ),

            Divider(height: 32.0,),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: RaisedButton(
                    child:Text('تغییرات',style: TextStyle(color: Colors.white),),
                    color: Color(0xFF3D5A80),
                    onPressed: () => _submitUser(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
