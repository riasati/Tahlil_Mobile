import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/widgets/popumMenu.dart';
import 'package:samproject/domain/controllers.dart';
import 'package:samproject/domain/searchFilters.dart';
class NotEditingQuestionSpecification extends StatelessWidget {
  Question question;
  NotEditingQuestionSpecification({Key key, @required this.question}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(question.paye,style: TextStyle(fontSize: 10),),
          Text(question.book,style: TextStyle(fontSize: 10),),
          Text(question.chapter,style: TextStyle(fontSize: 10),),
          Text(question.kind,style: TextStyle(fontSize: 10),),
          Text(question.difficulty,style: TextStyle(fontSize: 10),),
        ],
      ),
    );
  }
}

class NotEditingQuestionText extends StatelessWidget {
  Question question;
  NotEditingQuestionText({Key key, @required this.question}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(alignment: Alignment.centerRight,child: Text("سوال : " + question.text,textDirection: TextDirection.rtl)),
          (question.questinImage != null) ? Text(question.questinImage) : Container(),
        ],
      ),
    );
  }
}

class NotEditingMultiChoiceOption extends StatefulWidget {
  Question question;
  bool isNull = true;
  NotEditingMultiChoiceOption({Key key, @required this.question,this.isNull}) : super(key: key);
  @override
  _NotEditingMultiChoiceOptionState createState() => _NotEditingMultiChoiceOptionState();
}

class _NotEditingMultiChoiceOptionState extends State<NotEditingMultiChoiceOption> {
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: (widget.isNull) ? ((widget.question.numberOne == 1) ? true: false) : optionOne, onChanged: (widget.isNull) ? null :optionOneChange),
              Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: (widget.isNull) ? ((widget.question.numberTwo == 1) ? true: false) : optionTwo, onChanged: (widget.isNull) ? null :optionTwoChange),
              Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: (widget.isNull) ? ((widget.question.numberThree == 1) ? true: false) : optionThree, onChanged: (widget.isNull) ? null :optionThreeChange),
              Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: (widget.isNull) ? ((widget.question.numberFour == 1) ? true: false) : optionFour, onChanged: (widget.isNull) ? null :optionFourChange),
              Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
            ],
          ),
        ],
      ),
    );
  }
}

class EditAndEliminateButton extends StatelessWidget {
  EditAndEliminateButton({Key key, this.onEditPressed,this.onEliminatePressed}) : super(key: key);
  final VoidCallback onEditPressed;
  final VoidCallback onEliminatePressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(
          color: Color(0xFF3D5A80),
          onPressed: onEditPressed,
          child: Text("ويرايش"),
          textColor: Colors.white,
        ),
        FlatButton(
          color: Color(0xFF3D5A80),
          onPressed: onEliminatePressed,
          child: Text("حذف"),
          textColor: Colors.white,
        ),
      ],
    );
  }
}

class EditingOneLineQuestionSpecification extends StatefulWidget {
  Question question;
  popupMenuData payeData;
  popupMenuData bookData;
  popupMenuData chapterData;
  popupMenuData kindData;
  popupMenuData difficultyData;
  EditingOneLineQuestionSpecification({Key key, this.question,this.payeData,this.bookData,this.chapterData,this.kindData,this.difficultyData}) : super(key: key);
  @override
  _EditingOneLineQuestionSpecificationState createState() => _EditingOneLineQuestionSpecificationState();
}

class _EditingOneLineQuestionSpecificationState extends State<EditingOneLineQuestionSpecification> {
  //popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  List<String> payelist = ["دهم","یازدهم","دوازدهم"];
  // popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = ["ریاضی","فیزیک","شیمی","زیست"];
  // popupMenuData chapterData = new popupMenuData("فصل");
  List<String> cahpterlist = ["اول","دوم","سوم","چهارم","پنجم","ششم","هفتم","هشتم","نهم","دهم",];
  // popupMenuData kindData = new popupMenuData("نوع سوال");
  List<String> kindlist = ["تستی","جایخالی","چند گزینه ای","تشریحی"];
  // popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = ["آسان","متوسط","سخت"];

