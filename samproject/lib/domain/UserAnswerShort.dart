import 'package:samproject/domain/UserAnswer.dart';

class UserAnswerShort extends UserAnswer{

  String _answerText;

  String get answerText => _answerText;

  set answerText(String value) {
    _answerText = value;
  }
}