class Person
{
  String _firstname;
  String _lastname;
  String _username;
  String _email;
  String _birthday;
  String _password;

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
//PerosnProfile({this.name = null, this.username = null, this.password = null, this.email = null});
}