import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportButton extends StatefulWidget {
  @override
  _ReportButtonState createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("کارنامه آزمون"),
      onPressed: _launchURL,
    );
  }
}
