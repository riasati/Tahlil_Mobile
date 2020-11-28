class SumNotification{
  String _id;
  String _title;
  String _body;

  SumNotification(this._id, this._title, this._body);

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  String toString() {
    return 'SumNotification{_id: $_id, _title: $_title, _body: $_body}';
  }
}