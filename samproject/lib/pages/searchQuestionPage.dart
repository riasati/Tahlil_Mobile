import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samproject/domain/question.dart';

class SearchQuestionPage extends StatefulWidget {
  @override
  _SearchQuestionPageState createState() => _SearchQuestionPageState();
}

class _SearchQuestionPageState extends State<SearchQuestionPage> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  List<String> payelist = ["دهم","یازدهم","دوازدهم"];
  popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = ["ریاضی","فیزیک","شیمی","زیست"];
  popupMenuData chapterData = new popupMenuData("فصل");
  List<String> cahpterlist = ["اول","دوم","سوم","چهارم","پنجم","ششم","هفتم","هشتم","نهم","دهم",];
  popupMenuData kindData = new popupMenuData("نوع سوال");
  List<String> kindlist = ["تستی","جایخالی","چند گزینه ای","تشریحی"];
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = ["آسان","متوسط","سخت"];
  
  Question newQuestion = new Question();
  Question newQuestion2 = new Question();
  Question newQuestion3 = new Question();
  Question newQuestion4 = new Question();

 @override
  void initState() {
    super.initState();
    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(cahpterlist);
    kindData.fillStringList(kindlist);
    difficultyData.fillStringList(difficultylist);

    newQuestion.paye = "دهم";
    newQuestion.book = "فیزیک";
    newQuestion.chapter = "چهارم";
    newQuestion.kind = "تشریحی";
    newQuestion.difficulty = "سخت";
    newQuestion.text = "هر میکرو معادل با 10 به توان چند است؟";
    //newQuestion.image1 = "عکس سوال";
    newQuestion.answerString = "منهای شش";
    //newQuestion.image2 = "عکس پاسخ";

    newQuestion2.paye = "دهم";
    newQuestion2.book = "فیزیک";
    newQuestion2.chapter = "چهارم";
    newQuestion2.kind = "چند گزینه ای";
    newQuestion2.difficulty = "سخت";
    newQuestion2.text = "هر میکرو معادل با 10 به توان چند است؟";
    newQuestion2.image1 = "عکس سوال";
    newQuestion2.optionOne = "به توان یک";
    newQuestion2.optionTwo = "به توان دو";
    newQuestion2.optionThree = "به توان سه";
    newQuestion2.optionFour = "به توان چهار";
    newQuestion2.numberOne = 0;
    newQuestion2.numberTwo = 1;
    newQuestion2.numberThree = 1;
    newQuestion2.numberFour = 0;

    newQuestion3.paye = "دهم";
    newQuestion3.book = "فیزیک";
    newQuestion3.chapter = "چهارم";
    newQuestion3.kind = "تستی";
    newQuestion3.difficulty = "سخت";
    newQuestion3.text = "هر میکرو معادل با 10 به توان چند است؟";
    newQuestion3.image1 = "عکس سوال";
    newQuestion3.optionOne = "به توان یک";
    newQuestion3.optionTwo = "به توان دو";
    newQuestion3.optionThree = "به توان سه";
    newQuestion3.optionFour = "به توان چهار";
    newQuestion3.numberOne = 2;

    newQuestion4.paye = "دهم";
    newQuestion4.book = "فیزیک";
    newQuestion4.chapter = "چهارم";
    newQuestion4.kind = "جایخالی";
    newQuestion4.difficulty = "سخت";
    newQuestion4.text = "هر میکرو معادل با 10 به توان چند است؟";
    newQuestion4.image1 = "عکس سوال";
    newQuestion4.answerString = "منهای شش";

  }

  void submit()
  {
    print(payeData.name);
    print(bookData.name);
    print(chapterData.name);
    print(kindData.name);
    print(difficultyData.name);
    setState(() {
      _btnController.stop();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "جستجو سوال در بانک",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.0),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(padding: const EdgeInsets.all(4.0),alignment: Alignment.centerRight,child: Text("جستجو بر اساس",textDirection: TextDirection.rtl,)),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: payeData,))),
                            SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: bookData,))),
                            SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: chapterData,)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: kindData,))),
                            SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: difficultyData,))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        // RaisedButton(
                        //   child: Text("asdfads"),
                        //   onPressed: submit,
                        // )

                        RoundedLoadingButton(
                          height: 30,
                          child: Text('جستجو',style: TextStyle(color: Colors.white),),
                          //  borderRadius: 0,
                          controller: _btnController,
                          color: Color.fromRGBO(238, 108,77 ,100), //Color.(0xFF3D5A80),
                          onPressed: () => submit,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              MultiOptionView(question: newQuestion2,),
              TestView(question: newQuestion3,),
              AnswerString(question: newQuestion,),
              AnswerString(question: newQuestion4,),
            ],
          ),
        ),
      ),
    );
  }
}

