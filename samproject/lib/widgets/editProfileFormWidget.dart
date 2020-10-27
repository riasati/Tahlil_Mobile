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


   */

  void getProfileInfo() async
  {
    final prefs = await SharedPreferences.getInstance();
   // prefs.setString("token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk");
    String token = prefs.getString("token");
    //String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk";

    final response = await http.put('https://parham-backend.herokuapp.com/user/update',
        headers: {HttpHeaders.authorizationHeader: token},
    );

    if (response.statusCode == 200)
    {
      final responseJson = jsonDecode(response.body);
      _newPerson.firstname = responseJson['user']['firstname'];
      _newPerson.lastname = responseJson['user']['lastname'];
      _newPerson.username = responseJson['user']['username'];
      _newPerson.email = responseJson['user']['email'];
      //_newPerson.password = responseJson['user']['password'];
      _textFormFirstNameController.text = _newPerson.firstname;
      _textFormLastNameController.text = _newPerson.lastname;
      _textFormUsernameController.text = _newPerson.username;
      _textFormEmailController.text = _newPerson.email;

    }
    else
    {
      print("false : " + response.body);
    }

    //Future<String> jsonFile = loadAsset();
    //var user = json.decode(jsonFile.toString());
    //_newPerson.name = user['name'];
    //_newPerson.email = user['emailAddress'];
    //_newPerson.username = user['username'];
    //_newPerson.password = user['password'];
  }

  void sendData() async
  {
    final prefs = await SharedPreferences.getInstance();
    //prefs.setString("token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk");
    String token = prefs.getString("token");
   // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk";

    final response = await http.put('https://parham-backend.herokuapp.com/user/update',
      headers: {
        'accept': 'application/json',
        'Authorization': token,
        'Content-Type': 'application/json',
      },
      // "Bearer" + " " + token
       body: jsonEncode(<String,String>{
      //   "username": "riasat3",
      //   "password": "12345678",
      //   "firstname": "mohammadmahdi",
      //   "lastname": "soori",
      //   "email": "mohammadmahdisoori.10@gmail.com"
       })
    );
    if (response.statusCode == 200){
      print("correct : " + response.body);
    }
    else
      {print("false : " + response.body);}
   // print("in sendData");
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
    // print(person.username);
    // final response = await http.put("https://parham-backend.herokuapp.com/user/login",
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'firstname': person.firstname,
    //     'lastname' : person.lastname,
    //     'username' : person.username,
    //     'email' : person.email,
    //   }),
    // );

    //  final response = await http.post("https://parham-backend.herokuapp.com/user/signup",
    //     headers: <String, String>{
    //       'Content-Type': 'application/json'},
    //     body: jsonEncode(<String,String>{
    //       //   'user' : new PersonProfile()
    //       "username": "riasat2",
    //       "firstname": "mohammadmahdi",
    //       "lastname": "soori",
    //       "password": "12345678",
    //       "email": "mohammadmahdisoori.10@gmail.com"
    //     }),
    // );
    //  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk";

    //  final response = await http.post("https://parham-backend.herokuapp.com/user/login",
    //     headers: <String, String>{
    //       'Content-Type': 'application/json'},
    //     body: jsonEncode(<String,String>{
    //       //   'user' : new PersonProfile()
    //       "username": "riasat2",
    //       "password": "12345678",
    //     }),
    // );


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
  void getImageUrl() async
  {
    final prefs = await SharedPreferences.getInstance();
    //prefs.setString("token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk");
    String token = prefs.getString("token");
    // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk";
    final response = await http.get('https://parham-backend.herokuapp.com/user/avatar',
      headers: {HttpHeaders.authorizationHeader: token},
    );
    if (response.statusCode == 200){
      final responseJson = jsonDecode(response.body);
      print("correct : " + response.body);
      setState(() {
        _newPerson.avatarUrl = responseJson['avatar'];
      });
    }
    else
    {print("false : " + response.body);}
  }
  void setImageToServer(File profileImage) async
  {
    final prefs = await SharedPreferences.getInstance();
    //prefs.setString("token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk");
    String token = prefs.getString("token");
    // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjk2ODY5ZjA1NDVjOTAwMTc4NDU3OWIiLCJpYXQiOjE2MDM3MDAzODN9.oGFAZsQOAFVeDUuFLPVnIxi_ywgym4l4JcpSgikCIqk";
    if (profileImage == null) return;
    String base64Image = base64Encode(profileImage.readAsBytesSync());
    String fileName = profileImage.path.split("/").last;

    // final response = await http.put('https://parham-backend.herokuapp.com/user/update/avatar',
    //   headers: <String, String>{
    //       'Content-Type': 'multipart/form-data',
    //       'Authorization' : token,
    //       'accept': 'application/json',
    //     },
    //   body: {
    //     'image' : base64Image,
    //     'name' : fileName,
    //   }
    // );
    // if (response.statusCode == 200){
    //   print("correct : " + response.body);
    //   final responseJson = jsonDecode(response.body);
    //   _newPerson.avatarUrl = responseJson['user']['avatar'];
    // }
    // else
    // {print("false : " + response.body);}

  }
  @override
  void initState() {
    super.initState();
    //  getProfileInfo();
    // sendData();
    getImageUrl();
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
   //   setImageToServer(_ProfileImage);
      // sendData(_newPerson);
    }
  }

  File _ProfileImage;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _ProfileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //bool _imageSelcted = false;
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
                       // Image(image: AssetImage("assets/images/unnamed.png"),alignment: Alignment.bottomLeft,),
                       // _ProfileImage != null ? ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),) :Container()
                       if (_ProfileImage == null && _newPerson.avatarUrl == null) Image(image: AssetImage("assets/images/unnamed.png"),alignment: Alignment.bottomLeft,)
                       else if (_ProfileImage != null  && _newPerson.avatarUrl == null) ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),)
                       else if (_ProfileImage == null  && _newPerson.avatarUrl != null) ClipOval(child : Image.network(_newPerson.avatarUrl,fit: BoxFit.cover,alignment: Alignment.center,width: 200,))
                       else if (_ProfileImage != null && _newPerson.avatarUrl != null) ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),),
                       // _newPerson.avatarUrl==null ? (_ProfileImage != null ? ClipOval(child:Image.file(_ProfileImage,fit: BoxFit.cover,alignment: Alignment.center,width: 200,),) :Container())
                       //     : ClipOval(child : Image.network(_newPerson.avatarUrl,fit: BoxFit.cover,alignment: Alignment.center,width: 200,))

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
                padding: const EdgeInsets.all(0.0),
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
                padding: const EdgeInsets.all(0.0),
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
                padding: const EdgeInsets.all(0.0),
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
                padding: const EdgeInsets.all(0.0),
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
                padding: const EdgeInsets.all(0.0),
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
                // RaisedButton(
                //   child: Text('انصراف'),
                //   color: Colors.red,
                //   onPressed: () => {} ,//Navigator.pop(context),
                // ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: RaisedButton(
                    child:Text('تغییرات',style: TextStyle(color: Colors.white),),

                    //child: SizedBox(child: Text('تغییرات',style: TextStyle(color: Colors.white),),),
                    // child: Row(
                    //   children : [Text('تغییرات',style: TextStyle(color: Colors.white),),],
                    //   mainAxisSize: MainAxisSize.max,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //
                    // ),
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
