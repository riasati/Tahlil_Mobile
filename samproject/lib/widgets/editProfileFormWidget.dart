import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samproject/domain/personProfile.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditProfileFormWidget extends StatefulWidget {
  @override
  _EditProfileFormWidgetState createState() => _EditProfileFormWidgetState();
}

class _EditProfileFormWidgetState extends State<EditProfileFormWidget> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Person _newPerson = Person();

  TextEditingController _textFormFirstNameController = new TextEditingController();
  TextEditingController _textFormLastNameController = new TextEditingController();
  TextEditingController _textFormUsernameController = new TextEditingController();
  TextEditingController _textFormEmailController = new TextEditingController();
  TextEditingController _textFormPasswordController = new TextEditingController();
  TextEditingController _textFormBirthdayController = new TextEditingController();

  void getProfileInfo() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {_showMyDialog(false);return;}
    String tokenplus = "Bearer" + " " + token;

    final response = await http.get('https://parham-backend.herokuapp.com/user/',
        headers: {HttpHeaders.authorizationHeader: tokenplus},
    );

    if (response.statusCode == 200)
    {
      final responseJson = jsonDecode(response.body);
      _newPerson.firstname = responseJson['user']['firstname'];
      _newPerson.lastname = responseJson['user']['lastname'];
      _newPerson.username = responseJson['user']['username'];
      _newPerson.email = responseJson['user']['email'];

      _textFormFirstNameController.text = _newPerson.firstname;
      _textFormLastNameController.text = _newPerson.lastname;
      _textFormUsernameController.text = _newPerson.username;
      _textFormEmailController.text = _newPerson.email;
    }
    else{
      _showMyDialog(false);
    }
  }

  void sendData() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {_showMyDialog(false);return;}

    String tokenplus = "Bearer" + " " + token;

    final response = await http.put('https://parham-backend.herokuapp.com/user/update',
      headers: {
        'accept': 'application/json',
        'Authorization': tokenplus,
        'Content-Type': 'application/json',
      },
      //
       body: jsonEncode(<String,String>{
        "username": _newPerson.username,
        "password": _newPerson.password,
        "firstname": _newPerson.firstname,
        "lastname": _newPerson.lastname,
        "email": _newPerson.email
       })
    );
    if (response.statusCode == 200){
       _showMyDialog(true);
    }
    else{
      _showMyDialog(false);
    }
  }
  void getImageUrl() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) return;
    String tokenplus = "Bearer" + " " + token;
    final response = await http.get('https://parham-backend.herokuapp.com/user/avatar',
      headers: {HttpHeaders.authorizationHeader: tokenplus},
    );
    if (response.statusCode == 200){
      final responseJson = jsonDecode(response.body);
      setState(() {
        _newPerson.avatarUrl = responseJson['avatar'];
      });
    }
  }
  void setImageToServer(File profileImage) async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) return;
    if (profileImage == null) {return;}
    String tokenplus = "Bearer" + " " + token;

    String base64Image = base64Encode(profileImage.readAsBytesSync());
    //String fileName = profileImage.path.split("/").last;

    final response = await http.put('https://parham-backend.herokuapp.com/user/update',
      headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization' : tokenplus,
          'accept': 'application/json',
        },
      body: jsonEncode(<String,String>{
        'avatar' : base64Image,
      //  'avatarname' : fileName,
      }
    ));
    if (response.statusCode == 200){
      final responseJson = jsonDecode(response.body);
      _newPerson.avatarUrl = responseJson['user']['avatar'];
    }
  }
  @override
  void initState() {
    super.initState();
    getProfileInfo();
    getImageUrl();
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
    sendData();
    setImageToServer(_ProfileImage);
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
                       if (_ProfileImage == null && _newPerson.avatarUrl == null) Image(image: AssetImage("assets/img/unnamed.png"),alignment: Alignment.bottomLeft,)
                       else if (_ProfileImage != null  && _newPerson.avatarUrl == null) ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),)
                       else if (_ProfileImage == null  && _newPerson.avatarUrl != null) ClipOval(child : Image.network(_newPerson.avatarUrl,fit: BoxFit.cover,alignment: Alignment.center,width: 200,))
                       else if (_ProfileImage != null && _newPerson.avatarUrl != null) ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),),
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
                decoration: InputDecoration(
                  labelText: "نام",
                ),
                onSaved: (value) => _newPerson.firstname = value,
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
                onSaved: (value) => _newPerson.lastname = value,
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
                ),
                validator: (value) => _validateEmail(value),
                onSaved: (value) => _newPerson.email = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _textFormBirthdayController,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "تاریخ تولد",
                ),
                onSaved: (value) => _newPerson.birthday = value,
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
                onSaved: (value) => _newPerson.username = value,
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
                onSaved: (value) => _newPerson.password = value,
              ),
            ),

            Divider(height: 32.0,),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: RaisedButton(
                    child:Text('تغییرات',style: TextStyle(color: Colors.white),),
                    color: Colors.lightBlue,
                    onPressed: () => _submitUser(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
