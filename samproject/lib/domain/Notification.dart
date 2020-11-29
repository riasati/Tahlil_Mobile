class SumNotification{
  String _id;
  String _title;
  String _body;
  DateTime _createTime;


  SumNotification(this._id, this._title, this._body, this._createTime);

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


  DateTime get createTime => _createTime;

  set createTime(DateTime value) {
    _createTime = value;
  }

  @override
  String toString() {
    return 'SumNotification{_id: $_id, _title: $_title, _body: $_body}';
  }
}