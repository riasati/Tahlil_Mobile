import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Person
{
  String _firstname;
  String _lastname;
  String _username;
  String _email;
  String _birthday;
  String _password;
  String _avatarUrl;

  String get avatarUrl => _avatarUrl;
  set avatarUrl(String value) {
    _avatarUrl = value;
  }

  String get firstname => _firstname;
  set firstname(String value) {
    _firstname = value;
  }


  String get lastname => _lastname;
  set lastname(String value) {
    _lastname = value;
  }


  String get username => _username;
  set username(String value) {
    _username = value;
  }


  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get birthday => _birthday;
  set birthday(String value) {
    _birthday = value;
  }


  String get password => _password;
  set password(String value) {
    _password = value;
  }
  Person();
  void becomeNullPerson()
  {
    this.firstname = null;
    this.lastname = null;
    this.avatarUrl = null;
    this.email = null;
    this.username = null;
    this.password = null;
  }

  @override
  String toString() {
    return 'Person{_firstname: $_firstname, _lastname: $_lastname, _email: $_email, _avatarUrl: $_avatarUrl}';
  }

//PerosnProfile({this.name = null, this.username = null, this.password = null, this.email = null});
}