class Exam{
  String _examId;
  String _name;
  DateTime _startDate;
  DateTime _endDate;
  int _examLength;


  Exam(this._examId, this._name, this._startDate, this._endDate, this._examLength);


  String get examId => _examId;

  set examId(String value) {
    _examId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  DateTime get startDate => _startDate;

  int get examLength => _examLength;

  set examLength(int value) {
    _examLength = value;
  }

  DateTime get endDate => _endDate;

  set endDate(DateTime value) {
    _endDate = value;
  }

  set startDate(DateTime value) {
    _startDate = value;
  }
}