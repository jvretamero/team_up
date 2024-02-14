import 'dart:collection';

import 'package:flutter/material.dart';

class TeamViewModel extends ChangeNotifier {
  final List<String> _playerNames = [];

  int get playerCount => _playerNames.length;
  bool get isPlayersEmpty => _playerNames.isEmpty;
  List<String> get playersList => UnmodifiableListView(_playerNames);

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
}
