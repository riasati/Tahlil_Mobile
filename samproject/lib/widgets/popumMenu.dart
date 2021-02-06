import 'package:flutter/material.dart';
import 'package:samproject/domain/popupMenuData.dart';
import 'package:samproject/pages/createExamPage.dart';
import 'package:samproject/pages/editExamPage.dart';
import 'package:samproject/pages/myQuestionPage.dart';

class PopupMenu extends StatefulWidget {
  popupMenuData Data;
 // AddQuestionPageState parent;
  QuestionViewInMyQuestionState parent;
  QuestionViewInCreateExamState parent2;
  CreateExamPageState parent3;
  EditExamPageState parent4;
  QuestionViewInEditExamState parent5;
  PopupMenu({Key key, this.Data,this.parent,this.parent2,this.parent3,this.parent4,this.parent5}) : super(key: key);
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
        if (widget.parent != null)
        {
          widget.parent.setState(() {
          });
        }
        if (widget.parent2 != null)
        {
          widget.parent2.setState(() {
          });
        }
        if (widget.parent3 != null)
        {
          widget.parent3.setState(() {
          });
        }
        if (widget.parent4 != null)
        {
          widget.parent4.setState(() {
          });
        }
        if (widget.parent5 != null)
        {
          widget.parent5.setState(() {
          });
        }
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
    if (widget.Data.list.length != widget.Data.stringList.length)
    {
      for (int i = 0;i<widget.Data.stringList.length;i++)
      {
        widget.Data.list.add(popupMenuItem(i, widget.Data.stringList[i]));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: (widget.Data.name == null) ? Text(widget.Data.popupMenuBottonName,textDirection: TextDirection.rtl,textAlign: TextAlign.center,) : Text(widget.Data.name,textDirection: TextDirection.rtl,textAlign: TextAlign.center),
      onSelected: onSelectedMenu,
      itemBuilder: (context) => widget.Data.list,
    );
  }
}