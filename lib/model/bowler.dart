class Bowler {
  final String name;
  final String team;
  final int inning;
  final int balls;
  final int wickets;
  final double economy;
  final int deathWickets;
  final int noBalls;
  final int wides;
  final double average;
  final int ballsExcludingExtras;
  final int dots;
  final int ones;
  final int twos;
  final int fours;
  final int sixs;
  final int runs;

  Bowler({
    this.average,this.dots,this.fours,this.name,this.sixs,this.twos,this.balls,this.ballsExcludingExtras,this.deathWickets,
    this.economy,this.noBalls,this.ones,this.team,this.wickets,this.wides,this.inning,this.runs
  });

  static Bowler fromJson(Map<String,dynamic> data) {
    return Bowler(
      average: data['avg'] == "Inf" ? 0.0 : data['avg'].toDouble(),
      balls: data['balls'],
      ballsExcludingExtras: data['balls_ex_extra'],
      deathWickets: data['death'],
      dots: data['dots'],
      economy: data['economy'].toDouble(),
      fours: data['fours'],
      inning: data['innings'],
      name: data['name'],
      noBalls: data['no_balls'],
      ones: data['ones'],
      sixs: data['sixs'],
      team: data['team'],
      twos: data['twos'],
      wickets: data['wickets'],
      wides: data['wides'],
      runs: data['runs']

    );
  }
}