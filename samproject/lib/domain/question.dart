import 'package:samproject/domain/quetionServer.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/domain/UserAnswer.dart';

class Question {
  int index;
  String text;
  String questionImage;
  String answerImage;
  String paye;
  String book;
  String chapter;
  String difficulty;
  String kind;
  String answerString;
  int numberOne;
  int numberTwo;
  int numberThree;
  int numberFour;
  String optionOne;
  String optionTwo;
  String optionThree;
  String optionFour;
  bool isPublic;
  String id;
  double grade;
  UserAnswer userAnswer;

  Question();

  Question CopyQuestion() {
    Question q = new Question();
    q.text = this.text;
    q.questionImage = this.questionImage;
    q.answerImage = this.answerImage;
    q.paye = this.paye;
    q.book = this.book;
    q.chapter = this.chapter;
    q.difficulty = this.difficulty;
    q.kind = this.kind;
    q.answerString = this.answerString;
    q.numberOne = this.numberOne;
    q.numberTwo = this.numberTwo;
    q.numberThree = this.numberThree;
    q.numberFour = this.numberFour;
    q.optionOne = this.optionOne;
    q.optionTwo = this.optionTwo;
    q.optionThree = this.optionThree;
    q.optionFour = this.optionFour;
    q.isPublic = this.isPublic;
    q.id = this.id;
    q.grade = this.grade;
    q.index = this.index;
    return q;
  }

  static Question QuestionServerToQuestion(
      QuestionServer QS, String ServerKind) {
    Question Q = new Question();
    Q.id = QS.id;
    Q.text = QS.question;
    Q.paye = HomePage.maps.SPayeMap[QS.base];
    Q.book = HomePage.maps.SBookMap[QS.course];
    Q.chapter = HomePage.maps.SChapterMap[QS.chapter];
    Q.kind = HomePage.maps.SKindMap[QS.type];
    Q.difficulty = HomePage.maps.SDifficultyMap[QS.hardness];
    Q.questionImage = QS.imageQuestion;
    Q.answerImage = QS.imageAnswer;
    Q.grade = QS.grade;
    Q.index = QS.index;

    if (QS.public != null) {
      if (QS.public == true) {
        Q.isPublic = true;
      } else {
        Q.isPublic = false;
      }
    }

    if (ServerKind == "SHORTANSWER") {
      if (QS.answer.isEmpty == false) {
        Q.answerString = QS.answer[0]["answer"];
      }
    } else if (ServerKind == "LONGANSWER") {
      if (QS.answer.isEmpty == false) {
        Q.answerString = QS.answer[0]["answer"];
      }
    } else if (ServerKind == "TEST") {
      for (int i = 0; i < QS.options.length; i++) {
        if (i == 0) {
          Q.optionOne = QS.options[0]["option"];
          Q.optionTwo = "خالی";
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        } else if (i == 1) {
          Q.optionTwo = QS.options[1]["option"];
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        } else if (i == 2) {
          Q.optionThree = QS.options[2]["option"];
          Q.optionFour = "خالی";
        } else if (i == 3) {
          Q.optionFour = QS.options[3]["option"];
        }
      }

      //Q.numberOne = int.tryParse(QS.answer[0]["answer"]);
      // Q.numberOne = int.parse(QS.answer[0]["answer"]);
      if (QS.answer[0]["answer"] is! String) {
        Q.numberOne = QS.answer[0]["answer"];
      } else {
        Q.numberOne = int.tryParse(QS.answer[0]["answer"]);
      }
    } else if (ServerKind == "MULTICHOISE") {
      for (int i = 0; i < QS.options.length; i++) {
        if (i == 0) {
          Q.optionOne = QS.options[0]["option"];
          Q.optionTwo = "خالی";
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        } else if (i == 1) {
          Q.optionTwo = QS.options[1]["option"];
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        } else if (i == 2) {
          Q.optionThree = QS.options[2]["option"];
          Q.optionFour = "خالی";
        } else if (i == 3) {
          Q.optionFour = QS.options[3]["option"];
        }
      }
      for (int i = 0; i < QS.answer.length; i++) {
        if (QS.answer[i]["answer"] == 1) {
          Q.numberOne = 1;
        } else if (QS.answer[i]["answer"] == 2) {
          Q.numberTwo = 1;
        } else if (QS.answer[i]["answer"] == 3) {
          Q.numberThree = 1;
        } else if (QS.answer[i]["answer"] == 4) {
          Q.numberFour = 1;
        }
      }
    }
    return Q;
  }

  @override
  String toString() {
    return 'Question{text: $text, kind: $kind, answerString: $answerString, index: $index,numberOne: $numberOne, numberTwo: $numberTwo, numberThree: $numberThree, numberFour: $numberFour, optionOne: $optionOne, optionTwo: $optionTwo, optionThree: $optionThree, optionFour: $optionFour, grade: $grade, userAnswer: $userAnswer,questionImage: $questionImage}';
  }
}
