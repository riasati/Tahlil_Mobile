import 'package:flutter/material.dart';
Future<void> ShowCorrectnessDialog(bool Correct,BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: (Correct) ? Text('صحیح',textDirection: TextDirection.rtl,) : Text('خطا',textDirection: TextDirection.rtl,),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              (Correct)? Text("عملیات با موفقیت انجام شد",textDirection: TextDirection.rtl,) : Text("مشکلی در اجرای عملیات وجود دارد",textDirection: TextDirection.rtl,),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('باشه',textDirection: TextDirection.rtl,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}