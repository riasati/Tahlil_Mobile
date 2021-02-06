import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  List<int> questions = [];
  int _focusedIndex = 0;
  GlobalKey<ScrollSnapListState> questionRouterKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 30; i++) {
      questions.add(Random().nextInt(100) + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
          // border: Border.all(10)
          ),
      height: 70,
      child: Row(
        children: [
          Expanded(child: previousButton()),
          Expanded(
            flex: 3,
            child: questionRouter()
          ),
          Expanded(
              child: nextButton()),
        ],
      ),
    );
  }

  Widget previousButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF3D5A80),
      ),
      margin: EdgeInsets.only(left: 3),
      child: MaterialButton(
        child: Text(
          "قبلی",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: (){
          setState(() {
            questionRouterKey.currentState.focusToItem(_focusedIndex-1);
          });
        },
      ),
    );
  }

  Widget nextButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF3D5A80),
      ),
      margin: EdgeInsets.only(right: 3),
      child: MaterialButton(
        child: Text(
          "بعدی",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: (){
          setState(() {
            questionRouterKey.currentState.focusToItem(_focusedIndex+1);
          });
        },
      ),
    );
  }

  Widget questionRouter(){
    return Padding(
      child: Center(
        child: ScrollSnapList(
          onItemFocus: _onItemFocus,
          itemSize: 40,
          itemBuilder: _buildListItem,
          itemCount: questions.length,
          key: questionRouterKey,
          dynamicItemSize: true,
          reverse: false,
          // dynamicSizeEquation: (distance) {
          //   return 1;
          // },
          margin: EdgeInsets.only(left:10, right: 10),
          scrollDirection: Axis.horizontal,
          dynamicItemOpacity: 0.8,

        ),
      ),
      padding: EdgeInsets.only(right: 10, left: 10),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    //horizontal
    return Container(
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            questionRouterKey.currentState.focusToItem(index);
          });
        },
        color: Colors.red,
        textColor: Colors.white,
        height: 10,
        child: Text(
          "2",
        ),

        shape: CircleBorder(),
      ),
      width: 40,
    );
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }
}