  @override
  void initState() {
    super.initState();
    widget.payeData.fillStringList(payelist);
    widget.bookData.fillStringList(booklist);
    widget.chapterData.fillStringList(cahpterlist);
    widget.kindData.fillStringList(kindlist);
    widget.difficultyData.fillStringList(difficultylist);
    if (widget.question != null)
    {
      widget.payeData.name = widget.question.paye;
      widget.bookData.name = widget.question.book;
      widget.chapterData.name = widget.question.chapter;
      widget.kindData.name = widget.question.kind;
      widget.difficultyData.name = widget.question.difficulty;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.payeData,))),
          Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.bookData,))),
          Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.chapterData,))),
          Flexible(child: Container(alignment: Alignment.center,child: Text(widget.kindData.name,textDirection: TextDirection.rtl,))),//PopupMenu(Data: widget.kindData,)
          Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.difficultyData,))),
        ],
      ),
    );
  }
}

class EditingQuestionText extends StatefulWidget {
  Question question;
  Controllers controllers;
  EditingQuestionText({Key key, @required this.controllers,this.question}) : super(key: key);
  @override
  _EditingQuestionTextState createState() => _EditingQuestionTextState();
}

class _EditingQuestionTextState extends State<EditingQuestionText> {
  File _QuestionImage;
  final picker = ImagePicker();
  void getQuestionImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        _QuestionImage = File(pickedFile.path);
      }
    });
  }
  void _deleteQuestionImage()
  {
    setState(() {
      _QuestionImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text("متن سوال",textDirection: TextDirection.rtl,),
                    IconButton(icon: Icon(Icons.camera),onPressed: getQuestionImage,tooltip: "می توان فقط عکس هم فرستاد",)
                  ],
                ),
              ),
              Expanded(
                  child: TextFormField(
                    autofocus: true,
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.QuestionTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              ),
            ],
          ),
        ),
        (_QuestionImage != null) ? Container(child: InkWell(onTap:() => _deleteQuestionImage(),child: Image.file(_QuestionImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
            : Container(),
      ],
    );
  }
}

class EditingMultiChoiceOption extends StatefulWidget {
  Question question;
  Controllers controllers;
  EditingMultiChoiceOption({Key key, @required this.controllers,this.question}) : super(key: key);
  @override
  _EditingMultiChoiceOptionState createState() => _EditingMultiChoiceOptionState();
}

class _EditingMultiChoiceOptionState extends State<EditingMultiChoiceOption> {
  bool optionOne = false;
  void optionOneChange(bool newValue) {
    setState(() {
      optionOne = newValue;
    });
    if (widget.question != null)
    {
      (optionOne == true) ? widget.question.numberOne = 1 : widget.question.numberOne = 0;
    }
  }
  bool optionTwo = false;
  void optionTwoChange(bool newValue) {
    setState(() {
      optionTwo = newValue;
    });
    if (widget.question != null)
    {
      (optionTwo == true) ? widget.question.numberTwo = 1 : widget.question.numberTwo = 0;
    }
  }
  bool optionThree = false;
  void optionThreeChange(bool newValue) {
    setState(() {
      optionThree = newValue;
    });
    if (widget.question != null)
    {
      (optionThree == true) ? widget.question.numberThree = 1 : widget.question.numberThree = 0;
    }
  }
  bool optionFour = false;
  void optionFourChange(bool newValue) {
    setState(() {
      optionFour = newValue;
    });
    if (widget.question != null)
    {
      (optionFour == true) ? widget.question.numberFour = 1 : widget.question.numberFour = 0;
    }
  }
  @override
  void initState() {
    super.initState();
    if (widget.question != null)
    {
      optionOne = (widget.question.numberOne == 1) ? true:false;
      optionTwo = (widget.question.numberTwo == 1) ? true:false;
      optionThree = (widget.question.numberThree == 1) ? true:false;
      optionFour = (widget.question.numberFour == 1) ? true:false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionOne, onChanged: optionOneChange),
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: widget.controllers.MultiOptionText1Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionTwo, onChanged: optionTwoChange),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.MultiOptionText2Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionThree, onChanged: optionThreeChange),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.MultiOptionText3Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Checkbox(value: optionFour, onChanged: optionFourChange),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.MultiOptionText4Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AddInBankOption extends StatefulWidget {
  Question question;
  AddInBankOption({Key key,this.question}) : super(key: key);
  @override
  _AddInBankOptionState createState() => _AddInBankOptionState();
}

