import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ipl_team_analysis/model/batsman.dart';
import 'package:ipl_team_analysis/model/bowler.dart';
import 'package:ipl_team_analysis/model/matchInfo.dart';

class MainProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isLoadingBowler = true;

  List<Batsman> batsmans = [];
  List<MatchInfo> matchInfos = [];
  List<Bowler> bowlers = [];

  List<String> teams = ["Royal Challengers Bangalore","Chennai Super Kings",
                        "Sunrisers Hyderabad","Kolkata Knight Riders",
                        "Delhi Capitals","Mumbai Indians",
                        "Kings XI Punjab","Rajasthan Royals"
                       ];

  void loadMatchInfo() async {
    String data = await rootBundle.loadString("assets/match_info.json");
    List<dynamic> list = json.decode(data);
    list.forEach((match){
      matchInfos.add(MatchInfo.fromJson(match));
    });
    print(matchInfos.length);
    changeIsLoading();
  }

  Future<void> loadBatsmans() async {
    String data = await rootBundle.loadString("assets/batsmans.json");
    var list = json.decode(data);
    list.forEach((player){
      batsmans.add(Batsman.fromJson(player));
    });
  }

  Future<void> loadBowlers() async {
    String data = await rootBundle.loadString("assets/bowlers.json");
    var list = json.decode(data);
    list.forEach((player){
      bowlers.add(Bowler.fromJson(player));
    });
  }

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeIsLoadingBowler() {
    isLoadingBowler = !isLoadingBowler;
    notifyListeners();
  }

}
