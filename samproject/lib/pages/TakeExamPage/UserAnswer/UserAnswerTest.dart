

import 'package:samproject/pages/TakeExamPage/UserAnswer/UserAnswer.dart';

class UserAnswerTest extends UserAnswer{
  int _userChoice;

  int get userChoice => _userChoice;

  set userChoice(int value) {
    _userChoice = value;
  }
}