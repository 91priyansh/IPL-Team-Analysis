import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/model/batsman.dart';
import 'package:ipl_team_analysis/pages/batsmanPage.dart';
import 'package:ipl_team_analysis/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class BatsManTab extends StatefulWidget {
  final String team;
  BatsManTab({Key key,this.team}) : super(key: key);

  @override
  _BatsManTabState createState() => _BatsManTabState();
}

enum SortByHighest {avg,strike_rate,runs,sixs}


class _BatsManTabState extends State<BatsManTab> with AutomaticKeepAliveClientMixin{
  List<Batsman> _players = [];
  final TextEditingController _textEditingController = TextEditingController();
  SortByHighest sortByHighest = SortByHighest.runs; 
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getBatsmanData(context);
    });
  }

  void getBatsmanData(BuildContext context)  {
    if (!mounted) {
      //print('not mounted');
      return;
    }

    Future.delayed(Duration.zero,(){
        var provider = Provider.of<MainProvider>(context,listen: false);

      if(provider.batsmans.isEmpty){
        provider.changeIsLoading();
        provider.loadBatsmans().then((_){
          _players = provider.batsmans.where((player) => player.team == widget.team).toList();
          _players.sort((p1,p2) => p2.runs.compareTo(p1.runs));
          provider.changeIsLoading();
          setState(() {});
        });
      }
      else {
          _players = provider.batsmans.where((player) => player.team == widget.team).toList();
          _players.sort((p1,p2) => p2.runs.compareTo(p1.runs));
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
              builder: (context) => BatsmanPage(
                batsman: list[index],
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
              Text("Runs - ${list[index].runs}"),
              Text("Avg. - ${list[index].average.toStringAsFixed(2)}"),
              Text("SR - ${list[index].strikeRate.toStringAsFixed(2)}"),
              Text("6s - ${list[index].sixs}"),
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
        if(model.isLoading){
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
                                  RadioListTile<SortByHighest>(
                                    title: Text("Highest Runs"),
                                    value: SortByHighest.runs,
                                    groupValue: sortByHighest,
                                    onChanged: (SortByHighest value){
                                      setState(() {
                                        sortByHighest = value;
                                      });
                                      _players.sort((p1,p2) => p2.runs.compareTo(p1.runs));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<SortByHighest>(
                                    title: Text("Highest Average"),
                                    value: SortByHighest.avg,
                                    groupValue: sortByHighest,
                                    onChanged: (SortByHighest value){
                                      setState(() {
                                        sortByHighest = value;
                                      });
                                      _players.sort((p1,p2) => p2.average.compareTo(p1.average));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<SortByHighest>(
                                    title: Text("Highest Strike Rate"),
                                    value: SortByHighest.strike_rate,
                                    groupValue: sortByHighest,
                                    onChanged: (SortByHighest value){
                                      setState(() {
                                        sortByHighest = value;
                                      });
                                      _players.sort((p1,p2) => p2.strikeRate.compareTo(p1.strikeRate));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<SortByHighest>(
                                    title: Text("Highest 6s"),
                                    value: SortByHighest.sixs,
                                    groupValue: sortByHighest,
                                    onChanged: (SortByHighest value){
                                      setState(() {
                                        sortByHighest = value;
                                      });
                                      _players.sort((p1,p2) => p2.sixs.compareTo(p1.sixs));
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
                        return ListTile(
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(
                              builder: (context) => BatsmanPage(
                                batsman: _players[index],
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
                              Text("Runs - ${_players[index].runs}"),
                              Text("Avg. - ${_players[index].average.toStringAsFixed(2)}"),
                              Text("SR - ${_players[index].strikeRate.toStringAsFixed(2)}"),
                              Text("6s - ${_players[index].sixs}"),
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