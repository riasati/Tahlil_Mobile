import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SearchQuestionPage extends StatefulWidget {
  @override
  _SearchQuestionPageState createState() => _SearchQuestionPageState();
}

class _SearchQuestionPageState extends State<SearchQuestionPage> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  popupMenuData payeData = new popupMenuData("پایه تحصیلی");
  List<String> payelist = ["دهم","یازدهم","دوازدهم"];
  popupMenuData bookData = new popupMenuData("درس");
  List<String> booklist = ["ریاضی","فیزیک","شیمی","زیست"];
  popupMenuData chapterData = new popupMenuData("فصل");
  List<String> cahpterlist = ["اول","دوم","سوم","چهارم","پنجم","ششم","هفتم","هشتم","نهم","دهم",];
  popupMenuData kindData = new popupMenuData("نوع سوال");
  List<String> kindlist = ["تستی","جایخالی","چند گزینه ای","تشریحی"];
  popupMenuData difficultyData = new popupMenuData("دشواری سوال");
  List<String> difficultylist = ["آسان","متوسط","سخت"];

 @override
  void initState() {
    super.initState();
    payeData.fillStringList(payelist);
    bookData.fillStringList(booklist);
    chapterData.fillStringList(cahpterlist);
    kindData.fillStringList(kindlist);
    difficultyData.fillStringList(difficultylist);
  }

  void submit()
  {
    print(payeData.name);
    print(bookData.name);
    print(chapterData.name);
    print(kindData.name);
    print(difficultyData.name);
    setState(() {
      _btnController.stop();
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
            "جستجو سوال در بانک",
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
          padding: EdgeInsets.all(4.0),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(padding: const EdgeInsets.all(4.0),alignment: Alignment.centerRight,child: Text("جستجو بر اساس",textDirection: TextDirection.rtl,)),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: payeData,))),
                            SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: bookData,))),
                            SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: chapterData,)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: kindData,))),
                            SizedBox(height: 20,width: 1,child: Container(color: Color(0xFF0e918c),),),
                            Expanded(flex: 1,child: Container(alignment: Alignment.center,child: PopupMenu(Data: difficultyData,))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        // RaisedButton(
                        //   child: Text("asdfads"),
                        //   onPressed: submit,
                        // )

                        RoundedLoadingButton(
                          height: 30,
                          child: Text('جستجو',style: TextStyle(color: Colors.white),),
                          //  borderRadius: 0,
                          controller: _btnController,
                          color: Color(0xFF3D5A80),
                          onPressed: () => submit,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
    for (int i = 0;i<widget.Data.stringList.length;i++)
    {
      widget.Data.list.add(popupMenuItem(i, widget.Data.stringList[i]));
    }

  }
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: (widget.Data.name == null) ? Text(widget.Data.popupMenuBottonName) : Text(widget.Data.name),
      onSelected: onSelectedMenu,
      itemBuilder: (context) => widget.Data.list,
    );
  }
}

