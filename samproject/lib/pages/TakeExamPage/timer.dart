import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class TimerWidget extends StatefulWidget {
  DateTime StartUserExam;
  int ExamLenght;
  DateTime EndExam;
  VoidCallback EndTimerFunction;
  TimerWidget({Key key, this.StartUserExam,this.EndExam,this.ExamLenght,this.EndTimerFunction = null}) : super(key: key);
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int endTime;
  @override
  void initState() {

    super.initState();
    if (widget.StartUserExam.add(Duration(minutes: widget.ExamLenght)).isBefore(widget.EndExam))
    {
      endTime = widget.StartUserExam.add(Duration(minutes: widget.ExamLenght)).millisecondsSinceEpoch;
    }
    else
      {
        endTime = widget.EndExam.millisecondsSinceEpoch;
      }
  }
  @override
  Widget build(BuildContext context) {
    return CountdownTimer(endTime: endTime,onEnd: widget.EndTimerFunction,);
  }
}
