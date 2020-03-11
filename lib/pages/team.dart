import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/widgets/batsmanTab.dart';
import 'package:ipl_team_analysis/widgets/bowlerTab.dart';
import 'package:ipl_team_analysis/widgets/matches.dart';

class Team extends StatefulWidget {
  final String team;
  Team({Key key,this.team}) : super(key: key);

  @override
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<Team> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }  

   @override
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.team}"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text("Matches"),
            ),
            Tab(
              child: Text("Batsman"),
            ),
            Tab(
              child: Text("Bowler")
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Matches(
            key: PageStorageKey(1),
            team: widget.team,
          ),
          BatsManTab(
            team: widget.team,
            key: PageStorageKey(2),
          ),
          BowlerTab(
            key: PageStorageKey(3),
            team: widget.team,
          )
        ],
        controller: _tabController,
      ),
    );
  }
}
