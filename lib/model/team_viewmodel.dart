import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teamup/model/team.dart';

class TeamViewModel extends ChangeNotifier {
  final List<String> _playerNames = [];
  final int _playerPerTeam = 5;

  int get playerCount => _playerNames.length;
  bool get isPlayersEmpty => _playerNames.isEmpty;
  List<String> get playersList => UnmodifiableListView(_playerNames);
  int get teamCount {
    var teamCount = playerCount / _playerPerTeam;

    if (playerCount < 2) {
      teamCount = 0;
    }

    return teamCount.ceil();
  }

  void addPlayer(String name) {
    _playerNames.add(name);
    notifyListeners();
  }

  String getPlayer(int index) {
    return _playerNames[index];
  }

  void removePlayerAt(int index) {
    _playerNames.removeAt(index);
    notifyListeners();
  }

  List<Team> generateTeams() {
    var teams = List.generate(teamCount, (index) => Team());
    var lastTeam = 0;

    var remainingPlayers = List.of(_playerNames);
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
}
