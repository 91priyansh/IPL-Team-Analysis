import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/model/matchInfo.dart';
import 'package:ipl_team_analysis/pages/performancebarplot.dart';
import 'package:ipl_team_analysis/pages/performancescatterplot.dart';
import 'package:ipl_team_analysis/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class Matches extends StatefulWidget {
  final String team;
  Matches({Key key,this.team}) : super(key: key);

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with AutomaticKeepAliveClientMixin{

  List<MatchInfo> _matches = [];





  @override
  void initState() {
    super.initState();
    getData(context);

  }  

  void getData(BuildContext context){
    Future.delayed(Duration.zero,(){
      _matches = Provider.of<MainProvider>(context,listen: false).matchInfos
      .where((match) => match.team == widget.team).toList();
      setState(() {});
    });
  }

  int getWonMatches(){
    return _matches.where((match) => match.result == "Won").toList().length;
  }

  int getNumberOfTossWon() {
    return _matches.where((match) => match.tossResult == "Won").toList().length;
  }

  int getNumberOfWinsWhileChasing() {
    return _matches.where((match) => match.result == "Won" &&  match.battingInning == 2).toList().length;
  }
  int getNumberOfTimeChased() {
    return _matches.where((match) => match.battingInning == 2).toList().length;
  }

  int getNumberOfWinsWhileDefending(){
    return _matches.where((match) => match.result == "Won" &&  match.battingInning == 1).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.5
                  ),
                  child: Text("Matches Played : ${_matches.length}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Won",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${getWonMatches()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Lost",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${_matches.length - getWonMatches()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
              ],
            ),
            RaisedButton(
              color: Colors.lightBlue,
              textColor: Colors.white,
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Select Plot For"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => PerformanceBarPlot(
                                  matches: _matches,
                                  title: "Batting Run-rate",
                                )
                              ));
                            },
                            title: Text("Batting Run-rate"),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => PerformanceScatterPlot(
                                  matches: _matches,
                                  title: "Batting Run-rate and Wickets",
                                )
                              ));
                            },
                            title:Text("Batting Run-rate and Wickets"),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => PerformanceBarPlot(
                                  matches: _matches,
                                  title: "Bowling Economy",
                                )
                              ));
                            },
                            title: Text("Bowling Economy"),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => PerformanceScatterPlot(
                                  matches: _matches,
                                  title: "Bowling Economy and Wickets",
                                )
                              ));
                            },
                            title:Text("Bowling Economy and Wickets"),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Text("Generate Plots"),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.5
                  ),
                  child: Text("Matches Chased : ${getNumberOfTimeChased()}",
                          style: TextStyle(
                            fontSize: 16,
                            
                          ),
                        ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Won",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${getNumberOfWinsWhileChasing()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Lost",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${getNumberOfTimeChased() - getNumberOfWinsWhileChasing()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
              ],
            ),            
            RaisedButton(
              color: Colors.lightBlue,
              textColor: Colors.white,
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Select Plot For"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            onTap: (){
                              var data = _matches.where((match) => match.battingInning == 2).toList();
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PerformanceBarPlot(
                                  title: "Batting Run-rate",
                                  matches: data,
                                ),
                                fullscreenDialog: true
                              ));

                            },
                            title: Text("Batting Run-rate"),
                          ),
                          ListTile(
                            onTap: (){
                              var data = _matches.where((match) => match.battingInning == 2).toList();
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PerformanceScatterPlot(
                                  title: "Batting Run-rate and Wickets",
                                  matches: data,
                                ),
                                fullscreenDialog: true
                              ));
                            },
                            title:Text("Batting Run-rate and Wickets"),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Text("Generate Plots"),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.5
                  ),
                  child: Text("Matches Defended : ${_matches.length - getNumberOfTimeChased()}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Won",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${getNumberOfWinsWhileDefending()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Lost",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${_matches.length - getNumberOfTimeChased() - getNumberOfWinsWhileDefending()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
              ],
            ),
            RaisedButton(
              color: Colors.lightBlue,
              textColor: Colors.white,
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Select Plot For"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            onTap: (){
                              var data = _matches.where((match) => match.battingInning == 1).toList();
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PerformanceBarPlot(
                                  title: "Bowling Economy",
                                  matches: data,
                                ),
                                fullscreenDialog: true
                              ));
                            },
                            title: Text("Bowling Economy"),
                          ),
                          ListTile(
                            onTap: (){
                              var data = _matches.where((match) => match.battingInning == 1).toList();
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PerformanceScatterPlot(
                                  title: "Bowling Economy and Wickets",
                                  matches: data,
                                ),
                                fullscreenDialog: true
                              ));
                            },
                            title:Text("Bowling Economy and Wickets"),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Text("Generate Plots"),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.5
                  ),
                  child: Text("Toss Result (${_matches.length})",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Won",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${getNumberOfTossWon()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Lost",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${_matches.length - getNumberOfTossWon()}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.5
                  ),
                  child: Text("Home Matches : ${_matches.where((match) => match.matchType == "Home").toList().length}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Won",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${_matches.where((match) => match.matchType == "Home" && match.result == "Won").toList().length}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Lost",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${_matches.where((match) => match.matchType == "Home" && match.result == "Lost").toList().length}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.5
                  ),
                  child: Text("Away Matches : ${_matches.where((match) => match.matchType == "Away").toList().length}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Won",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${_matches.where((match) => match.matchType == "Away" && match.result == "Won").toList().length}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Text("Lost",style: TextStyle(
                        fontSize: 15.5
                      ),),
                    ),
                    Container(
                      child: Text("${_matches.where((match) => match.matchType == "Away" && match.result == "Lost").toList().length}",style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