class _AddInBankOptionState extends State<AddInBankOption> {
  bool addQuestionBankOption;
  void addQuestionBankOptionChange(bool newValue) {
    setState(() {
      addQuestionBankOption = newValue;
    });
    if (widget.question != null)
    {
      widget.question.isPublic = addQuestionBankOption;
    }
  }
  @override
  void initState() {
    super.initState();
    addQuestionBankOption = false;
    if (widget.question != null)
    {
      addQuestionBankOption = widget.question.isPublic;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
      textDirection: TextDirection.rtl,
      children: [
        Checkbox(value: addQuestionBankOption, onChanged: addQuestionBankOptionChange),
        Text("افزودن به بانک سوال",textDirection: TextDirection.rtl,),
      ],
    );
  }
}

class NotEditingAnswerString extends StatelessWidget {
  Question question;
  NotEditingAnswerString({Key key,this.question}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(alignment: Alignment.centerRight,child: Text("جواب : "+ question.answerString,textDirection: TextDirection.rtl)),
          (question.answerImage != null) ? Text(question.answerImage) : Container(),
        ],
      ),
    );
  }
}

class NotEditingTest extends StatefulWidget {
  Question question;
  NotEditingTest({Key key,this.question}) : super(key: key);
  @override
  _NotEditingTestState createState() => _NotEditingTestState();
}

class _NotEditingTestState extends State<NotEditingTest> {
  int _radioGroupValue = 0;
  @override
  void initState() {
    super.initState();
    _radioGroupValue = widget.question.numberOne;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 1, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionOne,textDirection: TextDirection.rtl))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 2, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionTwo,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 3, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionThree,textDirection: TextDirection.rtl,))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 4, groupValue: _radioGroupValue, onChanged: null),
              Expanded(child: Text(widget.question.optionFour,textDirection: TextDirection.rtl,))
            ],
          ),
        ],
      ),
    );
  }
}

class EditingAnswerString extends StatefulWidget {
  Question question;
  Controllers controllers;
  EditingAnswerString({Key key, @required this.controllers,this.question}) : super(key: key);
  @override
  _EditingAnswerStringState createState() => _EditingAnswerStringState();
}

class _EditingAnswerStringState extends State<EditingAnswerString> {
  File _AnswerImage;
  final picker = ImagePicker();
  void getAnswerImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        _AnswerImage = File(pickedFile.path);
      }
    });
  }
  void _deleteAnswerImage()
  {
    setState(() {
      _AnswerImage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.controllers.TashrihiTextController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text("پاسخ سوال",textDirection: TextDirection.rtl,),
                  (widget.question.kind != "جایخالی") ? IconButton(icon: Icon(Icons.camera),onPressed: getAnswerImage,tooltip: "می توان فقط عکس هم فرستاد",): Container(),
                ],
              ),
            ),
            Expanded(
                child: (widget.question.kind != "جایخالی") ? TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: widget.controllers.TashrihiTextController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
                    :Container(
                  padding: EdgeInsets.all(4.0),
                  width: 120,
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.TashrihiTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                )
            ),
          ],
        ),
        (_AnswerImage != null) ? Container(child: InkWell(onTap:() => _deleteAnswerImage(),child: Image.file(_AnswerImage,fit: BoxFit.cover)),height: 200,alignment: Alignment.center,padding: EdgeInsets.all(8.0),)
            : Container(),
      ],
    );
  }
}

class EditingTest extends StatefulWidget {
  Question question;
  Controllers controllers;
  EditingTest({Key key, @required this.controllers,this.question}) : super(key: key);
  @override
  _EditingTestState createState() => _EditingTestState();
}

