import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class EditProfileFormWidget extends StatefulWidget {
  final callHomePageBiuld;

  EditProfileFormWidget( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;

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

  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  void sendData(File profileImage) async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {ShowCorrectnessDialog(false, context);return;}
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

    final response = await http.put('https://parham-backend.herokuapp.com/user',
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
      ShowCorrectnessDialog(true, context);
      _btnController.stop();
    }
    else{
      ShowCorrectnessDialog(false, context);
      _btnController.stop();
    }
    widget?.callHomePageBiuld();
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

  // String _validateFirstName(String value) {
  //   return value.length < 4 ? 'نام  باید حداقل 4 کاراکتر باشد' : null;
  // }
  //
  // String _validateLastName(String value) {
  //   return value.length < 4 ? 'نام خانوادگی باید حداقل 4 کاراکتر باشد' : null;
  // }
  String _validatePassword(String value)
  {
    if (value.isEmpty == true)
    {
      return null;
    }
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                child: TextFormField(
                  controller: _textFormFirstNameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    locale: Locale('fa'),
                  ),
                   decoration: InputDecoration(
                     labelText: "نام",
                     isCollapsed: true,
                     contentPadding:EdgeInsets.only(right: 12,top: 10,bottom: 5,left: 12),
                     border: OutlineInputBorder(),
                   ),
                  onSaved: (value) => HomePage.user.firstname = value,
             //     validator: (value) => _validateFirstName(value),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                child: TextFormField(
                  controller: _textFormLastNameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    locale: Locale('fa'),
                  ),
                  decoration: InputDecoration(
                    labelText: "نام خانوادگی",
                    isCollapsed: true,
                    contentPadding:EdgeInsets.only(right: 12,top: 10,bottom: 5,left: 12),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => HomePage.user.lastname = value,
             //     validator: (value) => _validateLastName(value),
                ),
              ),
            ),
            // Directionality(
            //   textDirection: TextDirection.rtl,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            //     child: TextFormField(
            //       controller: _textFormBirthdayController,
            //       keyboardType: TextInputType.datetime,
            //       textAlign: TextAlign.right,
            //       decoration: InputDecoration(
            //         labelText: "تاریخ تولد",
            //         isCollapsed: true,
            //         contentPadding:EdgeInsets.only(right: 12,top: 10,bottom: 5,left: 12),
            //         border: OutlineInputBorder(),
            //       ),
            //       onSaved: (value) => HomePage.user.birthday = value,
            //     ),
            //   ),
            // ),
            Divider(height: 10.0,),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                child: TextFormField(
                  controller: _textFormEmailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: "ایمیل",
                    isCollapsed: true,
                    contentPadding:EdgeInsets.only(right: 12,top: 10,bottom: 5,left: 12),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validateEmail(value),
                  onSaved: (value) => HomePage.user.email = value,
                ),
              ),
            ),

            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                child: TextFormField(
                  controller: _textFormUsernameController,
                  keyboardType: TextInputType.text,
                  //scrollPadding:
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding:EdgeInsets.only(right: 12,top: 10,bottom: 5,left: 12),
                    labelText: "نام کاربری",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validateUsername(value),
                  onSaved: (value) => HomePage.user.username = value,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                child: TextFormField(
                  controller: _textFormPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: "رمز ورود",
                    isCollapsed: true,
                    contentPadding:EdgeInsets.only(right: 12,top: 10,bottom: 5,left: 12),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validatePassword(value),
                  onSaved: (value) => HomePage.user.password = value,
                ),
              ),
            ),

            Divider(height: 32.0,),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: RoundedLoadingButton(
                    height: 40,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('تغییر',style: TextStyle(color: Colors.white),),
                        Icon(Icons.build,color: Colors.white,),
                      ],
                    ),//Text('تغییرات',style: TextStyle(color: Colors.white),),
                    //borderRadius: 0,
                    controller: _btnController,
                    color: Color(0xFF3D5A80),
                    onPressed: () => _submitUser(),
                  )
                ),
          ],
        ),
      ),
    );
  }
}
