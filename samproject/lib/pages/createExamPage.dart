import 'package:flutter/material.dart';
import 'package:samproject/domain/controllers.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/domain/question.dart';
import 'package:samproject/pages/homePage.dart';
import 'package:samproject/pages/myQuestionPage.dart';
import 'package:samproject/pages/searchQuestionPage.dart';
import 'package:samproject/utils/showCorrectnessDialog.dart';
import 'package:samproject/widgets/questionWidgets.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
class QuestionViewInCreateExam extends StatefulWidget {
  Question question;
  CreateExamPageState parent;
  QuestionViewInCreateExam({Key key,this.question,this.parent}) : super(key: key);
  @override
  QuestionViewInCreateExamState createState() => QuestionViewInCreateExamState();
}

class QuestionViewInCreateExamState extends State<QuestionViewInCreateExam> {
  Controllers controllers = new Controllers();
  bool IsDelete = false;
  bool IsEdit = false;
  popupMenuData payeData;
  popupMenuData bookData;
  popupMenuData chapterData;
  popupMenuData kindData;
  popupMenuData difficultyData;

  Widget Editing(Question question,VoidCallback onCloseButton,Controllers controllers)//VoidCallback onEditButton,VoidCallback onCloseButton
  {
    void onEditButton()
    {
      widget.question.grade = double.tryParse(controllers.GradeController.text);
      widget.question.text = controllers.QuestionTextController.text;
      widget.question.paye = payeData.name;
      widget.question.book = bookData.name;
      widget.question.chapter = chapterData.name;
      widget.question.kind = kindData.name;
      widget.question.difficulty = difficultyData.name;

      if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"])
      {
        widget.question.optionOne = controllers.MultiOptionText1Controller.text;
        widget.question.optionTwo = controllers.MultiOptionText2Controller.text;
        widget.question.optionThree = controllers.MultiOptionText3Controller.text;
        widget.question.optionFour = controllers.MultiOptionText4Controller.text;
      }
      else if (widget.question.kind == HomePage.maps.SKindMap["TEST"])
      {
        widget.question.optionOne = controllers.TestText1Controller.text;
        widget.question.optionTwo = controllers.TestText2Controller.text;
        widget.question.optionThree = controllers.TestText3Controller.text;
        widget.question.optionFour = controllers.TestText4Controller.text;
      }
      else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]){
        widget.question.answerString = controllers.TashrihiTextController.text;
      }
      else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"])
      {
        widget.question.answerString = controllers.BlankTextController.text;
      }

