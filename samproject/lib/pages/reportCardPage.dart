import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:samproject/pages/myQuestionPage.dart';

class ReportCardPage extends StatefulWidget {
  @override
  _ReportCardPageState createState() => _ReportCardPageState();
}

class _ReportCardPageState extends State<ReportCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("کارنامه")),
      ),
      body: SafeArea(
          child: StackedBarChart.withSampleData()
      ),
    );
  }
}
class StackedBarChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  StackedBarChart(this.seriesList, {this.animate});
  factory StackedBarChart.withSampleData() {
    return new StackedBarChart(
      _createSampleData2(),
      // Disable animations for image tests.
      animate: true,
    );
  }
  static List<charts.Series<ReportCardWidgetData,String>> _createSampleData2()
  {
    final studentData =
    [
      new ReportCardWidgetData("آزمون 1", 20, 10),
      new ReportCardWidgetData("آزمون 2", 10, 6),
      new ReportCardWidgetData("آزمون 3", 15, 15),
      new ReportCardWidgetData("آزمون 4", 18, 18),
      new ReportCardWidgetData("آزمون 5", 16, 11),
      new ReportCardWidgetData("آزمون 6", 8, 7),
      new ReportCardWidgetData("آزمون 7", 23, 20),
    ];
    return [
      new charts.Series<ReportCardWidgetData, String>(
        id: 'GradeExam',
        domainFn: (ReportCardWidgetData reportCard, _) => reportCard.examName,
        measureFn: (ReportCardWidgetData reportCard, _) => reportCard.examGrade - reportCard.studentGrade,
        data: studentData,
        //  colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        // fillColorFn: (_, __) => charts.MaterialPalette.transparent,
      ),
      new charts.Series<ReportCardWidgetData, String>(
        id: 'StudentExam',
        domainFn: (ReportCardWidgetData reportCard, _) => reportCard.examName,
        measureFn: (ReportCardWidgetData reportCard, _) => reportCard.studentGrade,
        data: studentData,
        // colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        //fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.lighter,
      ),

    ];
  }

  @override
  _StackedBarChartState createState() => _StackedBarChartState();
}

class _StackedBarChartState extends State<StackedBarChart> {
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    if (selectedDatum.length != 0)
    {
      print(selectedDatum.first.datum.examName);
      print(selectedDatum.first.datum.examGrade);
      print(selectedDatum.first.datum.studentGrade);
      //Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyQuestionPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      widget.seriesList,
      animate: widget.animate,
      barGroupingType: charts.BarGroupingType.stacked,
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          updatedListener: _onSelectionChanged,
        )
      ],
    );
  }
}

class ReportCardWidgetData
{
  final String examName;
  final int examGrade;
  final int studentGrade;

  ReportCardWidgetData(this.examName,this.examGrade,this.studentGrade);
}