import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samproject/Layout/BottomNavigator.dart';

class HomePage extends StatefulWidget {
  static final PageController homePageController = PageController(
    initialPage: 2,
  );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double responsiveDivision = MediaQuery.of(context).devicePixelRatio / 1.2;
    return Scaffold(
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: Container(
        child: FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.home,
          ),
          backgroundColor: Colors.deepPurple,
          onPressed: _pressHomeButton,
        ),
        width: 60 / responsiveDivision,
        height: 60 / responsiveDivision,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex:3,
                child: PageView(
                  controller: HomePage.homePageController,
                  onPageChanged: (i) {
                    if (i == 0) {
                      setState(() {
                        BottomNavigator.customIcon = 0;
                      });
                    } else if (i == 1) {
                      setState(() {
                        BottomNavigator.customIcon = 1;
                      });
                    }
                    else if (i == 2) {
                      setState(() {
                        BottomNavigator.customIcon = 2;
                      });
                    }
                    else if (i == 3) {
                      setState(() {
                        BottomNavigator.customIcon = 3;
                      });
                    }
                    else if (i == 4) {
                      setState(() {
                        BottomNavigator.customIcon = 4;
                      });
                    }
                  },
                  children: [
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      //child: Container(color: Colors.red,),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      //child: Container(color: Colors.deepPurple,),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      //child: Container(color: Colors.green,),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      //child: Container(color: Colors.yellow,),
                    ),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      //child: Container(color: Colors.black,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pressHomeButton() {
    HomePage.homePageController.animateToPage(2,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