class popupMenuData
{
  String name;
  String popupMenuBottonName;
  List<PopupMenuItem<int>> list = [];
  List<String> stringList = [];

  popupMenuData(String PopupMenuBottonName)
  {
    this.popupMenuBottonName = PopupMenuBottonName;
  }
  void fillStringList(List<String> list)
  {
    for (int i=0;i<list.length;i++)
    {
      stringList.add(list[i]);
    }
  }
}

class TestView extends StatefulWidget {
  Question question;
  TestView({Key key, this.question}) : super(key: key);
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  int _radioGroupValue = 0;
  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
    });
  }
  void viewTestAnswer()
  {
    setState(() {
      _radioGroupValue = widget.question.numberOne;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.question.paye),
                  Text(widget.question.book),
                  Text(widget.question.chapter),
                  Text(widget.question.kind),
                  Text(widget.question.difficulty),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text(widget.question.text,textDirection: TextDirection.rtl)),
                  (widget.question.image1 != null) ? Text(widget.question.image1) : Container(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Radio(visualDensity: VisualDensity.compact,value: 1, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
                      Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Radio(visualDensity: VisualDensity.compact,value: 2, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
                      Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Radio(visualDensity: VisualDensity.compact,value: 3, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
                      Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Radio(visualDensity: VisualDensity.compact,value: 4, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
                      Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
                    ],
                  ),
                ],
              ),
            ),
            FlatButton(
              color: Color(0xFF3D5A80),
              onPressed: viewTestAnswer,
              child: Text("دیدن پاسخ"),
              textColor: Colors.white,
            ),
            // RoundedLoadingButton(
            //   color: Color(0xFF3D5A80),
            //   child: Text("دیدن پاسخ"),
            //   onPressed: viewTestAnswer,
            // )
            // RaisedButton(
            //     textColor: Colors.white,
            //     //color: Colors.lightBlue,
            //     child: Text("دیدن پاسخ"),
            //     onPressed: viewTestAnswer)

          ],
        ),
      ),
    );
  }
}


class MultiOptionView extends StatefulWidget {
  Question question;
  MultiOptionView({Key key, this.question}) : super(key: key);
  @override
  _MultiOptionViewState createState() => _MultiOptionViewState();
}

class _MultiOptionViewState extends State<MultiOptionView> {
  bool optionOne = false;
  void optionOneChange(bool newValue) {
    setState(() {
      optionOne = newValue;
    });
  }
  bool optionTwo = false;
  void optionTwoChange(bool newValue) {
    setState(() {
      optionTwo = newValue;
    });
  }
  bool optionThree = false;
  void optionThreeChange(bool newValue) {
    setState(() {
      optionThree = newValue;
    });
  }
  bool optionFour = false;
  void optionFourChange(bool newValue) {
    setState(() {
      optionFour = newValue;
    });
  }

