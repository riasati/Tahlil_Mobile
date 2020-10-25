import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samproject/classes/personProfile.dart';
import 'package:http/http.dart' as http;



class EditProfileFormWidget extends StatefulWidget {
  @override
  _EditProfileFormWidgetState createState() => _EditProfileFormWidgetState();
}

class _EditProfileFormWidgetState extends State<EditProfileFormWidget> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  PersonProfile _newPerson = PersonProfile();

  TextEditingController _textFormFirstNameController = new TextEditingController();
  TextEditingController _textFormLastNameController = new TextEditingController();
  TextEditingController _textFormUsernameController = new TextEditingController();
  TextEditingController _textFormEmailController = new TextEditingController();
  TextEditingController _textFormPasswordController = new TextEditingController();
  TextEditingController _textFormBirthdayController = new TextEditingController();

  /*Future<String> loadAsset () async
  {
    return await rootBundle.loadString('./assets/profile.json');
  }
  void getProfileInfo()
  {
    Future<String> jsonFile = loadAsset();
    var user = json.decode(jsonFile.toString());
    _newPerson.name = user['name'];
    _newPerson.email = user['emailAddress'];
    _newPerson.username = user['username'];
    _newPerson.password = user['password'];
  }

  TextEditingController _textFormNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getProfileInfo();
    _textFormNameController.text = _newPerson.name;
    print(_textFormNameController.text);
  }

  void _changeTextFormName(String value)
  {
    //  _textFormNameController.text = utf8.decode(_textFormNameController.text.codeUnits);
  }


   */

  void getProfileInfo() async
  {
    final response = await http.get('https://parham-backend.herokuapp.com/test');
    setState(() {
      _textFormFirstNameController.text = response.statusCode.toString();
      print("correct : " + response.body);
      print(response.body);
    });

    //Future<String> jsonFile = loadAsset();
    //var user = json.decode(jsonFile.toString());
    //_newPerson.name = user['name'];
    //_newPerson.email = user['emailAddress'];
    //_newPerson.username = user['username'];
    //_newPerson.password = user['password'];
  }

  void sendData(PersonProfile person) async
  {
    print("in sendData");
    /* final response = await http.post('https://parham-backend.herokuapp.com/user/signup',
        headers: <String, String>{
        'Content-Type': 'application/json'},
        body: jsonEncode(<String,String>{
       //   'user' : new PersonProfile()
          "username" : "riasatfgfdss",
          "firstname": "mohammadmahdi",
          "lastname" : "soori",
          "password": "123456sdfasdsd",
          "email" : "mohammadmahdisoorisdfds@gmail.com",
        }),
    );

    */
    print(person.username);
    final response = await http.put("https://parham-backend.herokuapp.com/user/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': person.firstname,
        'lastname' : person.lastname,
        'username' : person.username,
        'email' : person.email,
      }),
    );
    /* final response = await http.post("https://parham-backend.herokuapp.com/user/login",
        headers: <String, String>{
          'Content-Type': 'application/json'},
        body: jsonEncode(<String,String>{
          //   'user' : new PersonProfile()
          "username" : "riasatfgfdss",
          "password": "123456sdfasdsd",
        }),
    );*/
    if (response.statusCode == 200)
    {
      _textFormFirstNameController.text = response.statusCode.toString();
      print("correct : " + response.body);
      //   print(response.body);
    }
    else
    {
      print("false : " + response.body);
    }
    // else
    //   {
    //     setState(() {
    //       _textFormFirstNameController.text = response.statusCode.toString();
    //       print("false : " + response.body);
    //     });
    //  }
  }

  /*void getToken() async
  {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjkxOTA5ZGE4YjVhNzAwMTc2NjRjY2EiLCJpYXQiOjE2MDM1NjU1NDd9.3__H21zcn0NHRrS1pu_ZbStXJoSAjLdBjqQI-tEH5iY";

    final responce = await http.get("https://parham-backend.herokuapp.com/user/login",
    headers: {HttpHeaders.authorizationHeader: token},);

    //print(responce.body);

    final responseJson = jsonDecode(responce.body);

    //print(responseJson.toString());



  }*/
  @override
  void initState() {
    super.initState();
    //  getProfileInfo();
    // sendData();
    //getToken();
  }

  String _validateUsername(String value) {
    return value.length <= 6 ? 'نام کاربری باید حداقل 6 کاراکتر باشد' : null;
  }
  String _validatePassword(String value)
  {
    return value.length <= 6 ? "رمز ورود باید حداقل 6 کاراکتر باشد" : null;
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
      // sendData(_newPerson);
    }
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
            Icon(Icons.person_rounded,size: 80,), //CircleAvatar() ,
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
                  //focusedBorder: ,
                  //  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple),borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                //   validator: (value) => _validateFirstName(value),
                onSaved: (value) => _newPerson.firstname = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _textFormLastNameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    locale: Locale('fa'),
                  ),
                  decoration: InputDecoration(
                    labelText: "نام خانوادگی",
                    //  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple),borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  //validator: (value) => _validateLastName(value),
                  onSaved: (value) => _newPerson.lastname = value,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _textFormEmailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: "ایمیل",
                    //   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple),borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  validator: (value) => _validateEmail(value),
                  onSaved: (value) => _newPerson.email = value,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _textFormBirthdayController,
                  keyboardType: TextInputType.datetime,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: "تاریخ تولد",
                    //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple),borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  // validator: (value) => _validateEmail(value),
                  onSaved: (value) => _newPerson.birthday = value,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _textFormUsernameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "نام کاربری",
                    //  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple),borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  validator: (value) => _validateUsername(value),
                  onSaved: (value) => _newPerson.username = value,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _textFormPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: "رمز ورود",
                    //  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple),borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  validator: (value) => _validatePassword(value),
                  onSaved: (value) => _newPerson.password = value,
                ),
              ),
            ),

            Divider(height: 32.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  child: Text('انصراف'),
                  color: Colors.red,
                  onPressed: () => {} ,//Navigator.pop(context),
                ),
                RaisedButton(
                  child: Text('تغییرات'),
                  color: Colors.lightGreen,
                  onPressed: () => _submitUser(),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
