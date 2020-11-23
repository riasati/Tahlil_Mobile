import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/widgets/popumMenu.dart';
import 'package:samproject/domain/controllers.dart';
import 'package:samproject/domain/searchFilters.dart';
import 'package:samproject/pages/createExamPage.dart';
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

class VisitAnswerAndAddtoExamButton extends StatelessWidget {
  final VoidCallback onVisitAnswerPressed;
  final VoidCallback onAddtoExamPressed;
  bool IsAddtoExamEnable = false;
  VisitAnswerAndAddtoExamButton({Key key, this.onVisitAnswerPressed,this.onAddtoExamPressed,this.IsAddtoExamEnable = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (IsAddtoExamEnable) ? Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
            textColor: Colors.white,
            color: Color(0xFF3D5A80),
            child: Text("دیدن پاسخ"),
            onPressed: onVisitAnswerPressed),
        RaisedButton(
            textColor: Colors.white,
            color: Color(0xFF3D5A80),
            child: Text("اضافه کردن به آزمون"),
            onPressed: onAddtoExamPressed),
      ],
    ) :
    RaisedButton(
        textColor: Colors.white,
        color: Color(0xFF3D5A80),
        child: Text("دیدن پاسخ"),
        onPressed: onVisitAnswerPressed);
  }
}

class EditAndAddtoExamButton extends StatelessWidget {
  EditAndAddtoExamButton({Key key, this.onEditPressed,this.onCancelPressed,this.onAddtoExamPressed,this.IsAddtoExamEnable = false,this.IsEditing = false}) : super(key: key);
  final VoidCallback onEditPressed;
  final VoidCallback onCancelPressed;
  final VoidCallback onAddtoExamPressed;
  bool IsEditing = false;
  bool IsAddtoExamEnable = false;
  @override
  Widget build(BuildContext context) {
    return (IsAddtoExamEnable) ? Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // RaisedButton(
        //     textColor: Colors.white,
        //     color: Color(0xFF3D5A80),
        //     child: Text("ويرايش"),
        //     onPressed: onEditPressed),
        RaisedButton(
            textColor: Colors.white,
            color: Color(0xFF3D5A80),
            child: Text("اضافه کردن به آزمون"),
            onPressed: onAddtoExamPressed),
      ],
    ) :(IsEditing) ?
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF3D5A80),
                child: Text("ويرايش"),
                onPressed: onEditPressed),
            RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF3D5A80),
                child: Text("انصراف"),
                onPressed: onCancelPressed)
          ],
        ): RaisedButton(
            textColor: Colors.white,
            color: Color(0xFF3D5A80),
            child: Text("ويرايش"),
              onPressed: onEditPressed);
  }
}

class EditingOneLineQuestionSpecification extends StatefulWidget {
  Question question;
  popupMenuData payeData;
  popupMenuData bookData;
  popupMenuData chapterData;
  popupMenuData kindData;
  popupMenuData difficultyData;
  QuestionViewInMyQuestionState parent;
  QuestionViewInCreateExamState parent2;
  EditingOneLineQuestionSpecification({Key key, this.question,this.payeData,this.bookData,this.chapterData,this.kindData,this.difficultyData,this.parent,this.parent2}) : super(key: key);
  @override
  _EditingOneLineQuestionSpecificationState createState() => _EditingOneLineQuestionSpecificationState();
}

class _EditingOneLineQuestionSpecificationState extends State<EditingOneLineQuestionSpecification> {
  //popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  List<String> payelist = [];// ["دهم","یازدهم","دوازدهم"];
  // popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = [];// ["ریاضی","فیزیک","شیمی","زیست"];
  // popupMenuData chapterData = new popupMenuData("فصل");
  List<String> chapterlist = [];// ["اول","دوم","سوم","چهارم","پنجم","ششم","هفتم","هشتم","نهم","دهم",];
  // popupMenuData kindData = new popupMenuData("نوع سوال");
  List<String> kindlist = [];// ["تست","پاسخ کوتاه","چند گزینه ای","جواب کامل"];
  // popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = [];// = ["آسان","متوسط","سخت"];

