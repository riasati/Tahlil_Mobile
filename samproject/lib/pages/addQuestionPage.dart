import 'package:flutter/material.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  TextEditingController QuestionTextController = new TextEditingController();
  FocusNode _focusNodeQuestionText = FocusNode();
   bool showQuestionTextForm = true;
  void _showQuestionTextForm()
  {
      setState(() {
        showQuestionTextForm = true;
      });
  }
  @override
  void initState() {
    super.initState();
  //  _focusHandling(_focusNode,showTextForm);
    _focusNodeQuestionText.addListener(() {
      //print("Has focus: ${_focusNodeQuestionText.hasFocus}");
      if (_focusNodeQuestionText.hasFocus)
      {
        setState(() {
          showQuestionTextForm = true;
        });
      }
      else
        {
          setState(() {
            showQuestionTextForm = false;
          });
        }
    });
  }

  @override
  void dispose() {
    _focusNodeQuestionText.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D5A80),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "ایجاد سوال",
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
            padding: EdgeInsets.all(8.0),
            child: Column(
              textDirection: TextDirection.rtl,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Card(
                    child: Text("سوال جدید"),
                  ),
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text("متن سوال"),
                    ),
                    Container(
                      width: 5,
                    ),
                    Expanded(
                      flex: 5,
                      child: (showQuestionTextForm) ? TextFormField(
                        autofocus: true,
                        textDirection: TextDirection.rtl,
                        controller: QuestionTextController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                          focusNode: _focusNodeQuestionText,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )
                      ) //TopicTextFormField(true)
                          : GestureDetector(
                        onTap: () => _showQuestionTextForm() ,
                            child: Container(
                        //      decoration: BoxShape.rectangle(),
                        child: Text(QuestionTextController.text,textDirection: TextDirection.rtl,maxLines: 3),
                      ),
                          ) ,
                    ),
                    //Rect.largest,
                    //BoxShape.rectangle()
                  ],
                ),
                TextFormField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
