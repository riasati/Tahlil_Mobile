import 'package:samproject/domain/quetionServer.dart';

class Question
{
  String text;
  String questinImage;
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

  Question();
  static Question QuestionServerToQuestion(QuestionServer QS)
  {
    Question Q = new Question();
    Q.id = QS.id;
    Q.text = QS.question;

    if (QS.base == "10")
    {
      Q.paye = "دهم";
    }
    else if (QS.base == "11")
    {
      Q.paye = "یازدهم";
    }
    else if (QS.base == "12")
    {
      Q.paye = "دوازدهم";
    }

    if(QS.course == "MATH")
    {
      Q.book = "ریاضی";
    }
    else if(QS.course == "PHYSIC")
    {
      Q.book = "فیزیک";
    }
    else if(QS.course == "CHEMISTRY")
    {
      Q.book = "شیمی";
    }
    else if(QS.course == "BIOLOGY")
    {
      Q.book = "زیست";
    }

    if ( QS.chapter == "1")
    {
      Q.chapter = "اول";
    }
    else if (QS.chapter == "2")
    {
      Q.chapter = "دوم";
    }
    else if (QS.chapter == "3")
    {
      Q.chapter = "سوم";
    }
    else if (QS.chapter == "4")
    {
      Q.chapter = "چهارم";
    }
    else if (QS.chapter == "5")
    {
      Q.chapter = "پنجم";
    }
    else if (QS.chapter == "6")
    {
      Q.chapter = "ششم";
    }
    else if (QS.chapter == "7")
    {
      Q.chapter = "هفتم";
    }
    else if (QS.chapter == "8")
    {
      Q.chapter = "هشتم";
    }
    else if (QS.chapter == "9")
    {
      Q.chapter = "نهم";
    }
    else if (QS.chapter == "10")
    {
      Q.chapter = "دهم";
    }

    if (QS.hardness == "LOW")
    {
      Q.difficulty = "آسان";
    }
    else if (QS.hardness == "MEDIUM")
    {
      Q.difficulty = "متوسط";
    }
    else if (QS.hardness == "HARD")
    {
      Q.difficulty = "سخت";
    }

    if (QS.type == "TEST")
    {
      Q.kind = "تستی";
    }
    else if (QS.type == "SHORTANSWER")
    {
      Q.kind = "جایخالی";
    }
    else if (QS.type == "MULTICHOISE")
    {
      Q.kind = "چند گزینه ای";
    }
    else if (QS.type == "LONGANSWER")
    {
      Q.kind = "تشریحی";
    }

    if (QS.public != null)
    {
      if (QS.public == true)
      {
        Q.isPublic = true;
      }
      else
      {
        Q.isPublic = false;
      }
    }

    if (QS.type == "SHORTANSWER")
    {
      if (QS.answer.isEmpty == false)
      {
        Q.answerString = QS.answer[0]["answer"];
      }

    }
    else if (QS.type == "LONGANSWER")
    {
      if (QS.answer.isEmpty == false)
      {
        Q.answerString = QS.answer[0]["answer"];
      }
    }
    else if (QS.type == "TEST")
    {
      //List ls = [];
      //ls.length
      for (int i = 0;i<QS.options.length;i++)
      {
        if (i==0)
        {
          Q.optionOne = QS.options[0]["option"];
          Q.optionTwo = "خالی";
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        }
        else if (i==1)
        {
          Q.optionTwo = QS.options[1]["option"];
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        }
        else if (i==2)
        {
          Q.optionThree = QS.options[2]["option"];
          Q.optionFour = "خالی";
        }
        else if (i==3)
        {
          Q.optionFour = QS.options[3]["option"];
        }
      }

      //Q.numberOne = int.tryParse(QS.answer[0]["answer"]);
     // Q.numberOne = int.parse(QS.answer[0]["answer"]);
      if (QS.answer[0]["answer"] is !String)
      {
        Q.numberOne = QS.answer[0]["answer"];
      }
      else
        {
          Q.numberOne = int.tryParse(QS.answer[0]["answer"]);
        }
      //Q.numberOne = 3;
    }
    else if (QS.type == "MULTICHOISE")
    {
      for (int i = 0;i<QS.options.length;i++)
      {
        if (i==0)
        {
          Q.optionOne = QS.options[0]["option"];
          Q.optionTwo = "خالی";
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        }
        else if (i==1)
        {
          Q.optionTwo = QS.options[1]["option"];
          Q.optionThree = "خالی";
          Q.optionFour = "خالی";
        }
        else if (i==2)
        {
          Q.optionThree = QS.options[2]["option"];
          Q.optionFour = "خالی";
        }
        else if (i==3)
        {
          Q.optionFour = QS.options[3]["option"];
        }
      }
      for (int i=0;i<QS.answer.length;i++)
      {
        if (QS.answer[i]["answer"] == 1)
        {
          Q.numberOne = 1;
        }
        else if (QS.answer[i]["answer"] == 2)
        {
          Q.numberTwo = 1;
        }
        else if (QS.answer[i]["answer"] == 3)
        {
          Q.numberThree = 1;
        }
        else if (QS.answer[i]["answer"] == 4)
        {
          Q.numberFour = 1;
        }
      }
    }
    return Q;
  }
}