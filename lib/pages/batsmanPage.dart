import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/model/batsman.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BatsmanPage extends StatelessWidget {
  final Batsman batsman;
  BatsmanPage({Key key,this.batsman}) : super(key: key);

  Widget getRunsInInning(BuildContext context) {
    List<RunsInInning> runList = [
      RunsInInning(
        inning: 1,
        run: batsman.firstInningRuns,
      ),
      RunsInInning(
        inning: 2,
        run: batsman.secondInningRuns
      )
    ];
    List<charts.Series<RunsInInning,String>> series = [];
    series.add(charts.Series<RunsInInning,String>(
      data: runList,
      domainFn: (RunsInInning runs,_) => runs.inning.toString(),
      id: "Runs In Innings",
      measureFn: (RunsInInning runs,_) => runs.run,
      //fillColorFn: (RunsInInning runs,_) => runs.inning == 1 ? charts.ColorUtil.fromDartColor(Colors.greenAccent) : charts.ColorUtil.fromDartColor(Colors.blueAccent),
      labelAccessorFn: (RunsInInning runs,_) => runs.run.toString(),
    ));

    return Container(
      height: MediaQuery.of(context).size.height * (0.5),
      child: charts.BarChart(
        series,
        animate: true,
        animationDuration: Duration(
          milliseconds: 500
        ),
        barRendererDecorator: charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.outside,
          outsideLabelStyleSpec: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.black),
            fontSize: 12
          )
        ),
        behaviors: [
                charts.ChartTitle("Innings",
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                ),
                charts.ChartTitle("Runs",
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                )
        ],
      ),
    );
  }  

  Widget runPercentage(BuildContext context,String type){
    //Type BF = "Ball Faced" , R = "Runs"
    List<RunsInPercentage> runList = [
      RunsInPercentage(
        color: Colors.redAccent.shade200,
        percentage: (batsman.dots*100)/batsman.ballFaced,
        run: 0
      ),
      RunsInPercentage(
        color: Colors.greenAccent.shade200,
        percentage: type == "BF" ? (batsman.ones*100)/batsman.ballFaced : (batsman.ones*1*100)/batsman.runs,
        run: 1
      ),
      RunsInPercentage(
        color: Colors.orangeAccent.shade200,
        percentage: type == "BF" ? (batsman.twos*100)/batsman.ballFaced : (batsman.twos*2*100)/batsman.runs,
        run: 2
      ),
      RunsInPercentage(
        color: Colors.green.shade700,
        percentage: type == "BF" ? (batsman.threes*100)/batsman.ballFaced : (batsman.threes*3*100)/batsman.runs,
        run: 3
      ),
      RunsInPercentage(
        color: Colors.purpleAccent.shade200,
        percentage: type == "BF" ? (batsman.fours*100)/batsman.ballFaced : (batsman.fours*4*100)/batsman.runs,
        run: 4
      ),
      RunsInPercentage(
        color: Colors.grey,
        percentage: type == "BF" ? (batsman.sixs*100)/batsman.ballFaced : (batsman.sixs*6*100)/batsman.runs,
        run: 6
      ),
    ];
    if(type == "R"){
      runList.removeAt(0);
    }
    List<charts.Series<RunsInPercentage,int>> series = [];

    series.add(charts.Series<RunsInPercentage,int>(
      data: runList,
      domainFn: (RunsInPercentage runs,_) => runs.run,
      id: type == "R" ? "Runs" : "Ball Faced",
      measureFn: (RunsInPercentage runs,_) => runs.percentage,
      colorFn: (RunsInPercentage runs,_) => charts.ColorUtil.fromDartColor(runs.color),
      labelAccessorFn: (RunsInPercentage runs,_) => runs.percentage.toStringAsFixed(2)
    ));

    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * (0.4),
      child: charts.PieChart(
        series,
        animate: true,
        animationDuration: Duration(milliseconds: 500),
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 80,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
              insideLabelStyleSpec: charts.TextStyleSpec(fontSize: 12,color: charts.Color.white,fontWeight: FontWeight.bold.toString())
            )
          ],
        ),
        behaviors: [
          charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.middleDrawArea,
            position: charts.BehaviorPosition.top
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //runPercentage();
    return Scaffold(
      appBar: AppBar(
        title: Text("${batsman.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Innings - ${batsman.innings}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),

              child: Text("Runs - ${batsman.runs}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Ball Faced - ${batsman.ballFaced}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: batsman.average == 0 ? Text("-") : Text("Avg - ${batsman.average.toStringAsFixed(2)}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: batsman.firstInningAverage == 0  ? Text("-") : Text("Avg in first inn. - ${batsman.firstInningAverage.toStringAsFixed(2)}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: batsman.secondInningAverage == 0 ? Text("-") : Text("Avg in second inn. - ${batsman.secondInningAverage.toStringAsFixed(2)}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),

            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("SR - ${batsman.strikeRate.toStringAsFixed(2)}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("HS - ${batsman.highestScore}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("NO - ${batsman.notOuts}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("100 - ${batsman.hundred}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              alignment: Alignment.centerLeft,
              child: Text("30 - ${batsman.thirty}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            SizedBox(
              height: 10,
            ),

            Divider(),
            Container(
              alignment: Alignment.center,
              child: Text("Runs At Batting 1/2",
              style: TextStyle(
                fontSize: 18
              ),
              ),
            ),
            getRunsInInning(context),
            Divider(),
            Container(
              alignment: Alignment.center,
              child: Text("Pie chart of Ball Faced",
              style: TextStyle(
                fontSize: 18
              ),
              ),
            ),
            Divider(),
            runPercentage(context,"BF"),
            Divider(),
            Container(
              alignment: Alignment.center,
              child: Text("Pie chart of Runs",
              style: TextStyle(
                fontSize: 18
              ),
              ),
            ),
            Divider(),
            runPercentage(context, "R"),
            
          ],
        ),
      )
    );
  }
}

class RunsInPercentage {
  int run;
  double percentage;
  Color color;

  RunsInPercentage({this.color,this.percentage,this.run});
}

class RunsInInning {
  int run;
  int inning;

  RunsInInning({this.run,this.inning});
}