
import 'package:samproject/domain/UserAnswer.dart';

class UserAnswerLong extends UserAnswer{

  String _answerText = "";
  String _answerFile;

  String get answerText => _answerText;

  set answerText(String value) {
    _answerText = value;
  }

  String get answerFile => _answerFile;

  set answerFile(String value) {
    _answerFile = value;
  }

  @override
  String toString() {
    return 'UserAnswerLong{_answerText: $_answerText, _answerFile: $_answerFile}';
  }
}