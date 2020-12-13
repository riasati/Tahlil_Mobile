import 'package:samproject/domain/question.dart';

class Exam{
  String _examId;
  String _name;
  DateTime _startDate;
  DateTime _endDate;
  int _examLength;
  List<Question> _questions = [];


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

  List<Question> get questions => _questions;

  set questions(List<Question> value) {
    _questions = value;
  }

  @override
  String toString() {
    return 'Exam{_examId: $_examId, _name: $_name, _startDate: $_startDate, _endDate: $_endDate, _examLength: $_examLength, _questions: $_questions}';
  }
}