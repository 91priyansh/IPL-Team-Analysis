import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ipl_team_analysis/model/matchInfo.dart';

class PerformanceBarPlot extends StatefulWidget {
  final String title;
  final List<MatchInfo> matches;
  PerformanceBarPlot({Key key,this.title,this.matches}) : super(key: key);

  @override
  _PerformanceBarPlotState createState() => _PerformanceBarPlotState();
}

class _PerformanceBarPlotState extends State<PerformanceBarPlot> {

  final List<String> _oversType = ['PowerPlay','Middle Overs','Death Overs'];
  
  List<MatchRunRate> getDataForChart(String overType){
    List<MatchRunRate> _data = [];
    switch(overType){
      case 'BA PowerPlay' : {
        for(int i = 0;i < widget.matches.length;i++){
          if(widget.matches[i].battingPowerPlayRunRate != -1){
            _data.add(MatchRunRate(
              match: i + 1,
              rr: widget.matches[i].battingPowerPlayRunRate,
              result: widget.matches[i].result,
              wickets: widget.matches[i].battingPowerPlayWickets
            ));
          }
        }
        break;
      }
      case 'BA Middle Overs' : {
        for(int i = 0;i < widget.matches.length;i++){
          if(widget.matches[i].battingMiddleOverRunRate != -1){
            _data.add(MatchRunRate(
              match: i + 1,
              rr: widget.matches[i].battingMiddleOverRunRate,
              result: widget.matches[i].result,
              wickets: widget.matches[i].battingMiddlOvereWickets
            ));

          }
        }
        break;
      }
      case 'BA Death Overs' : {
        for(int i = 0;i < widget.matches.length;i++){
          if(widget.matches[i].battingDeathOverRunRate != -1){
            _data.add(MatchRunRate(
              match: i + 1,
              rr: widget.matches[i].battingDeathOverRunRate,
              result: widget.matches[i].result,
              wickets: widget.matches[i].battingDeathOverWickets
            ));
          }
        }
        break;
      }
      case 'BO PowerPlay' : {
        for(int i = 0;i < widget.matches.length;i++){
          if(widget.matches[i].bowlingPowerPlayEconomy != 1){
              _data.add(MatchRunRate(
              match: i + 1,
              rr: widget.matches[i].bowlingPowerPlayEconomy,
              result: widget.matches[i].result,
              wickets: widget.matches[i].bowlingPowerPlayWickets
            ));
          }
        }
        break;
      }
      case 'BO Middle Overs' : {
        for(int i = 0;i < widget.matches.length;i++){
          if(widget.matches[i].bowlingMiddleOverEconomy != -1){
            _data.add(MatchRunRate(
              match: i + 1,
              rr: widget.matches[i].bowlingMiddleOverEconomy,
              result: widget.matches[i].result,
              wickets: widget.matches[i].bowlingMiddleOverWickets
            ));
          }
        }
        break;
      }
      case 'BO Death Overs' : {
        for(int i = 0;i < widget.matches.length;i++){
          if(widget.matches[i].bowlingDeathOverEconomy != -1){
            _data.add(MatchRunRate(
              match: i + 1,
              rr: widget.matches[i].bowlingDeathOverEconomy,
              result: widget.matches[i].result,
              wickets: widget.matches[i].bowlingDEathOverWickets
            ));
          }
        }
        break;
      }

    }

    return _data;
  }

  Widget getBarChart(String overType) {
    List<charts.Series<MatchRunRate,String>> _seriesData = [];
    List<MatchRunRate> _data = getDataForChart(overType);  

    _seriesData.add(
      charts.Series<MatchRunRate,String>(
        data: _data,
        domainFn:( MatchRunRate match,_) => match.match.toString(),
        measureFn: (MatchRunRate match,_) => match.rr,
        id: overType+  "runrate",
        fillColorFn: (MatchRunRate match,_) => match.result == "Won" ?  charts.ColorUtil.fromDartColor( Colors.greenAccent) :  charts.ColorUtil.fromDartColor( Colors.lightBlueAccent),
        labelAccessorFn: (MatchRunRate match,_) => match.rr.round().toString(), 
      )
    );

    return Container(
      margin: EdgeInsets.only(
        top: 5
      ),
      color: Colors.grey.shade100,
      padding: EdgeInsets.symmetric(
        vertical: 10
      ),
      height: MediaQuery.of(context).size.height * (0.65),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 8,
                  width: 8,
                  color: Colors.greenAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Won",style: TextStyle(
                  fontSize: 12
                ),),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 8,
                  width: 8,
                  color: Colors.lightBlueAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Lost",style: TextStyle(
                  fontSize: 12
                ),)
              ],
            ),
          ),
          charts.BarChart(
            _seriesData,
            animate: false,
            barRendererDecorator: charts.BarLabelDecorator<String>(
              labelPosition: charts.BarLabelPosition.outside,
              outsideLabelStyleSpec: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(Colors.black),
                fontSize: 9
              )
            ),
            behaviors: [
              charts.ChartTitle("Match",
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
              ),
              widget.title == "Batting Run-rate" ? charts.ChartTitle("Run-rate",
                behaviorPosition: charts.BehaviorPosition.start,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
              ) : charts.ChartTitle("Economy",
                behaviorPosition: charts.BehaviorPosition.start,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
              )

            ],
          ),
        ],
      ), 
    );
  }

  Widget getScatterChart(String overType) {
    List<charts.Series<MatchRunRate,int>> _seriesData = [];
    List<MatchRunRate> _data = getDataForChart(overType); 

    _seriesData.add(
      charts.Series<MatchRunRate,int>(
        data: _data,
        id: overType + "run rate wickets",
        domainFn: (MatchRunRate match,_) => match.wickets,
        measureFn: (MatchRunRate match,_) => match.rr,
        displayName: "Run-rate and Wickets",
        colorFn: (MatchRunRate match,_) => match.result == "Won" ?  charts.ColorUtil.fromDartColor( Colors.greenAccent) :  charts.ColorUtil.fromDartColor( Colors.lightBlueAccent), 
      )
    ); 

    return Container(
      margin: EdgeInsets.only(
        top: 5
      ),
      color: Colors.grey.shade100,
      padding: EdgeInsets.symmetric(
        vertical: 10
      ),
      height: MediaQuery.of(context).size.height * (0.65),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 8,
                  width: 8,
                  color: Colors.greenAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Won",style: TextStyle(
                  fontSize: 12
                ),),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 8,
                  width: 8,
                  color: Colors.lightBlueAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Lost",style: TextStyle(
                  fontSize: 12
                ),)
              ],
            ),
          ),
          charts.ScatterPlotChart(
            _seriesData,
            animate: false,
          )
        ],
      ), 
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * (0.7),
          child: PageView.builder(
            itemCount: _oversType.length,
             
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_oversType[index],style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18
                        ),),
                        SizedBox(
                          width: 10,
                        ),
                        Text("(${index+1}/3)",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 13
                        ),),

                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    widget.title == "Batting Run-rate" ? getBarChart("BA " + _oversType[index]) : getBarChart("BO " + _oversType[index]),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MatchRunRate {
  int match;
  double rr;
  String result;
  int  wickets;

  MatchRunRate({this.match,this.rr,this.result,this.wickets});
}