import 'package:flutter/material.dart';
import 'package:samproject/domain/popupMenuData.dart';

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
      child: (widget.Data.name == null) ? Text(widget.Data.popupMenuBottonName,textDirection: TextDirection.rtl) : Text(widget.Data.name,textDirection: TextDirection.rtl),
      onSelected: onSelectedMenu,
      itemBuilder: (context) => widget.Data.list,
    );
  }
}