class FootballMatch {
  final String id;
  final String team1Name;
  final String team2Name;
  final int team1Score;
  final int team2Score;
  final String winnerTeam;
  final bool isRunning;

  FootballMatch({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Score,
    required this.team2Score,
    required this.winnerTeam,
    required this.isRunning,
  });

  factory FootballMatch.fromJson(String docId, Map<String, dynamic> jsonData) {
    return FootballMatch(
      id: docId,
      team1Name: jsonData['team1_name'],
      team2Name: jsonData['team2_name'],
      team1Score: jsonData['team1_score'],
      team2Score: jsonData['team2_score'],
      winnerTeam: jsonData['winner_team'],
      isRunning: jsonData['is_running'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team1_name': team1Name,
      'team2_name': team2Name,
      'team1_score': team1Score,
      'team2_score': team2Score,
      'winner_team': winnerTeam,
      'is_running': isRunning,
    };
  }
}