  @override
  void initState() {
    super.initState();
    HomePage.maps.SPayeMap.forEach((k,v) => payelist.add(v.toString()));
    HomePage.maps.SBookMap.forEach((k,v) => booklist.add(v.toString()));
    HomePage.maps.SChapterMap.forEach((k,v) => chapterlist.add(v.toString()));
    HomePage.maps.SKindMap.forEach((k,v) => kindlist.add(v.toString()));
    HomePage.maps.SDifficultyMap.forEach((k,v) => difficultylist.add(v.toString()));
    if (widget.payeData.list.isEmpty)
    {
      widget.payeData.fillStringList(payelist);
      widget.bookData.fillStringList(booklist);
      widget.chapterData.fillStringList(chapterlist);
      widget.kindData.fillStringList(kindlist);
      widget.difficultyData.fillStringList(difficultylist);
    }
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

          Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.kindData,parent: widget.parent,parent2: widget.parent2,))),
       //   Flexible(flex: 2,child: Text((widget.question.kind != null) ? widget.kindData.name : widget.kindData.popupMenuBottonName,textDirection: TextDirection.rtl)),//PopupMenu(Data: widget.kindData,)
          Flexible(child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.difficultyData,))),
        ],
      ),
    );
  }
}

class EditingTwoLineQuestionSpecification extends StatefulWidget {
  Question question;
  popupMenuData payeData;
  popupMenuData bookData;
  popupMenuData chapterData;
  popupMenuData kindData;
  popupMenuData difficultyData;
  CreateExamPageState parent;

  EditingTwoLineQuestionSpecification({Key key, this.question,this.payeData,this.bookData,this.chapterData,this.kindData,this.difficultyData,this.parent}) : super(key: key);
  @override
  _EditingTwoLineQuestionSpecificationState createState() => _EditingTwoLineQuestionSpecificationState();
}

class _EditingTwoLineQuestionSpecificationState extends State<EditingTwoLineQuestionSpecification> {
  //popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  List<String> payelist = [];// ["دهم","یازدهم","دوازدهم"];
  // popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = [];// ["ریاضی","فیزیک","شیمی","زیست"];
  // popupMenuData chapterData = new popupMenuData("فصل");
  List<String> chapterlist = [];// ["اول","دوم","سوم","چهارم","پنجم","ششم","هفتم","هشتم","نهم","دهم",];
  // popupMenuData kindData = new popupMenuData("نوع سوال");
  List<String> kindlist = [];// ["تست","پاسخ کوتاه","چند گزینه ای","جواب کامل"];
  // popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = [];// = ["آسان","متوسط","سخت"];


  @override
  void initState() {
    super.initState();
    HomePage.maps.SPayeMap.forEach((k,v) => payelist.add(v.toString()));
    HomePage.maps.SBookMap.forEach((k,v) => booklist.add(v.toString()));
    HomePage.maps.SChapterMap.forEach((k,v) => chapterlist.add(v.toString()));
    HomePage.maps.SKindMap.forEach((k,v) => kindlist.add(v.toString()));
    HomePage.maps.SDifficultyMap.forEach((k,v) => difficultylist.add(v.toString()));

    if (widget.payeData.list.isEmpty)
    {
      widget.payeData.fillStringList(payelist);
      widget.bookData.fillStringList(booklist);
      widget.chapterData.fillStringList(chapterlist);
      widget.kindData.fillStringList(kindlist);
      widget.difficultyData.fillStringList(difficultylist);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.payeData,))),
                SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.bookData,))),
                SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.chapterData,))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 1,child: Container(alignment: Alignment.center,child:PopupMenu(Data: widget.kindData,parent3: widget.parent,))),
                SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: widget.difficultyData,))),
              ],
            ),
          ),
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
      if (widget.question.isPublic != null)
      {
        addQuestionBankOption = widget.question.isPublic;
      }
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

