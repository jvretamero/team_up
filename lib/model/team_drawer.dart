import 'dart:collection';
import 'dart:math';

class TeamDrawer {
  List<String> players;

  TeamDrawer(this.players);

  List<Team> draw() {
    var teamCount = calculateTeamCount(players.length);
    var teams = List.generate(teamCount, (index) => Team());
    var lastTeam = 0;

    var remainingPlayers = List.of(players);
    var random = Random();

    while (remainingPlayers.isNotEmpty) {
      var nextPlayerIndex = random.nextInt(remainingPlayers.length);
      var player = remainingPlayers.removeAt(nextPlayerIndex);
      teams[lastTeam].addPlayer(player);

      lastTeam++;
      lastTeam %= teams.length;
    }

    return teams;
  }

  static int calculateTeamCount(int numberOfPlayers, [int playerPerTeam = 5]) {
    var teamCount = numberOfPlayers / playerPerTeam;

    if (numberOfPlayers < 2) {
      teamCount = 0;
    }

    return teamCount.ceil();
  }
}

class Team {
  final List<String> _players = [];

  List<String> get players => UnmodifiableListView(_players);

  void addPlayer(String player) {
    _players.add(player);
  }
}
