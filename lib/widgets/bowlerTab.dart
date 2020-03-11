import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/model/bowler.dart';
import 'package:ipl_team_analysis/pages/bowlerPage.dart';
import 'package:ipl_team_analysis/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class BowlerTab extends StatefulWidget {
  final String team;
  BowlerTab({Key key,this.team}) : super(key: key);

  @override
  _BowlerTabState createState() => _BowlerTabState();
}

enum SortBy {overs,eco,wickets}


class _BowlerTabState extends State<BowlerTab> with AutomaticKeepAliveClientMixin{
  List<Bowler> _players = [];
  final TextEditingController _textEditingController = TextEditingController();
  SortBy sortBy = SortBy.wickets; 
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getBowlerData(context);
    });
  }

  void getBowlerData(BuildContext context)  {
    if(!mounted){
      return ;
    }

    Future.delayed(Duration.zero,(){
      var provider = Provider.of<MainProvider>(context,listen: false);
      if(provider.bowlers.isEmpty){
        provider.loadBowlers().then((_){
          _players = provider.bowlers.where((player) => player.team == widget.team).toList();
          _players.sort((p1,p2) => p2.wickets.compareTo(p1.wickets));
          provider.changeIsLoadingBowler();
          setState(() {});
        });
      }
      else {
          _players = provider.bowlers.where((player) => player.team == widget.team).toList();
          _players.sort((p1,p2) => p2.wickets.compareTo(p1.wickets));
          setState(() {});  
      }
    });
  }

  Widget getSearchData() {
    var list = _players.where((player) => player.name.toLowerCase().contains(_textEditingController.text.trim().toLowerCase())).toList();
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context,index){
        return Divider();
      },
      itemBuilder: (context,index){
        return ListTile(
          onTap: (){
            Navigator.push(context, CupertinoPageRoute(
              builder: (context) => BowlerPage(
                bowler: list[index],
              )
            ));

          },
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 8
            ),
            child: Text("${list[index].name}"),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Innings - ${list[index].inning}"),
              Text("Wickets - ${list[index].wickets}"),
              Text("Overs - ${list[index].balls ~/ 6}.${list[index].balls % 6}"),
              Text("Economy - ${list[index].economy.toStringAsFixed(2)}"),
            ],
          )
        );
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<MainProvider>(
      builder: (context,model,_){
        if(model.isLoadingBowler){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        autocorrect: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Batsman",
                          contentPadding: EdgeInsets.only(
                            left: 15,
                            top: 3.5
                          ),
                          prefixIcon : Icon(Icons.search,),
                           
                        ),
                        onChanged: (value){
                          if(value.isEmpty){
                            setState(() {
                              isTyping = false;
                            });
                          }
                          else {
                            setState(() {
                              isTyping = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.close),
                    ),
                    onTap : (){
                      _textEditingController.clear();
                      FocusScope.of(context).unfocus();
                      setState(() {
                        isTyping = false;
                      });
                    }
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.sort),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: Text("Sort By"),
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile<SortBy>(
                                    title: Text("Wickets"),
                                    value: SortBy.wickets,
                                    groupValue: sortBy,
                                    onChanged: (SortBy value){
                                      setState(() {
                                        sortBy = value;
                                      });
                                      _players.sort((p1,p2) => p2.wickets.compareTo(p1.wickets));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<SortBy>(
                                    title: Text("Lowest Economy"),
                                    value: SortBy.eco,
                                    groupValue: sortBy,
                                    onChanged: (SortBy value){
                                      setState(() {
                                        sortBy = value;
                                      });
                                      _players.sort((p1,p2) => p1.economy.compareTo(p2.economy));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<SortBy>(
                                    title: Text("Highest Overs Balled"),
                                    value: SortBy.overs,
                                    groupValue: sortBy,
                                    onChanged: (SortBy value){
                                      setState(() {
                                        sortBy = value;
                                      });
                                      _players.sort((p1,p2) => p2.balls.compareTo(p1.balls));
                                      Navigator.pop(context);
                                    },
                                  ),

                                ],
                              )
                            ],
                          )
                        );
                      }
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    ListView.separated(
                      separatorBuilder: (context,index){
                        return Divider();
                      },
                      itemBuilder: (context,index){
                        var overs = _players[index].balls ~/ 6;
                        var overBall = _players[index].balls % 6;


                        return ListTile(
                          onTap: (){
                            
                            Navigator.push(context, CupertinoPageRoute(
                              builder: (context) => BowlerPage(
                                bowler: _players[index],
                              )
                            ));
                            
                          },
                          title: Padding(
                            padding: EdgeInsets.only(
                              bottom: 8
                            ),
                            child: Text("${_players[index].name}"),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Innings - ${_players[index].inning}"),
                              Text("Wickets - ${_players[index].wickets}"),
                              Text("Overs - $overs.$overBall"),
                              Text("Economy - ${_players[index].economy.toStringAsFixed(2)}"),
                            ],
                          )
                        );
                      },
                      itemCount: _players.length,
                    ),
                    isTyping ?  Container(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white
                    ) : Container(),  
                    isTyping  ? getSearchData() : Container()  
                  ],
                ),
              )
            ],
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}