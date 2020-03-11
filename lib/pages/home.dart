import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipl_team_analysis/pages/team.dart';
import 'package:ipl_team_analysis/provider/mainprovider.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      Provider.of<MainProvider>(context,listen: false).loadMatchInfo();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("IPL Team Analysis(2019)"),
        
      ),
      body: Center(
        child: Consumer<MainProvider>(
          builder: (context,model,_){
            if(model.isLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              return ListView.separated(
                separatorBuilder: (context,index){
                  return Divider();
                },
                itemCount: model.teams.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => Team(
                          team: model.teams[index],
                        )
                      ));
                    },
                    title: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("${model.teams[index]}"),
                    ),
                  );
                },
              );
            }
          },
        )
      ),
    );
  }
}
