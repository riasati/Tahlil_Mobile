import 'package:samproject/domain/question.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Exam{
  String _examId;
  String _name;
  DateTime _startDate;
  DateTime _endDate;
  int _examLength;
  List<Question> _questions = [];


  Exam(this._examId, this._name, this._startDate, this._endDate, this._examLength);


  DateTime CreateDateTimeFromJalali(String JalaliDate,String Time)
  {
    DateTime returnDateTime;
    List<String> dates = JalaliDate.split("/");
    List<String> Times = Time.split(":");
    Jalali j = new Jalali(int.tryParse(dates[0]),int.tryParse(dates[1]),int.tryParse(dates[2]));
    Gregorian g = j.toGregorian();
    if (Times.length == 1)
    {
      returnDateTime = new DateTime(g.year,g.month,g.day,int.tryParse(Times[0]),);
    }
    else
    {
      returnDateTime = new DateTime(g.year,g.month,g.day,int.tryParse(Times[0]),int.tryParse(Times[1]));
    }
    returnDateTime = returnDateTime.subtract(Duration(hours: 3,minutes: 30));
    return returnDateTime;
  }
  String GetJalaliOfServerGregorian(DateTime serverDateTime)
  {
    serverDateTime = serverDateTime.add(Duration(hours: 3,minutes: 30));
    Gregorian g = new Gregorian(serverDateTime.year,serverDateTime.month,serverDateTime.day);
    Jalali j = g.toJalali();
    String jalaliDate = j.year.toString() + "/" + j.month.toString() + "/" + j.day.toString();
    String returnString = jalaliDate + " " + serverDateTime.hour.toString() + ":" + serverDateTime.minute.toString();
    return returnString;
  }
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