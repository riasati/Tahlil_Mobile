import 'package:samproject/domain/question.dart';
class QuestionServer
{
  int index;
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
  String imageQuestion;
  String imageAnswer;
  double grade;
  QuestionServer();

  static QuestionServer QuestionToQuestionServer(Question Q,String Serverkind)
  {
    QuestionServer QS = new QuestionServer();
    QS.question = Q.text;
    QS.id = Q.id;
    QS.grade = Q.grade;


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

    if (Serverkind == "SHORTANSWER")
    {
      QS.answer.add({"answer":Q.answerString});
    }
    else if (Serverkind == "LONGANSWER")
    {
      QS.answer.add({"answer":Q.answerString});
    }
    else if (Serverkind == "TEST")
    {
      QS.options.add({"option":Q.optionOne});
      QS.options.add({"option":Q.optionTwo});
      QS.options.add({"option":Q.optionThree});
      QS.options.add({"option":Q.optionFour});

      QS.answer.add({"answer":Q.numberOne});
    }
    else if (Serverkind == "MULTICHOISE")
    {

      QS.options.add({"option":Q.optionOne});
      QS.options.add({"option":Q.optionTwo});
      QS.options.add({"option":Q.optionThree});
      QS.options.add({"option":Q.optionFour});

      if (Q.numberOne == 1)
      {
        QS.answer.add({"answer":1});
      }
      if(Q.numberTwo == 1)
      {
        QS.answer.add({"answer":2});
      }
      if(Q.numberThree == 1)
      {
        QS.answer.add({"answer":3});
      }
      if(Q.numberFour == 1)
      {
        QS.answer.add({"answer":4});
      }
    }

    return QS;

  }
}