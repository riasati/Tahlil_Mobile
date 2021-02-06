import 'package:samproject/domain/UserAnswer.dart';

class UserAnswerTest extends UserAnswer{
  int _userChoice;

  int get userChoice => _userChoice;

  set userChoice(int value) {
    _userChoice = value;
  }

  @override
  String toString() {
    return 'UserAnswerTest{_userChoice: $_userChoice}';
  }
}