      setState(() {
        IsEdit = false;
      });
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            Row(
              children: [
                Flexible(flex: 1,child: IconButton(icon: Icon(Icons.clear),onPressed: onCloseButton,)),
                Flexible(flex: 12,child: EditingOneLineQuestionSpecification(question: widget.question,payeData: payeData,bookData: bookData,kindData: kindData,chapterData: chapterData,difficultyData: difficultyData,parent2: this,)),
              ],
            ),
            EditingQuestionText(controllers: controllers,question: widget.question,),
            if (kindData.name == HomePage.maps.SKindMap["MULTICHOISE"]) EditingMultiChoiceOption(controllers: controllers,question: widget.question,)
            else if (kindData.name == HomePage.maps.SKindMap["TEST"]) EditingTest(question: widget.question,controllers: controllers,)
            else if (kindData.name == HomePage.maps.SKindMap["SHORTANSWER"]) EditingShortAnswer(question: widget.question,controllers: controllers,)
            else if (kindData.name == HomePage.maps.SKindMap["LONGANSWER"]) EditingLongAnswer(question: widget.question,controllers: controllers,),
            EditingGrade(controllers: controllers,),
            EditAndAddtoExamButton(onEditPressed: onEditButton,IsAddtoExamEnable: false),
          ],
        ),
      ),
    );
  }
  Widget NotEditing(Question question,VoidCallback onCloseButton,)
  {
    void onEditButton()
    {
      setState(() {
        IsEdit = true;
      });
    }
    return Card(
      child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: [
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Flexible(flex: 1,child: IconButton(icon: Icon(Icons.clear),onPressed: onCloseButton,)),
                      Flexible(flex: 12,child: NotEditingQuestionSpecification(question: question,)),
                    ],
                  ),
                  //    NotEditingQuestionSpecification(question: question,),
                  NotEditingQuestionText(question: question,),
                  if (widget.question.kind == HomePage.maps.SKindMap["MULTICHOISE"]) NotEditingMultiChoiceOption(question: question,isNull: true,)
                  else if (widget.question.kind == HomePage.maps.SKindMap["TEST"]) NotEditingTest(question: question)
                  else if (widget.question.kind == HomePage.maps.SKindMap["SHORTANSWER"]) NotEditingAnswerString(question: question)
                  else if (widget.question.kind == HomePage.maps.SKindMap["LONGANSWER"]) NotEditingAnswerString(question: question),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(alignment: Alignment.centerRight,child: (question.grade == null) ? Text("بارم : 0.0",textDirection: TextDirection.rtl):Text("نبارم : "+ question.grade.toString(),textDirection: TextDirection.rtl)),
              ),
              EditAndAddtoExamButton(onEditPressed: onEditButton,IsAddtoExamEnable: false),
            ],
          )
      ),
    );
  }
  void onCloseButton() async
  {
    CreateExamPage.questionList.remove(widget.question);
    widget.parent.setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    controllers.FillQuestionTextController(widget.question.text);
    controllers.FillMultiOptionText1Controller(widget.question.optionOne);
    controllers.FillMultiOptionText2Controller(widget.question.optionTwo);
    controllers.FillMultiOptionText3Controller(widget.question.optionThree);
    controllers.FillMultiOptionText4Controller(widget.question.optionFour);
    controllers.FillTestText1Controller(widget.question.optionOne);
    controllers.FillTestText2Controller(widget.question.optionTwo);
    controllers.FillTestText3Controller(widget.question.optionThree);
    controllers.FillTestText4Controller(widget.question.optionFour);
    controllers.FillTashrihiTextController(widget.question.answerString);
    controllers.FillBlankTextController(widget.question.answerString);
    controllers.FillGradeController(widget.question.grade.toString());
    if (widget.question.grade == null)
    {
      controllers.FillGradeController("0.0");
    }

    payeData = new popupMenuData("پایه تحصیلی");
    bookData = new popupMenuData("درس");
    chapterData = new popupMenuData("فصل");
    kindData = new popupMenuData("نوع سوال");
    difficultyData = new popupMenuData("دشواری سوال");
    kindData.name = widget.question.kind;

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          (IsDelete == false) ?
          ((IsEdit == false) ? NotEditing(widget.question,onCloseButton)
              : Editing(widget.question,onCloseButton,controllers))
              : Container(),
        ],
      ),
    );
  }
}

class CreateExamPage extends StatefulWidget {
  static List<Question> questionList = [];
  @override
  CreateExamPageState createState() => CreateExamPageState();
}

class CreateExamPageState extends State<CreateExamPage> {
  TextEditingController examTopic = new TextEditingController();
  TextEditingController examDate = new TextEditingController();
  TextEditingController examStartTime = new TextEditingController();
  TextEditingController examFinishTime = new TextEditingController();
  TextEditingController examDurationTime = new TextEditingController();

  bool presedCreatedNewQuestion = false;
  Controllers controller = new Controllers();
  Question newQuestion = new Question();
  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  popupMenuData bookData = new popupMenuData("درس");
  popupMenuData chapterData = new popupMenuData("فصل");
  popupMenuData kindData = new popupMenuData("نوع سوال");
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");

  //List<DragAndDropList> _contents = [];