class _EditingTestState extends State<EditingTest> {
  int _radioGroupValue = 0;
  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
    });
    if (widget.question != null)
    {
      widget.question.numberOne = _radioGroupValue;
    }
  }
  @override
  void initState() {
    super.initState();
    if (widget.question != null)
    {
      _radioGroupValue = widget.question.numberOne;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 1, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: widget.controllers.TestText1Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 2, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.TestText2Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 3, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.TestText3Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Radio(visualDensity: VisualDensity.compact,value: 4, groupValue: _radioGroupValue, onChanged: (index) => _radioOnChanged(index),),
              Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.TestText4Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SearchFilterWidget extends StatefulWidget {
  SearchFilters searchFilters;
  SearchFilterWidget({Key key,this.searchFilters}) : super(key: key);
  @override
  _SearchFilterWidgetState createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  String _selectedPaye1;
  String _selectedPaye2;
  String _selectedPaye3;
  String _selectedBook1;
  String _selectedBook2;
  String _selectedBook3;
  String _selectedBook4;
  String _selectedChapter1;
  String _selectedChapter2;
  String _selectedChapter3;
  String _selectedChapter4;
  String _selectedChapter5;
  String _selectedChapter6;
  String _selectedChapter7;
  String _selectedChapter8;
  String _selectedChapter9;
  String _selectedChapter10;
  String _selectedKind1;
  String _selectedKind2;
  String _selectedKind3;
  String _selectedKind4;
  String _selectedDifficulty1;
  String _selectedDifficulty2;
  String _selectedDifficulty3;
  void onSelectedDifficultyMenu(value) => setState((){
    if (value == 1)
    {
      if (_selectedDifficulty1 == "آسان")
      {
        widget.searchFilters.difficultyList.remove(_selectedDifficulty1);
        _selectedDifficulty1 = null;
      }
      else
      {
        _selectedDifficulty1 = "آسان";
        widget.searchFilters.difficultyList.add(_selectedDifficulty1);
      }
    }
    else if (value == 2)
    {
      if (_selectedDifficulty2 == "متوسط")
      {
        widget.searchFilters.difficultyList.remove(_selectedDifficulty2);
        _selectedDifficulty2 = null;
      }
      else
      {
        _selectedDifficulty2 = "متوسط";
        widget.searchFilters.difficultyList.add(_selectedDifficulty2);
      }
    }
    else if (value == 3)
    {
      if (_selectedDifficulty3 == "سخت")
      {
        widget.searchFilters.difficultyList.remove(_selectedDifficulty3);
        _selectedDifficulty3 = null;
      }
      else
      {
        _selectedDifficulty3 = "سخت";
        widget.searchFilters.difficultyList.add(_selectedDifficulty3);
      }
    }
  });
  void onSelectedKindMenu(value) => setState((){
    if (value == 1)
    {
      if (_selectedKind1 == "تستی")
      {
        widget.searchFilters.kindList.remove(_selectedKind1);
        _selectedKind1 = null;
      }
      else
      {
        _selectedKind1 = "تستی";
        widget.searchFilters.kindList.add(_selectedKind1);
      }
    }
    else if (value == 2)
    {
      if (_selectedKind2 == "جایخالی")
      {
        widget.searchFilters.kindList.remove(_selectedKind2);
        _selectedKind2 = null;
      }
      else
      {
        _selectedKind2 = "جایخالی";
        widget.searchFilters.kindList.add(_selectedKind2);
      }
    }
    else if (value == 3)
    {
      if (_selectedKind3 == "چند گزینه ای")
      {
        widget.searchFilters.kindList.remove(_selectedKind3);
        _selectedKind3 = null;
      }
      else
      {
        _selectedKind3 = "چند گزینه ای";
        widget.searchFilters.kindList.add(_selectedKind3);
      }
    }
    else if (value == 4)
    {
      if (_selectedKind4 == "تشریحی")
      {
        widget.searchFilters.kindList.remove(_selectedKind4);
        _selectedKind4 = null;
      }
      else
      {
        _selectedKind4 = "تشریحی";
        widget.searchFilters.kindList.add(_selectedKind4);
      }
    }
  });
  void onSelectedChapterMenu(value) => setState((){
    if (value == 1)
    {
      if (_selectedChapter1 == "اول")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter1);
        _selectedChapter1 = null;
      }
      else
      {
        _selectedChapter1 = "اول";
        widget.searchFilters.chapterList.add(_selectedChapter1);
      }
    }
    else if (value == 2)
    {
      if (_selectedChapter2 == "دوم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter2);
        _selectedChapter2 = null;
      }
      else
      {
        _selectedChapter2 = "دوم";
        widget.searchFilters.chapterList.add(_selectedChapter2);
      }
    }
    else if (value == 3)
    {
      if (_selectedChapter3 == "سوم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter3);
        _selectedChapter3 = null;
      }
      else
      {
        _selectedChapter3 = "سوم";
        widget.searchFilters.chapterList.add(_selectedChapter3);
      }
    }
    else if (value == 4)
    {
      if (_selectedChapter4 == "چهارم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter4);
        _selectedChapter4 = null;
      }
      else
      {
        _selectedChapter4 = "چهارم";
        widget.searchFilters.chapterList.add(_selectedChapter4);
      }
    }
    else if (value == 5)
    {
      if (_selectedChapter5 == "پنجم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter5);
        _selectedChapter5 = null;
      }
      else
      {
        _selectedChapter5 = "پنجم";
        widget.searchFilters.chapterList.add(_selectedChapter5);
      }
    }
    else if (value == 6)
    {
      if (_selectedChapter6 == "ششم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter6);
        _selectedChapter6 = null;
      }
      else
      {
        _selectedChapter6 = "ششم";
        widget.searchFilters.chapterList.add(_selectedChapter6);
      }
    }
    else if (value == 7)
    {
      if (_selectedChapter7 == "هفتم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter7);
        _selectedChapter7 = null;
      }
      else
      {
        _selectedChapter7 = "هفتم";
        widget.searchFilters.chapterList.add(_selectedChapter7);
      }
    }
    else if (value == 8)
    {
      if (_selectedChapter8 == "هشتم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter8);
        _selectedChapter8 = null;
      }
      else
      {
        _selectedChapter8 = "هشتم";
        widget.searchFilters.chapterList.add(_selectedChapter8);
      }
    }
    else if (value == 9)
    {
      if (_selectedChapter9 == "نهم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter9);
        _selectedChapter9 = null;
      }
      else
      {
        _selectedChapter9 = "نهم";
        widget.searchFilters.chapterList.add(_selectedChapter9);
      }
    }
    else if (value == 10)
    {
      if (_selectedChapter10 == "دهم")
      {
        widget.searchFilters.chapterList.remove(_selectedChapter10);
        _selectedChapter10 = null;
      }
      else
      {
        _selectedChapter10 = "دهم";
        widget.searchFilters.chapterList.add(_selectedChapter10);
      }
    }

  });
  void onSelectedBookMenu(value) => setState((){
    if (value == 1)
    {
      if (_selectedBook1 == "ریاضی")
      {
        widget.searchFilters.bookList.remove(_selectedBook1);
        _selectedBook1 = null;
      }
      else
      {
        _selectedBook1 = "ریاضی";
        widget.searchFilters.bookList.add(_selectedBook1);
      }
    }
    else if (value == 2)
    {
      if (_selectedBook2 == "فیزیک")
      {
        widget.searchFilters.bookList.remove(_selectedBook2);
        _selectedBook2 = null;
      }
      else
      {
        _selectedBook2 = "فیزیک";
        widget.searchFilters.bookList.add(_selectedBook2);
      }
    }
    else if (value == 3)
    {
      if (_selectedBook3 == "شیمی")
      {
        widget.searchFilters.bookList.remove(_selectedBook3);
        _selectedBook3 = null;
      }
      else
      {
        _selectedBook3 = "شیمی";
        widget.searchFilters.bookList.add(_selectedBook3);
      }
    }
    else if (value == 4)
    {
      if (_selectedBook4 == "زیست")
      {
        widget.searchFilters.bookList.remove(_selectedBook4);
        _selectedBook4 = null;
      }
      else
      {
        _selectedBook4 = "زیست";
        widget.searchFilters.bookList.add(_selectedBook4);
      }
    }
  });
  void onSelectedPayeMenu(value) => setState(() {
    if (value == 1)
    {
      if (_selectedPaye1 == "دهم")
      {
        widget.searchFilters.payeList.remove(_selectedPaye1);
        _selectedPaye1 = null;
      }
      else
      {
        _selectedPaye1 = "دهم";
        widget.searchFilters.payeList.add(_selectedPaye1);
      }
    }
    else if (value == 2)
    {
      if (_selectedPaye2 == "یازدهم")
      {
        widget.searchFilters.payeList.remove(_selectedPaye2);
        _selectedPaye2 = null;
      }
      else
      {
        _selectedPaye2 = "یازدهم";
        widget.searchFilters.payeList.add(_selectedPaye2);
      }
    }
    else if (value == 3)
    {
      if (_selectedPaye3 == "دوازدهم")
      {
        widget.searchFilters.payeList.remove(_selectedPaye3);
        _selectedPaye3 = null;
      }
      else
      {
        _selectedPaye3 = "دوازدهم";
        widget.searchFilters.payeList.add(_selectedPaye3);
      }
    }
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child: PopupMenuButton(
                    child: Text("پایه تحصیلی",textDirection: TextDirection.rtl),
                    onSelected: onSelectedPayeMenu,
                    itemBuilder: (_) => [
                      new CheckedPopupMenuItem(
                        checked: _selectedPaye1 == 'دهم',
                        value: 1,
                        child: Text('دهم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedPaye2 == 'یازدهم',
                        value: 2,
                        child: Text('یازدهم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedPaye3 == 'دوازدهم',
                        value: 3,
                        child: Text('دوازدهم',textDirection: TextDirection.rtl,),
                      ),
                    ],
                  ),
                  )),
              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child:PopupMenuButton(
                    child: Text("درس",textDirection: TextDirection.rtl),
                    onSelected: onSelectedBookMenu,
                    itemBuilder: (_) => [
                      new CheckedPopupMenuItem(
                        checked: _selectedBook1 == 'ریاضی',
                        value: 1,
                        child: Text('ریاضی',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedBook2 == 'فیزیک',
                        value: 2,
                        child: Text('فیزیک',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedBook3 == 'شیمی',
                        value: 3,
                        child: Text('شیمی',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedBook4 == 'زیست',
                        value: 4,
                        child: Text('زیست',textDirection: TextDirection.rtl,),
                      ),
                    ],
                  ),
              )),
              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child: PopupMenuButton(
                    child: Text("فصل",textDirection: TextDirection.rtl),
                    onSelected: onSelectedChapterMenu,
                    itemBuilder: (_) => [
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter1 == 'اول',
                        value: 1,
                        child: Text('اول',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter2 == 'دوم',
                        value: 2,
                        child: Text('دوم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter3 == 'سوم',
                        value: 3,
                        child: Text('سوم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter4 == 'چهارم',
                        value: 4,
                        child: Text('چهارم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter5 == 'پنجم',
                        value: 5,
                        child: Text('پنجم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter6 == 'ششم',
                        value: 6,
                        child: Text('ششم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter7 == 'هفتم',
                        value: 7,
                        child: Text('هفتم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter8 == 'هشتم',
                        value: 8,
                        child: Text('هشتم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter9 == 'نهم',
                        value: 9,
                        child: Text('نهم',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedChapter10 == 'دهم',
                        value: 10,
                        child: Text('دهم',textDirection: TextDirection.rtl,),
                      ),
                    ],
                  ),
              ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child: PopupMenuButton(
                    child: Text("نوع سوال",textDirection: TextDirection.rtl),
                    onSelected: onSelectedKindMenu,
                    itemBuilder: (_) => [
                      new CheckedPopupMenuItem(
                        checked: _selectedKind1 == 'تستی',
                        value: 1,
                        child: Text('تستی',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedKind2 == 'جایخالی',
                        value: 2,
                        child: Text('جایخالی',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedKind3 == 'چند گزینه ای',
                        value: 3,
                        child: Text('چند گزینه ای',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedKind4 == 'تشریحی',
                        value: 4,
                        child: Text('تشریحی',textDirection: TextDirection.rtl,),
                      ),
                    ],
                  ),
              )),
              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child: PopupMenuButton(
                    child: Text("دشواری سوال",textDirection: TextDirection.rtl),
                    onSelected: onSelectedDifficultyMenu,
                    itemBuilder: (_) => [
                      new CheckedPopupMenuItem(
                        checked: _selectedDifficulty1 == 'آسان',
                        value: 1,
                        child: Text('آسان',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedDifficulty2 == 'متوسط',
                        value: 2,
                        child: Text('متوسط',textDirection: TextDirection.rtl,),
                      ),
                      new CheckedPopupMenuItem(
                        checked: _selectedDifficulty3 == 'سخت',
                        value: 3,
                        child: Text('سخت',textDirection: TextDirection.rtl,),
                      ),
                    ],
                  ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}