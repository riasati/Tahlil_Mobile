import 'package:samproject/domain/question.dart';

class QuestionServer
{
  String type;
  bool public;
  String question;
  dynamic answer = [];
  String base;
  String hardness;
  String course;
  String chapter;
  dynamic options = [];
  String id;
  QuestionServer();

  static QuestionServer QuestionToQuestionServer(Question Q)
  {
    QuestionServer QS = new QuestionServer();
    QS.question = Q.text;
    QS.id = Q.id;
    if (Q.paye == "دهم")
    {
      QS.base = "10";
    }
    else if (Q.paye == "یازدهم")
    {
      QS.base = "11";
    }
    else if (Q.paye == "دوازدهم")
    {
      QS.base = "12";
    }

    if(Q.book == "ریاضی")
    {
      QS.course = "MATH";
    }
    else if(Q.book == "فیزیک")
    {
      QS.course = "PHYSIC";
    }
    else if(Q.book == "شیمی")
    {
      QS.course = "CHEMISTRY";
    }
    else if(Q.book == "زیست")
    {
      QS.course = "BIOLOGY";
    }

    if (Q.chapter == "اول")
    {
      QS.chapter = "1";
    }
    else if (Q.chapter == "دوم")
    {
      QS.chapter = "2";
    }
    else if (Q.chapter == "سوم")
    {
      QS.chapter = "3";
    }
    else if (Q.chapter == "چهارم")
    {
      QS.chapter = "4";
    }
    else if (Q.chapter == "پنجم")
    {
      QS.chapter = "5";
    }
    else if (Q.chapter == "ششم")
    {
      QS.chapter = "6";
    }
    else if (Q.chapter == "هفتم")
    {
      QS.chapter = "7";
    }
    else if (Q.chapter == "هشتم")
    {
      QS.chapter = "8";
    }
    else if (Q.chapter == "نهم")
    {
      QS.chapter = "9";
    }
    else if (Q.chapter == "دهم")
    {
      QS.chapter = "10";
    }

    if (Q.difficulty == "آسان")
    {
      QS.hardness = "LOW";
    }
    else if (Q.difficulty == "متوسط")
    {
      QS.hardness = "MEDIUM";
    }
    else if (Q.difficulty == "سخت")
    {
      QS.hardness = "HARD";
    }

    if (Q.kind == "تستی")
    {
      QS.type = "TEST";
    }
    else if (Q.kind == "جایخالی")
    {
      QS.type = "SHORTANSWER";
    }
    else if (Q.kind == "چند گزینه ای")
    {
      QS.type = "MULTICHOISE";
    }
    else if (Q.kind == "تشریحی")
    {
      QS.type = "LONGANSWER";
    }
    if (Q.isPublic != null)
    {
      if (Q.isPublic)
      {
        QS.public = true;
      }
      else
      {
        QS.public = false;
      }
    }

    if (QS.type == "SHORTANSWER")
    {
     // dynamic Answer = {"answer":Q.answerString};
      QS.answer.add({"answer":Q.answerString});
    }
    else if (QS.type == "LONGANSWER")
    {
     // dynamic Answer = {"answer":Q.answerString};
      QS.answer.add({"answer":Q.answerString});
    }
    else if (QS.type == "TEST")
    {
     // dynamic option1 = {"option":Q.optionOne};
     // dynamic option2 = {"option":Q.optionTwo};
     // dynamic option3 = {"option":Q.optionThree};
     // dynamic option4 = {"option":Q.optionFour};
      QS.options.add({"option":Q.optionOne});
      QS.options.add({"option":Q.optionTwo});
      QS.options.add({"option":Q.optionThree});
      QS.options.add({"option":Q.optionFour});
     // dynamic Answer = {"answer":Q.numberOne};
      QS.answer.add({"answer":Q.numberOne});
    }
    else if (QS.type == "MULTICHOISE")
    {
      // dynamic option1 = {"option":Q.optionOne};
      // dynamic option2 = {"option":Q.optionTwo};
      // dynamic option3 = {"option":Q.optionThree};
      // dynamic option4 = {"option":Q.optionFour};
      QS.options.add({"option":Q.optionOne});
      QS.options.add({"option":Q.optionTwo});
      QS.options.add({"option":Q.optionThree});
      QS.options.add({"option":Q.optionFour});

      if (Q.numberOne == 1)
      {
      //  dynamic Answer = {"answer":1};
        QS.answer.add({"answer":1});
      }
      if(Q.numberTwo == 1)
      {
      //  dynamic Answer = {"answer":2};
        QS.answer.add({"answer":2});
      }
      if(Q.numberThree == 1)
      {
      //  dynamic Answer = {"answer":3};
        QS.answer.add({"answer":3});
      }
      if(Q.numberFour == 1)
      {
      //  dynamic Answer = {"answer":4};
        QS.answer.add({"answer":4});
      }
    }

    return QS;

  }
}