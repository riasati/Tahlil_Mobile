import 'package:samproject/domain/UserAnswer.dart';

class UserAnswerMultipleChoice extends UserAnswer{

  List<int> _userChoices = [];

  List<int> get userChoices => _userChoices;

  set userChoices(List<int> value) {
    _userChoices = value;
  }

  @override
  String toString() {
    return 'UserAnswerMultipleChoice{_userChoices: $_userChoices}';
  }
}