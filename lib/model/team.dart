import 'dart:collection';

class Team {
  final List<String> _players = [];

  List<String> get players => UnmodifiableListView(_players);

  void addPlayer(String player) {
    _players.add(player);
  }
}