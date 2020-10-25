import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PerosnProfile
{
  String _name;
  String _username;
  String _password;
  String _email;

  PerosnProfile();
  //PerosnProfile({this.name = null, this.username = null, this.password = null, this.email = null});

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set username(String value) {
    _username = value;
  }

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  String get password => _password;

  String get username => _username;

  String get name => _name;
}

class EditProfileFormWidget extends StatefulWidget {
  @override
  _EditProfileFormWidgetState createState() => _EditProfileFormWidgetState();
}

class _EditProfileFormWidgetState extends State<EditProfileFormWidget> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  PerosnProfile _newPerson = PerosnProfile();

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
  String _validateUsername(String value) {
    return value.isEmpty ? 'نام کاربری لازم است' : null;
  }
  String _validatePassword(String value)
  {
    return value.isEmpty ? "رمز ورود لازم است" : null;
  }
  String _validateName(String value)
  {
    bool Isbig = value.length > 25 ;
    return Isbig ? "نام بزرگ است" : null;
  }
  String _validateEmail(String value)
  {
    bool Isbig = value.length > 25 ;
    return Isbig ? "نام بزرگ است" : null;
  }
  void _submitUser() {
    if(_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();
      print('UserName: ${_newPerson.username}');
      print('PassWord: ${_newPerson.password}');
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
          children: [Row(
              children : [
                Expanded(
                    flex: 1,
                    child: Icon(Icons.person_rounded,size: 80,) //CircleAvatar()
                ),
                Expanded(
                  flex: 3,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                     // controller: _textFormNameController,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "نام و نام خانوادگی"
                      ),
                      validator: (value) => _validateName(value),
                      onSaved: (value) => _newPerson.name = value,
                     // onChanged: (value) => _changeTextFormName(value),
                    ),
                  ),
                ),
              ]
          ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "ایمیل"
                ),
                validator: (value) => _validateEmail(value),
                onSaved: (value) => _newPerson.email = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  locale: Locale('fa'),
                ),
                decoration: InputDecoration(
                    labelText: "نام کاربری"
                ),
                validator: (value) => _validateUsername(value),
                onSaved: (value) => _newPerson.username = value,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    labelText: "رمز ورود"
                ),
                validator: (value) => _validatePassword(value),
                onSaved: (value) => _newPerson.password = value,
              ),
            ),

            Divider(height: 32.0,),
            //Text("Hello",style: TextStyle(fontSize: 50),),
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