class EditingGrade extends StatelessWidget {
  Controllers controllers;
  EditingGrade({Key key, @required this.controllers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text("بارم",textDirection: TextDirection.rtl,),
          ),
        //  SizedBox(width: 30,),
          Expanded(
            child: TextFormField(
            textDirection: TextDirection.rtl,
            controller: controllers.GradeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),)
        ],
      ),
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

class EditingShortAnswer extends StatelessWidget {
  Question question;
  Controllers controllers;
  EditingShortAnswer({Key key, @required this.controllers,this.question}) : super(key: key);
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
              Text("پاسخ سوال",textDirection: TextDirection.rtl,),
              Expanded(
                  child:TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: controllers.BlankTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EditingLongAnswer extends StatefulWidget {
  Question question;
  Controllers controllers;
  EditingLongAnswer({Key key, @required this.controllers,this.question}) : super(key: key);
  @override
  _EditingLongAnswerState createState() => _EditingLongAnswerState();
}

class _EditingLongAnswerState extends State<EditingLongAnswer> {
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
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Column(
                children: [
                  Text("پاسخ سوال",textDirection: TextDirection.rtl,),
                  IconButton(icon: Icon(Icons.camera),onPressed: getAnswerImage,tooltip: "می توان فقط عکس هم فرستاد",),
                ],
              ),
              Expanded(
                  child:TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: widget.controllers.TashrihiTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )

              ),
            ],
          ),
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
  void onSelectedDifficultyMenu(value) => setState((){
    for(int i = 0;i<difficultykeys.length;i++)
    {
      if (value == i)
      {
        if (difficultyMap[difficultykeys[i]])
        {
          widget.searchFilters.difficultyList.remove(difficultykeys[i]);
          difficultyMap[difficultykeys[i]] = false;
        }
        else
        {
          widget.searchFilters.difficultyList.add(difficultykeys[i]);
          difficultyMap[difficultykeys[i]] = true;
        }
      }
    }
  });
  void onSelectedKindMenu(value) => setState((){
    for(int i = 0;i<kindkeys.length;i++)
    {
      if (value == i)
      {
        if (kindMap[kindkeys[i]])
        {
          widget.searchFilters.kindList.remove(kindkeys[i]);
          kindMap[kindkeys[i]] = false;
        }
        else
        {
          widget.searchFilters.kindList.add(kindkeys[i]);
          kindMap[kindkeys[i]] = true;
        }
      }
    }
  });
  void onSelectedChapterMenu(value) => setState((){
    for(int i = 0;i<chapterkeys.length;i++)
    {
      if (value == i)
      {
        if (chapterMap[chapterkeys[i]])
        {
          widget.searchFilters.chapterList.remove(chapterkeys[i]);
          chapterMap[chapterkeys[i]] = false;
        }
        else
        {
          widget.searchFilters.chapterList.add(chapterkeys[i]);
          chapterMap[chapterkeys[i]] = true;
        }
      }
    }

  });
  void onSelectedBookMenu(value) => setState((){
    for(int i = 0;i<bookkeys.length;i++)
    {
      if (value == i)
      {
        if (bookMap[bookkeys[i]])
        {
          widget.searchFilters.bookList.remove(bookkeys[i]);
          bookMap[bookkeys[i]] = false;
        }
        else
        {
          widget.searchFilters.bookList.add(bookkeys[i]);
          bookMap[bookkeys[i]] = true;
        }
      }
    }
  });
  void onSelectedPayeMenu(value) => setState(() {
    for(int i = 0;i<payekeys.length;i++)
    {
      if (value == i)
      {
        if (payeMap[payekeys[i]])
        {
          widget.searchFilters.payeList.remove(payekeys[i]);
          payeMap[payekeys[i]] = false;
        }
        else
        {
          widget.searchFilters.payeList.add(payekeys[i]);
          payeMap[payekeys[i]] = true;
        }
      }
    }
  });

  Map<String,bool> payeMap = {};
  List<CheckedPopupMenuItem> payeList = [];
  List payekeys = [];

  Map<String,bool> bookMap = {};
  List<CheckedPopupMenuItem> bookList = [];
  List bookkeys = [];

  Map<String,bool> chapterMap = {};
  List<CheckedPopupMenuItem> chapterList = [];
  List chapterkeys = [];

  Map<String,bool> kindMap = {};
  List<CheckedPopupMenuItem> kindList = [];
  List kindkeys = [];

  Map<String,bool> difficultyMap = {};
  List<CheckedPopupMenuItem> difficultyList = [];
  List difficultykeys = [];

  @override
  void initState() {
    super.initState();
    HomePage.maps.SPayeMap.forEach((k,v) => payeMap.putIfAbsent(v, () => false));
    payekeys = payeMap.keys.toList();

    HomePage.maps.SBookMap.forEach((k,v) => bookMap.putIfAbsent(v, () => false));
    bookkeys = bookMap.keys.toList();

    HomePage.maps.SChapterMap.forEach((k,v) => chapterMap.putIfAbsent(v, () => false));
    chapterkeys = chapterMap.keys.toList();

    HomePage.maps.SKindMap.forEach((k,v) => kindMap.putIfAbsent(v, () => false));
    kindkeys = kindMap.keys.toList();

    HomePage.maps.SDifficultyMap.forEach((k,v) => difficultyMap.putIfAbsent(v, () => false));
    difficultykeys = difficultyMap.keys.toList();

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child: PopupMenuButton(
                    child: Text("پایه تحصیلی",textDirection: TextDirection.rtl),
                    onSelected: onSelectedPayeMenu,
                    itemBuilder: (_) {
                      payeList = [];
                      for(int i=0;i<payekeys.length;i++)
                      {
                        payeList.add(new CheckedPopupMenuItem(
                          value: i,
                          child: Text(payekeys[i],textDirection: TextDirection.rtl,),
                          checked: (payeMap[payekeys[i]]),
                        ));
                      }
                      return payeList;}
                  ),
                  )),
              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child:PopupMenuButton(
                    child: Text("درس",textDirection: TextDirection.rtl),
                    onSelected: onSelectedBookMenu,
                    itemBuilder: (_)
                    {
                      bookList = [];
                      for(int i=0;i<bookkeys.length;i++)
                      {
                        bookList.add(new CheckedPopupMenuItem(
                          value: i,
                          child: Text(bookkeys[i],textDirection: TextDirection.rtl,),
                          checked: (bookMap[bookkeys[i]]),
                        ));
                      }
                      return bookList;
                    }
                  ),
              )),
              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child: PopupMenuButton(
                    child: Text("فصل",textDirection: TextDirection.rtl),
                    onSelected: onSelectedChapterMenu,
                    itemBuilder: (_)
                    {
                      chapterList = [];
                      for(int i=0;i<chapterkeys.length;i++)
                      {
                        chapterList.add(new CheckedPopupMenuItem(
                          value: i,
                          child: Text(chapterkeys[i],textDirection: TextDirection.rtl,),
                          checked: (chapterMap[chapterkeys[i]]),
                        ));
                      }
                      return chapterList;
                    }
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
                    itemBuilder: (_)
                    {
                      kindList = [];
                      for(int i=0;i<kindkeys.length;i++)
                      {
                        kindList.add(new CheckedPopupMenuItem(
                          value: i,
                          child: Text(kindkeys[i],textDirection: TextDirection.rtl,),
                          checked: (kindMap[kindkeys[i]]),
                        ));
                      }
                      return kindList;
                    }
                  ),
              )),
              SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
              Expanded(flex: 1,child: Container(alignment: Alignment.center,
                  child: PopupMenuButton(
                    child: Text("دشواری سوال",textDirection: TextDirection.rtl),
                    onSelected: onSelectedDifficultyMenu,
                    itemBuilder: (_)
                    {
                      difficultyList = [];
                      for(int i=0;i<difficultykeys.length;i++)
                      {
                        difficultyList.add(new CheckedPopupMenuItem(
                          value: i,
                          child: Text(difficultykeys[i],textDirection: TextDirection.rtl,),
                          checked: (difficultyMap[difficultykeys[i]]),
                        ));
                      }
                      return difficultyList;
                    }
                  ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}