  void ClickAddQuestion()
  {
    setState(() {
      (presedCreatedNewQuestion == false) ? presedCreatedNewQuestion = true : presedCreatedNewQuestion = false;
    });

  }
  void onCreateQuestion()
  {
    newQuestion.text = controller.QuestionTextController.text;
    newQuestion.paye = payeData.name;
    newQuestion.book = bookData.name;
    newQuestion.chapter = chapterData.name;
    newQuestion.kind = kindData.name;
    newQuestion.difficulty = difficultyData.name;
    newQuestion.grade = double.tryParse(controller.GradeController.text);
    if (newQuestion.text == null || newQuestion.paye == null || newQuestion.book == null || newQuestion.chapter == null || newQuestion.difficulty == null || newQuestion.kind == null)
    {
      ShowCorrectnessDialog(false, context);
      return ;
    }
    if (newQuestion.kind == HomePage.maps.SKindMap["SHORTANSWER"])
    {
      newQuestion.answerString = controller.BlankTextController.text;
    }
    else if (newQuestion.kind == HomePage.maps.SKindMap["TEST"])
    {
      newQuestion.optionOne = controller.TestText1Controller.text;
      newQuestion.optionTwo = controller.TestText2Controller.text;
      newQuestion.optionThree = controller.TestText3Controller.text;
      newQuestion.optionFour = controller.TestText4Controller.text;
    }
    else if (newQuestion.kind == HomePage.maps.SKindMap["MULTICHOISE"])
    {
      newQuestion.optionOne = controller.MultiOptionText1Controller.text;
      newQuestion.optionTwo = controller.MultiOptionText2Controller.text;
      newQuestion.optionThree = controller.MultiOptionText3Controller.text;
      newQuestion.optionFour = controller.MultiOptionText4Controller.text;
    }
    else if (newQuestion.kind == HomePage.maps.SKindMap["LONGANSWER"])
    {
      newQuestion.answerString = controller.TashrihiTextController.text;
    }
    print(newQuestion.text);
    print(newQuestion.paye);
    print(newQuestion.book);
    print(newQuestion.chapter);
    print(newQuestion.difficulty);
    print(newQuestion.answerString);
    print(newQuestion.optionOne);
    print(newQuestion.numberOne);

    Question addQuestion = newQuestion.CopyQuestion();
    CreateExamPage.questionList.add(addQuestion);
    newQuestion = new Question();
    controller = new Controllers();
    setState(() {
    //  dragAndDrop();
    });
  }
  void ClickMyQuestion()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyQuestionPage(IsAddtoExamEnable: true,parent:this),
      ),
    );
    // setState(() {
    //   dragAndDrop();
    // });
  }
  void ClickSearchQuestion()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchQuestionPage(IsAddtoExamEnable: true,parent:this),
      ),
    );
   // Navigator.pop(context);
   //  setState(() {
   // //   dragAndDrop();
   //  });
  }
  // _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
  //   setState(() {
  //     var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
  //     _contents[newListIndex].children.insert(newItemIndex, movedItem);
  //   });
  // }
  //
  // _onListReorder(int oldListIndex, int newListIndex) {
  //   setState(() {
  //     var movedList = _contents.removeAt(oldListIndex);
  //     _contents.insert(newListIndex, movedList);
  //   });
  // }
  // void dragAndDrop()
  // {
  //   List<DragAndDropItem> items = [];
  //   for (int i = 0 ;i<CreateExamPage.questionList.length;i++)
  //   {
  //     items.add(DragAndDropItem(child: QuestionView(question: CreateExamPage.questionList[i] ,parent: this,)));
  //   }
  //   _contents.clear();
  //   _contents.add(DragAndDropList(
  //       children: items)
  //   );
  //   setState(() {
  //
  //   });
  //
  //   // Flexible(
  //   //   child: DragAndDropLists(
  //   //     children: _contents,
  //   //     onItemReorder: _onItemReorder,
  //   //     onListReorder: _onListReorder,
  //   //   ),
  //   // ),
  //
  //
  //   // return DragAndDropList(
  //   //   children: items
  //   // );
  // }
  @override
  void initState() {
    super.initState();
 //   dragAndDrop();
  //  _contents = [];
  //  _contents.add(dragAndDrop());

    // _contents.add(
    //   DragAndDropList(
    //     children: [
    //       DragAndDropItem(
    //        child: QuestionView(question: CreateExamPage.questionList[0] ,parent: this,))
    //     ]
    //   )
    // );
  //   _contents = List.generate(10, (index) {
  //     return DragAndDropList(
  // //      header: Text('Header $index'),
  //       children: <DragAndDropItem>[
  //         DragAndDropItem(
  //           child: Text('$index.1'),
  //         ),
  //         DragAndDropItem(
  //           child: Text('$index.2'),
  //         ),
  //         DragAndDropItem(
  //           child: Text('$index.3'),
  //         ),
  //       ],
  //     );
  //   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "ایجاد آزمون",
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
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              // DragAndDropLists(
              // children: _contents,
              // onItemReorder: _onItemReorder,
              // onListReorder: _onListReorder,
              // ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              //   child: Text("عنوان آزمون",textDirection: TextDirection.rtl,),
                              // ),
                              Expanded(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    textDirection: TextDirection.rtl,
                                    controller: examTopic,
                                    textAlign: TextAlign.right,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: "عنوان آزمون",
                                      border: OutlineInputBorder(),
                                      // isCollapsed: true,
                                      // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                    ),
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("تاریخ آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examDate,
                        //             textAlign: TextAlign.right,
                        //             keyboardType: TextInputType.datetime,
                        //             decoration: InputDecoration(
                        //               hintText: "1399/9/2",
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("زمان شروع آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examStartTime,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.right,
                        //             decoration: InputDecoration(
                        //               hintText: "17:30",
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("زمان اتمام آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examFinishTime,
                        //             textAlign: TextAlign.right,
                        //             keyboardType: TextInputType.number,
                        //             decoration: InputDecoration(
                        //               hintText: "18:0",
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //             //decoration: InputDecoration(border: OutlineInputBorder()),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //         child: Text("زمان آزمون",textDirection: TextDirection.rtl,),
                        //       ),
                        //       Expanded(
                        //           child: TextFormField(
                        //             textDirection: TextDirection.rtl,
                        //             controller: examDurationTime,
                        //             textAlign: TextAlign.right,
                        //             keyboardType: TextInputType.number,
                        //             decoration: InputDecoration(
                        //               hintText: "به دقیقه",
                        //               hintStyle: TextStyle(fontSize: 12),
                        //               border: OutlineInputBorder(),
                        //               isCollapsed: true,
                        //               contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                        //             ),
                        //             //decoration: InputDecoration(border: OutlineInputBorder()),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("تاریخ آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            textDirection: TextDirection.rtl,
                                            controller: examDate,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.datetime,
                                            decoration: InputDecoration(
                                              labelText: "تاریخ آزمون",
                                              hintText: "1399/9/2",
                                              border: OutlineInputBorder(),
                                              // isCollapsed: true,
                                              // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("زمان آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            textDirection: TextDirection.rtl,
                                            controller: examDurationTime,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "زمان آزمون",
                                              hintText: "به دقیقه",
                                              hintStyle: TextStyle(fontSize: 10),
                                              border: OutlineInputBorder(),
                                              // isCollapsed: true,
                                              // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                            ),
                                            //decoration: InputDecoration(border: OutlineInputBorder()),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("شروع آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          textDirection: TextDirection.rtl,
                                          controller: examStartTime,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            labelText: "شروع آزمون",
                                            hintText: "17:30",
                                            border: OutlineInputBorder(),
                                            // isCollapsed: true,
                                            // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              SizedBox(width: 10,),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   child: Text("اتمام آزمون",textDirection: TextDirection.rtl,),
                                    // ),
                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          textDirection: TextDirection.rtl,
                                          controller: examFinishTime,
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: "اتمام آزمون",
                                            hintText: "18:00",
                                            border: OutlineInputBorder(),
                                            // isCollapsed: true,
                                            // contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                                          ),
                                          //decoration: InputDecoration(border: OutlineInputBorder()),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              //       child: Text("زمان شروع آزمون",textDirection: TextDirection.rtl,),
                              //     ),
                              //     Flexible(
                              //       flex: 1,
                              //         child: TextFormField(
                              //           textDirection: TextDirection.rtl,
                              //           controller: examStartTime,
                              //           keyboardType: TextInputType.number,
                              //           textAlign: TextAlign.right,
                              //           decoration: InputDecoration(
                              //             hintText: "17:30",
                              //             border: OutlineInputBorder(),
                              //             isCollapsed: true,
                              //             contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                              //           ),
                              //         )
                              //     )
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              //       child: Text("زمان اتمام آزمون",textDirection: TextDirection.rtl,),
                              //     ),
                              //     Flexible(
                              //       flex: 1,
                              //         child: TextFormField(
                              //           textDirection: TextDirection.rtl,
                              //           controller: examFinishTime,
                              //           textAlign: TextAlign.right,
                              //           keyboardType: TextInputType.number,
                              //           decoration: InputDecoration(
                              //             hintText: "18:0",
                              //             border: OutlineInputBorder(),
                              //             isCollapsed: true,
                              //             contentPadding:EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                              //           ),
                              //           //decoration: InputDecoration(border: OutlineInputBorder()),
                              //         )
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:  CreateExamPage.questionList.length,
                      itemBuilder: (BuildContext context, int index)
                      {
                        return QuestionViewInCreateExam(question: CreateExamPage.questionList[index],parent: this,);
                      }
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(padding: const EdgeInsets.all(4.0),alignment: Alignment.centerRight,child: Text("اضافه کردن سوال بر اساس",textDirection: TextDirection.rtl,)),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              textColor: Colors.white,
                              color: Color(0xFF3D5A80),
                              child: Text("ایجاد سوال"),
                              onPressed: ClickAddQuestion
                             ),
                            RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xFF3D5A80),
                                child: Text("سوالات من"),
                                onPressed: ClickMyQuestion
                            ),
                            RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xFF3D5A80),
                                child: Text("بانک سوال"),
                                onPressed: ClickSearchQuestion
                            ),
                          ],
                        ),
                        (presedCreatedNewQuestion)? Column(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            EditingQuestionText(question: newQuestion,controllers: controller,),
                            EditingTwoLineQuestionSpecification(question: newQuestion,payeData: payeData,bookData: bookData,chapterData: chapterData,kindData: kindData,difficultyData: difficultyData,parent: this,),
                            (kindData.name == HomePage.maps.SKindMap["MULTICHOISE"]) ? EditingMultiChoiceOption(question: newQuestion,controllers: controller,) : Container(),
                            (kindData.name == HomePage.maps.SKindMap["SHORTANSWER"]) ? EditingShortAnswer(question: newQuestion,controllers: controller,) : Container(),
                            (kindData.name == HomePage.maps.SKindMap["LONGANSWER"]) ? EditingLongAnswer(question: newQuestion,controllers: controller,) : Container(),
                            (kindData.name == HomePage.maps.SKindMap["TEST"]) ? EditingTest(question: newQuestion,controllers: controller,) : Container(),
                            EditingGrade(controllers: controller,),
                            AddInBankOption(question: newQuestion,),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Color(0xFF3D5A80),
                              child: Text("ایجاد سوال"),
                              onPressed: onCreateQuestion,
                            ),
                          ],
                        ) : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
    );
  }
}