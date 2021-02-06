import 'package:flutter/material.dart';

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