import 'package:flutter/material.dart';
class Controllers
{
  TextEditingController QuestionTextController = new TextEditingController();
  TextEditingController MultiOptionText1Controller = new TextEditingController();
  TextEditingController MultiOptionText2Controller = new TextEditingController();
  TextEditingController MultiOptionText3Controller = new TextEditingController();
  TextEditingController MultiOptionText4Controller = new TextEditingController();
  TextEditingController TashrihiTextController = new TextEditingController();
  TextEditingController BlankTextController = new TextEditingController();
  TextEditingController TestText1Controller = new TextEditingController();
  TextEditingController TestText2Controller = new TextEditingController();
  TextEditingController TestText3Controller = new TextEditingController();
  TextEditingController TestText4Controller = new TextEditingController();
  TextEditingController GradeController = new TextEditingController();


  void FillQuestionTextController(String text)
  {
    QuestionTextController.text = text;
  }
  void FillMultiOptionText1Controller(String text)
  {
    MultiOptionText1Controller.text = text;
  }
  void FillMultiOptionText2Controller(String text)
  {
    MultiOptionText2Controller.text = text;
  }
  void FillMultiOptionText3Controller(String text)
  {
    MultiOptionText3Controller.text = text;
  }
  void FillMultiOptionText4Controller(String text)
  {
    MultiOptionText4Controller.text = text;
  }
  void FillTashrihiTextController(String text)
  {
    TashrihiTextController.text = text;
  }
  void FillBlankTextController(String text)
  {
    BlankTextController.text = text;
  }
  void FillTestText1Controller(String text)
  {
    TestText1Controller.text = text;
  }
  void FillTestText2Controller(String text)
  {
    TestText2Controller.text = text;
  }
  void FillTestText3Controller(String text)
  {
    TestText3Controller.text = text;
  }
  void FillTestText4Controller(String text)
  {
    TestText4Controller.text = text;
  }
  void FillGradeController(String text)
  {
    GradeController.text = text;
  }
}