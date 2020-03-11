import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/model/bowler.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RunsInPercentage {
  int run;
  double percentage;
  Color color;

  RunsInPercentage({this.color,this.percentage,this.run});
}


class BowlerPage extends StatelessWidget {
   final Bowler bowler; 
   BowlerPage({Key key,this.bowler}) : super(key: key);

  Widget runPercentage(BuildContext context){
    List<RunsInPercentage> runList = [
      RunsInPercentage(
        color: Colors.redAccent.shade200,
        percentage: (bowler.dots*100)/bowler.ballsExcludingExtras,
        run: 0
      ),
      RunsInPercentage(
        color: Colors.greenAccent.shade200,
        percentage: (bowler.ones*100)/bowler.ballsExcludingExtras,
        run: 1
      ),
      RunsInPercentage(
        color: Colors.orangeAccent.shade200,
        percentage: (bowler.twos*100)/bowler.ballsExcludingExtras,
        run: 2
      ),
      RunsInPercentage(
        color: Colors.green.shade700,
        percentage: (bowler.fours*100)/bowler.ballsExcludingExtras,
        run: 4
      ),
      RunsInPercentage(
        color: Colors.grey,
        percentage: (bowler.sixs*100)/bowler.ballsExcludingExtras,
        run: 6
      ),
    ];
    List<charts.Series<RunsInPercentage,int>> series = [];

    series.add(charts.Series<RunsInPercentage,int>(
      data: runList,
      domainFn: (RunsInPercentage runs,_) => runs.run,
      id: "Runs given",
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
    return Scaffold(
      appBar: AppBar(
        title: Text("${bowler.name}"),
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
              child: Text("Innings - ${bowler.inning}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Overs - ${bowler.balls ~/ 6}.${bowler.balls % 6}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Wickets - ${bowler.wickets}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Runs Given - ${bowler.runs}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Economy - ${bowler.economy.toStringAsFixed(2)}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child:bowler.average == 0.0 ? Text("-") : Text("Avg - ${bowler.average.toStringAsFixed(2)}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Wides - ${bowler.wides}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("No balls - ${bowler.noBalls}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text("Wickets in death - ${bowler.deathWickets}",style: TextStyle(
                fontSize: 17.5
              ),),             
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              child: Text("Pie chart of Runs given",
              style: TextStyle(
                fontSize: 18
              ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text("(Excluding extras and 3s)",
              style: TextStyle(
                fontSize: 14
              ),
              ),
            ),
            Divider(),
            runPercentage(context)
          ],
        ),
      ),
    );
  }
}