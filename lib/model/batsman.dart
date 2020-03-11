//team	name	innings	runs	bf	
//notouts	hs	avg	strike_rate	runs_1	runs_2
//avg_1	avg_2	hundred	thirty	sixs	
//fours	dots	ones	twos	threes

class Batsman {
  final String team;
  final String name;
  final int innings;
  final int runs;
  final int ballFaced;
  final int notOuts;
  final int highestScore;
  final double average;
  final double strikeRate;
  final int firstInningRuns;
  final int secondInningRuns;
  final double firstInningAverage;
  final double secondInningAverage;
  final int hundred;
  final int thirty;
  final int sixs;
  final int dots;
  final int fours;
  final int ones;
  final int twos;
  final int threes;

  Batsman({this.average,this.ballFaced,this.dots,this.firstInningAverage,this.firstInningRuns,
    this.fours,this.highestScore,this.hundred,this.innings,this.name,this.notOuts,this.ones,
    this.runs,this.secondInningAverage,this.secondInningRuns,this.sixs,this.strikeRate,this.team,
    this.thirty,this.threes,this.twos
  });
  
  static Batsman fromJson(Map<String,dynamic> data){
    return Batsman(
      average: data['avg'] == "Inf" || data['avg'] == "NA" ? 0 : data['avg'].toDouble(),
      ballFaced: data['bf'],
      dots: data['dots'],
      firstInningAverage: data['avg_1'] == "Inf" || data['avg_1'] == "NA" ? 0 : data['avg_1'].toDouble(),
      firstInningRuns: data['runs_1'],
      fours: data['fours'],
      highestScore: data['hs'],
      hundred: data['hundred'],
      innings: data['innings'],
      name: data['name'],
      notOuts: data['notouts'],
      ones: data['ones'],
      runs: data['runs'],
      secondInningAverage: data['avg_2'] == "Inf" || data['avg_2'] == "NA" ? 0 : data['avg_2'].toDouble(),
      secondInningRuns: data['runs_2'],
      sixs: data['sixs'],
      strikeRate: data['strike_rate'].toDouble(),
      team: data['team'],
      thirty: data['thirty'],
      threes: data['threes'],
      twos: data['twos']
    );
  }

}