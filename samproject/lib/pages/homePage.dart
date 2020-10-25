import 'package:flutter/material.dart';
import 'package:samproject/Layout/BottomNavigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.home),backgroundColor: Colors.deepPurple,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
