//id	team	match_type	result	win_by_runs
//win_by_wickets	toss_result	toss_choice	
//batting_inning	ba_powerplay_rr	 ba_middleo_rr
//ba_deatho_rr	ba_powerplay_wickets	ba_middleo_wickets
//ba_deatho_wickets	ba_6s	ba_4s	
//bo_powerplay_ec	bo_powerplay_wickets	bo_middleo_ec	bo_middleo_wickets
//bo_deatho_ec	bo_deatho_wickets

class MatchInfo {
  final int id;
  final String team;
  final String matchType;
  final String result;
  final int winByRuns;
  final int winByWickets;
  final String tossResult;
  final String tossChoice;
  final int battingInning;
  final double battingPowerPlayRunRate;
  final double battingMiddleOverRunRate;
  final double battingDeathOverRunRate;
  final int battingPowerPlayWickets;
  final int battingMiddlOvereWickets;
  final int battingDeathOverWickets;
  final int sixs;
  final int fours;
  final double bowlingPowerPlayEconomy;
  final double bowlingMiddleOverEconomy;
  final double bowlingDeathOverEconomy;
  final int bowlingPowerPlayWickets;
  final int bowlingMiddleOverWickets;
  final int bowlingDEathOverWickets; 

  MatchInfo({this.battingDeathOverRunRate,this.battingDeathOverWickets,this.battingInning,
    this.bowlingPowerPlayEconomy,this.bowlingMiddleOverWickets,this.bowlingMiddleOverEconomy,
    this.bowlingDEathOverWickets,this.bowlingDeathOverEconomy,this.battingPowerPlayWickets,
    this.battingPowerPlayRunRate,this.battingMiddlOvereWickets,this.bowlingPowerPlayWickets,
    this.battingMiddleOverRunRate,this.fours,this.sixs,this.team,this.id,this.matchType,
    this.result,this.tossChoice,this.tossResult,this.winByRuns,this.winByWickets
  }); 

  static MatchInfo fromJson(Map<String,dynamic> data) {
    return MatchInfo(
      battingDeathOverRunRate: data['ba_deatho_rr'] == "NA" ? -1.0 : data['ba_deatho_rr'].toDouble(),
      battingDeathOverWickets: data['ba_deatho_wickets'],
      battingInning: data['batting_inning'],
      battingMiddleOverRunRate: data['ba_middleo_rr'] == "NA" ? -1.0 : data['ba_middleo_rr'].toDouble(),
      battingMiddlOvereWickets: data['ba_middleo_wickets'],
      battingPowerPlayRunRate: data['ba_powerplay_rr'] == "NA" ? -1.0 : data['ba_powerplay_rr'].toDouble(),
      battingPowerPlayWickets: data['ba_powerplay_wickets'],
      bowlingDeathOverEconomy: data['bo_deatho_ec'] == "NA" ? -1.0 : data['bo_deatho_ec'].toDouble(),        
      bowlingDEathOverWickets: data['bo_deatho_wickets'],
      bowlingMiddleOverEconomy: data['bo_middleo_ec'] == "NA" ? -1.0 : data['bo_middleo_ec'].toDouble(),
      bowlingMiddleOverWickets: data['bo_middleo_wickets'],
      bowlingPowerPlayEconomy: data['bo_powerplay_ec'] == "NA" ? -1.0 : data['bo_powerplay_ec'].toDouble(),
      bowlingPowerPlayWickets: data['bo_powerplay_wickets'],
      fours: data['ba_4s'],
      id: data['id'],
      matchType: data['match_type'],
      result: data['result'],
      sixs: data['ba_6s'],
      team: data['team'],
      tossChoice: data['toss_choice'],
      tossResult: data['toss_result'],
      winByRuns: data['win_by_runs'] == "" ? -1 : data['win_by_runs'],
      winByWickets: data['win_by_wickets'] == "" ? -1 :  data['win_by_wickets']
    );
  }
}