  void viewMultiOptionAnswer()
  {
    setState(() {
      (widget.question.numberOne == 1) ? optionOne = true : optionOne = false;
      (widget.question.numberTwo == 1) ? optionTwo = true : optionTwo = false;
      (widget.question.numberThree == 1) ? optionThree = true : optionThree = false;
      (widget.question.numberFour == 1) ? optionFour = true : optionFour = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.question.paye),
                  Text(widget.question.book),
                  Text(widget.question.chapter),
                  Text(widget.question.kind),
                  Text(widget.question.difficulty),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text(widget.question.text,textDirection: TextDirection.rtl)),
                  (widget.question.image1 != null) ? Text(widget.question.image1) : Container(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(value: optionOne, onChanged: optionOneChange),
                      Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(value: optionTwo, onChanged: optionTwoChange),
                      Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(value: optionThree, onChanged: optionThreeChange),
                      Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(value: optionFour, onChanged: optionFourChange),
                      Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
                    ],
                  ),
                ],
              ),
            ),
            FlatButton(
              color: Color(0xFF3D5A80),
              onPressed: viewMultiOptionAnswer,
              child: Text("دیدن پاسخ"),
              textColor: Colors.white,
            ),
            // RaisedButton(
            //     textColor: Colors.white,
            //     //color: Colors.lightBlue,
            //     child: Text("دیدن پاسخ"),
            //     onPressed: viewMultiOptionAnswer)
          ],
        ),
      ),
    );
  }
}


class AnswerString extends StatefulWidget {
  Question question;
  AnswerString({Key key, this.question}) : super(key: key);
  @override
  _AnswerStringState createState() => _AnswerStringState();
}

class _AnswerStringState extends State<AnswerString> {
  bool viewAnswerbool = false;
  void viewAnswer(bool viewAnswer)
  {
    setState(() {
      (viewAnswer) ? viewAnswerbool = false : viewAnswerbool = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.question.paye),
                  Text(widget.question.book),
                  Text(widget.question.chapter),
                  Text(widget.question.kind),
                  Text(widget.question.difficulty),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text("سوال : " + widget.question.text,textDirection: TextDirection.rtl)),
                  (widget.question.image1 != null) ? Text(widget.question.image1) : Container(),
                ],
              ),
            ),
            (viewAnswerbool) ? Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(alignment: Alignment.centerRight,child: Text("جواب : "+ widget.question.answerString,textDirection: TextDirection.rtl)),
                  (widget.question.image2 != null) ? Text(widget.question.image2) : Container(),
                ],
              ),
            ):Container(),
            FlatButton(
              onPressed: () => viewAnswer(viewAnswerbool),
              child: Text("دیدن پاسخ"),
              textColor: Colors.white,
              color: Color(0xFF3D5A80),
            )
            // RaisedButton(
            //     textColor: Colors.white,
            //     //color: Colors.lightBlue,
            //     child: Text("دیدن پاسخ"),
            //     onPressed: () => viewAnswer(viewAnswerbool))
          ],
        ),
      ),
    );
  }
}


class PopupMenu extends StatefulWidget {
  popupMenuData Data;
  PopupMenu({Key key, this.Data}) : super(key: key);
  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  void onSelectedMenu(int value)
  {
    for (int i = 0;i<widget.Data.stringList.length;i++)
    {
      if (value == i) {
        setState(() {
          widget.Data.name = widget.Data.stringList[i];
        });
      }
    }
    if(value == -1)
    {
      setState(() {
        widget.Data.name = null;
      });
    }
  }
  PopupMenuItem<int> popupMenuItem (int value,String text)
  {
    return PopupMenuItem(
        value: value,
        child: Container(alignment: Alignment.centerRight,child: Text(text,textDirection: TextDirection.rtl,))
    );
  }
  @override
  void initState() {
    super.initState();
    for (int i = 0;i<widget.Data.stringList.length;i++)
    {
      widget.Data.list.add(popupMenuItem(i, widget.Data.stringList[i]));
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: (widget.Data.name == null) ? Text(widget.Data.popupMenuBottonName) : Text(widget.Data.name),
      onSelected: onSelectedMenu,
      itemBuilder: (context) => widget.Data.list,
    );
  }
}

