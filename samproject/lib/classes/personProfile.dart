class PersonProfile
{
  String _firstname;
  String get firstname => _firstname;
  set firstname(String value) {
    _firstname = value;
  }

  String _lastname;
  String get lastname => _lastname;
  set lastname(String value) {
    _lastname = value;
  }

  String _username;
  String get username => _username;
  set username(String value) {
    _username = value;
  }

  String _email;
  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String _birthday;
  String get birthday => _birthday;

  set birthday(String value) {
    _birthday = value;
  }

  String _password;
  String get password => _password;
  set password(String value) {
    _password = value;
  }
  PersonProfile();
//PerosnProfile({this.name = null, this.username = null, this.password = null, this.email = null});
}