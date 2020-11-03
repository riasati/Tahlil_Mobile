import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  TextEditingController QuestionTextController = new TextEditingController();
  FocusNode _focusNodeQuestionText = FocusNode();

  // bool hasfocus = true;
  // void _focusChange(bool isChange)
  // {
  //   print(isChange);
  //   if(isChange)
  //   {
  //     setState(() {
  //       hasfocus = true;
  //     });
  //   }
  //   else
  //     {
  //       setState(() {
  //         hasfocus = false;
  //       });
  //     }
  //
  // }

   bool showQuestionTextForm = true;
  void _showQuestionTextForm()
  {
      setState(() {
        showQuestionTextForm = true;
      });
  }
  void _deleteImage(bool ImageOne)
  {
    setState(() {
      if (ImageOne)
      _ImageOne = null;
      else
        _ImageTwo = null;
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
  File _ImageOne;
  File _ImageTwo;

  final picker = ImagePicker();

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null ) {
        if (_ImageOne == null)
        {
          _ImageOne = File(pickedFile.path);
        }
        else
          {
            _ImageTwo = File(pickedFile.path);
          }
      }
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
                      child: Column(
                        children: [
                          Text("متن سوال"),
                          IconButton(icon: Icon(Icons.camera),onPressed: getImage,tooltip: "می توان فقط عکس هم فرستاد",)
                        ],
                      ),
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
                      )
                          : InkWell(
                        onTap: () => _showQuestionTextForm() ,
                            child: Container(
                        //      decoration: BoxShape.rectangle(),
                        child: Text(QuestionTextController.text,textDirection: TextDirection.rtl,maxLines: 3),
                      ),
                          ) ,
                    ),
                  ],
                ),
                TextFormField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (_ImageOne != null) ? Container(child: InkWell(onTap:() => _deleteImage(true),child: Image.file(_ImageOne,fit: BoxFit.cover)),height: 200,alignment: Alignment.centerLeft,padding: EdgeInsets.all(8.0),)
                        : Container(),
                    (_ImageTwo != null) ? Container(child: InkWell(onTap:() => _deleteImage(false),child: Image.file(_ImageTwo,fit: BoxFit.cover)),alignment: Alignment.centerRight,height: 200,padding: EdgeInsets.all(8.0),)
                    //,fit: BoxFit.cover,alignment: Alignment.center,width: 200,)
                        : Container(),
                  ],
                ),
                // InkWell(
                //   child: (hasfocus) ? TextFormField(controller: QuestionTextController,decoration: InputDecoration(border: OutlineInputBorder()),):  TextFormField(controller: QuestionTextController,readOnly: true,decoration: InputDecoration(border: InputBorder.none),),
                //   onFocusChange: (value) => _focusChange(value),
                // )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
